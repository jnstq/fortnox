module Fortnox
  class API
    include HTTParty

    base_uri  'https://api.fortnox.se/ext/'
    format    :xml

    class << self
      attr_accessor :last_response

      def establish_connection(*args); end

      def connection
        { :token => ENV['fortnox_token'], :db => ENV['fortnox_database'] }
      end

      def run(method, call, attributes={})
        query_parameters = attributes[:query] || {}
        self.last_response = self.send(method, "/#{call.to_s}.php", {
          :query  => query_parameters.merge(connection),
          :body   => {:xml => build_xml(attributes)}
        })
      end

      private

      def build_xml(attributes)
        attributes.delete(:query) if attributes[:query]
        @@xml = Gyoku.xml(attributes)
      end
    end
  end
end
