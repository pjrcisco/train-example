#require_relative "../../SPARK"
require_relative "../../Utility/Methods"

module API

  def self.list_memberships_uri
    "/memberships"
  end



  module REST
  module Memberships

    def self.list(token, params={})
      Utility.spark_it(token, API.list_memberships_uri, params)
    end

    def self.create(token, params={})
      Utility.create_spark(token, API.list_memberships_uri, params)
    end

    def self.get_details(token, id)
      Utility.spark_it(token, API.list_memberships_uri + "/#{id}")
    end

    def self.update(token, id, params={})
      Utility.update_spark(token, API.list_memberships_uri + "/#{id}", parmams)
    end

    def self.delete(token, id)
      Utility.delete_spark(token, API.list_memberships_uri + "/#{id}")
    end


  end
  end

end