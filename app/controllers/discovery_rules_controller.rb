class DiscoveryRulesController < ApplicationController
  # Two-pane searching must be disabled for rules otherwise query completion will not work
  #include Foreman::Controller::AutoCompleteSearch

  before_filter :find_resource, :only => [:edit, :update, :destroy, :enable, :disable, :auto_provision]

  def index
    base = resource_base.search_for(params[:search], :order => (params[:order] || 'priority ASC'))
    @discovery_rules = base.paginate(:page => params[:page]).includes(:hostgroup)
  end

  def new
    @discovery_rule = DiscoveryRule.new
  end

  def create
    @discovery_rule = DiscoveryRule.new(params[:discovery_rule])
    if @discovery_rule.save
      process_success
    else
      process_error
    end
  end

  def edit
  end

  def update
    if @discovery_rule.update_attributes(params[:discovery_rule])
      process_success
    else
      process_error
    end
  end

  def destroy
    if @discovery_rule.destroy
      process_success
    else
      process_error
    end
  end

  def enable
    set_enabled true
  end

  def disable
    set_enabled false
  end

  private

  def action_permission
    case params[:action]
    when 'enable', 'disable'
      :edit
    else
      super
    end
  end

  def set_enabled(enabled)
    @discovery_rule.enabled = enabled
    if @discovery_rule.save
      process_success :success_msg => (enabled ? _('Rule enabled') : _('Rule disabled')), :success_redirect => :back
    else
      process_error
    end
  end
end
