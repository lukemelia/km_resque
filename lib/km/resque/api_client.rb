require 'km/resque'

module KM
  class Resque
    class ApiClient
      def alias(identifier1, identifier2, timestamp)
        hit('a', { '_n' => identifier2,
                   '_p' => identifier1,
                   '_t' => timestamp
                 })
      end

      def record(identifier, event_name, properties, timestamp)
        hit('e', { '_p' => identifier,
                   '_n' => event_name,
                   '_t' => timestamp
                 }.merge(properties))
      end

      def set(identifier, properties, timestamp)
        hit('s', { '_p' => identifier,
                   '_t' => timestamp
                 }.merge(properties))
      end

      def api_key
        @api_key ||= KM::Resque.configuration.key
      end

      def host
        @host ||= KM::Resque.configuration.host
      end

      def port
        @port ||= KM::Resque.configuration.port
      end

    private

      def hit(type, data)
        unless data['_p']
          raise Error.new("Can't hit the API without an identity")
        end

        data['_k'] = api_key
        unless data['_k']
          raise Error.new("Can't hit the API without an API Key")
        end

        data['_d'] = 1 if data['_t']
        data['_t'] ||= Time.now.to_i

        unsafe = Regexp.new("[^#{URI::REGEXP::PATTERN::UNRESERVED}]", false, 'N')

        query_parts = []
        query = ''
        data.inject(query) do |query, key_val|
          query_parts <<  key_val.collect { |i| URI.escape(i.to_s, unsafe) }.join('=')
        end
        query = '/' + type + '?' + query_parts.join('&')
        proxy = URI.parse(ENV['http_proxy'] || ENV['HTTP_PROXY'] || '')
        res = Net::HTTP::Proxy(proxy.host, proxy.port, proxy.user, proxy.password).start(host, port) do |http|
          http.get(query)
        end
      end
    end
  end
end
