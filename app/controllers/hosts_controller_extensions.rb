module HostsControllerExtensions
  extend ActiveSupport::Concern

  included do
    # execute callbacks
  end

  # Override this method to look for Hosts in more ways
  def find_by_name
    Rails.logger.info "Overriding HostsConstoller.find_by_name from ForemanDiscovery"
    # find host first, if we fail, do nothing
    params[:id].downcase! if params[:id].present?
    # can't call super, as super will render errors when a host is not_found, while
    # we want to continue searching...
    super_without_notfound
    # Discovered Hosts change name and type at once, making them hard to find...
    if ( params[:host] and params[:host][:mac] )
      @host = Host::Base.find_by_mac params[:host][:mac]
    end
    # Ok, now we can call super, just to process the not_found error
    super unless @host
    return false unless @host
    deny_access and return unless User.current.admin? or Host.my_hosts.include?(@host)
  end

  def super_without_notfound
    return if (id = params[:id]).blank?
    # determine if we are searching for a numerical id or plain name
    cond = "find_by_" + ((id =~ /^\d+$/ && (id=id.to_i)) ? 'id' : 'name')
    @host = Host::Base.send(cond, id)
  end

end
