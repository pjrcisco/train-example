require 'json'
module Utility
  class Response

    def initialize(args={})
      @data = args
    end

    def json
      @data.to_json
    end

  end
end