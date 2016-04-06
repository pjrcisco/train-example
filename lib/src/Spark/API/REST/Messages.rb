#require_relative "../../SPARK"
require_relative "../../Utility/Methods"

module API

  def self.list_messages_uri
    "/messages"
  end



  module REST
  module Messages

    def self.list(token, params={})
      Utility.spark_it(token, API.list_messages_uri, params)
    end

    def self.create(token, params={})
      Utility.create_spark(token, API.list_messages_uri, params)
    end

    def self.get_details(token, id)
      Utility.spark_it(token, API.list_messages_uri + "/#{id}")
    end

    def self.delete(token, id)
      Utility.delete_spark(token, API.list_messages_uri + "/#{id}")
    end

  end
  end

end