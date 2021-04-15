module ForemanDiscovery::NodeAPI
  class NodeResource
    include Foreman::TelemetryHelper

    def initialize(args)
      raise ArgumentError, "Options must be hash" unless args.is_a?(Hash)
      raise ArgumentError, "Option 'url' must be provided" unless args[:url]
      @args = args
      @connect_params = {
        :headers => { :accept => :json },
        :timeout => 20, # tighter timeout, discovery performs up to two calls per request
      }

      if url.match(/^https/i) && Rails.env != "test"
        if is_proxy?
          logger.debug "Connecting to proxy, setting up SSL client cert"
          cert         = Setting[:ssl_certificate]
          ca_cert      = Setting[:ssl_ca_file]
          hostprivkey  = Setting[:ssl_priv_key]

          @connect_params.merge!(
            :ssl_client_cert  =>  OpenSSL::X509::Certificate.new(File.read(cert)),
            :ssl_client_key   =>  OpenSSL::PKey::RSA.new(File.read(hostprivkey)),
            :ssl_ca_file      =>  ca_cert,
            :verify_ssl       =>  OpenSSL::SSL::VERIFY_PEER
          )
        else
          logger.debug "Connecting without proxy, not using SSL client cert"
          @connect_params.merge!(
            :verify_ssl       =>  OpenSSL::SSL::VERIFY_NONE
          )
        end
      end
    end

    def url
      @args[:url]
    end

    def scheme
      URI.parse(url).scheme
    rescue Exception => e
      raise ArgumentError, "Option 'url' must be valid URI: #{e}"
    end

    def port
      URI.parse(url).port
    rescue Exception => e
      raise ArgumentError, "Option 'url' must be valid URI: #{e}"
    end

    def root_path
      URI.parse(url).path
    rescue Exception => e
      raise ArgumentError, "Option 'url' must be valid URI: #{e}"
    end

    def is_proxy?
      root_path.starts_with?('/discovery')
    end

    protected

    attr_reader :connect_params

    def resource
      @resource ||= RestClient::Resource.new(url, connect_params)
    end

    def logger; Rails.logger; end

    private

    def parse(response)
      if response and response.code >= 200 and response.code < 300
        return response.body.present? ? JSON.parse(response.body) : {}
      else
        raise ::Foreman::Exception.new(N_("Image API returned HTTP/%{code} with '%{body}"), :body => response.body, :code => response.code)
      end
    rescue => e
      raise ::Foreman::WrappedException.new(e, N_("Image API processing error: %{msg} (HTTP/%{code}, body: %{body})"), :msg => e.to_s, :body => response.try(:body), :code => response.try(:code))
    end

    def get(payload = {}, path = nil)
      logger.debug("Image API GET #{url} (path=#{path}, payload=#{payload})")
      telemetry_duration_histogram(:discovery_request_duration, :ms, method: 'get') do
        if path
          resource[URI.escape(path)].get payload
        else
          resource.get payload
        end
      end
    rescue
      telemetry_increment_counter(:discovery_failed_requests)
      raise
    end

    def post(payload, path = nil)
      logger.debug("Image API POST #{url} (path=#{path}, payload=#{payload})")
      telemetry_duration_histogram(:discovery_request_duration, :ms, method: 'post') do
        if path
          resource[path].post payload
        else
          resource.post payload
        end
      end
    rescue
      telemetry_increment_counter(:discovery_failed_requests)
      raise
    end

    def put(payload, path = nil)
      logger.debug("Image API PUT #{url} (path=#{path}, payload=#{payload})")
      telemetry_duration_histogram(:discovery_request_duration, :ms, method: 'put') do
        if path
          resource[path].put payload
        else
          resource.put payload
        end
      end
    rescue
      telemetry_increment_counter(:discovery_failed_requests)
      raise
    end

    def delete(path)
      logger.debug("Image API DELETE #{url} (path=#{path})")
      telemetry_duration_histogram(:discovery_request_duration, :ms, method: 'delete') do
        if path
          resource[path].delete
        else
          resource.delete
        end
      end
    rescue
      telemetry_increment_counter(:discovery_failed_requests)
      raise
    end
  end
end
