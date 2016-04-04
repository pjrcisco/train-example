require 'src/Utility/Response'

require_relative 'Sessions'
require_relative 'Routes'
require_relative '../Client'
require 'json'

module Tropo
  def self.execute(params={})
    records = ::Phone.all
    records.each do |record|
      tropo_session(record.phone_number, record.message)
    end
    Utility::Response.new({
      "status": 200
    })
  end

  def self.headers
    headers = {
      "accept": "application/json",
      "content-type": "application/json"
    }
  end

  def self.tropo_session(number, message)
    session = Tropo::Sessions.new({
      token: "55724d51445172465247475a7a72506a5a6b7445747a6e4444554a64584a6c4b7641676568744a6659464b72",
      numbers: number,
      message: message,
    })
    res = Client.post_it(Tropo::Routes.sessions, headers, session.body)
  end

end
