class Host::Discovered < ::Host::Base

  def self.model_name
    ActiveModel::Name.new(Host)
  end

end
