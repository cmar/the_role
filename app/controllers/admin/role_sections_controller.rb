class Admin::RoleSectionsController < ApplicationController
  layout 'the_role'

  before_filter :login_required
  before_filter :role_required

  before_filter :role_find,           :only => [:create, :create_rule, :rule_on, :rule_off, :destroy, :destroy_rule]
  before_filter :owner_required,      :only => [:create, :create_rule, :rule_on, :rule_off, :destroy, :destroy_rule]

  def create
    if @role.create_section params[:section_name]
      flash[:notice] = t 'the_role.section_created'
    else
      flash[:error]  = t 'the_role.section_not_created'
    end
    redirect_to_edit
  end
  
  def create_rule
    if @role.create_rule params[:section_name], params[:rule_name]
      flash[:notice] = t 'the_role.section_rule_created'
    else
      flash[:error]  = t 'the_role.section_rule_not_created'
    end
    redirect_to_edit
  end

  def rule_on
    section_name = params[:id]
    rule_name    = params[:name]
    if @role.rule_on section_name, rule_name
      flash[:notice] = t 'the_role.section_rule_on'
    else
      flash[:error]  = t 'the_role.state_not_changed'
    end
    redirect_to_edit
  end

  def rule_off
    section_name = params[:id]
    rule_name    = params[:name]
    if @role.rule_off section_name, rule_name
      flash[:notice] = t 'the_role.section_rule_off'
    else
      flash[:error]  = t 'the_role.state_not_changed'
    end
    redirect_to_edit
  end
  
  def destroy
    section_name = params[:id]
    if @role.delete_section section_name
      flash[:notice] = t 'the_role.section_deleted'
    else
      flash[:error]  = t 'the_role.section_not_deleted'
    end
    redirect_to_edit
  end
  
  def destroy_rule
    section_name = params[:id]
    rule_name    = params[:name]
    if @role.delete_rule section_name, rule_name
      flash[:notice] = t 'the_role.section_rule_deleted'
    else
      flash[:error]  = t 'the_role.section_rule_not_deleted'
    end
    redirect_to_edit
  end

  protected

  def role_find
    @role = Role.find params[:role_id]
    @ownership_checking_object = @role
  end

  def redirect_to_edit
    redirect_to edit_admin_role_path @role
  end
end