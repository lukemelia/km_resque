module KM
  class Resque
    class Configuration
      attr_accessor :key

      attr_writer :host
      def host
        @host ||= 'trk.kissmetrics.com'
      end

      attr_writer :port
      def port
        @port ||= 80
      end
    end
  end
end
