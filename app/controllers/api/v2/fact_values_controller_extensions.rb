module Api
  module V2
    module FactValuesControllerExtensions
      extend ActiveSupport::Concern

      included do
        api :GET, "/discovered_hosts/:discovered_host_id/facts/", N_("List all fact values of a given discovered host")
      end
    end
  end
end