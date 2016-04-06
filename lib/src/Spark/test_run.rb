require_relative 'API/REST/People'
require_relative 'API/REST/Rooms'
require_relative 'API/REST/Memberships'
require_relative 'API/REST/Messages'
require 'json'

def token
  "OTNmNzRlNzEtNmZmMy00ZjcwLThiMjMtZGJhY2FiYjUzZjlhZmRmODg4MWUtMzJi"
end

def json(input)
  puts JSON.pretty_generate(input)
end


def get_people_list
  params = {
    "name": "pat",
    "email": "priel@cisco.com",
    "max": 25
  }
  results = []
  res = API::REST::People.list(token, params)
  res["items"].each do |person|
    results << person
  end
  results
end

def get_person_details
  list = get_people_list
  p0   = list[0]
  res  = API::REST::People.get_person_details(token, p0["id"])
end

def get_my_details
  res = API::REST::People.get_my_details(token)
end


def get_rooms_list
  params = {
    "showSipAddress": true,
    "max": 25
  }
  results = []
  res = API::REST::Rooms.list(token, params)
  res["items"].each do |room|
    results << room
  end
  results
end

def create_room
  name = "Train Event Test Room"
  res  = API::REST::Rooms.create(token, name)
end

def get_room
  list = get_rooms_list
  r0   = list[0]
  res  = API::REST::Rooms.get(token, r0["id"])
end


def update_room
  name = "Pat rename me again "
  list = get_rooms_list
  r0   = list[0]
  res  = API::REST::Rooms.update(token, r0["id"], name)
end

def delete_room
  list = get_rooms_list
  r0   = list[0]
  res  = API::REST::Rooms.delete(token, r0["id"])
end

def list_memberships
  list = get_rooms_list
  r0   = list[0]
  params = {
    #{}"roomId": r0["id"],
    #{}"personId": "",
    "personEmail": "pjrcisco@gmail.com",
    "max": 25
  }
  results = []
  res = API::REST::Memberships.list(token, params)
  res["items"].each do |membership|
    results << membership
  end
  results
end

def create_membership(id, email)
  params = {
    "roomId": id,
    "personEmail": email,
    "isModerator": false
  }
  res  = API::REST::Memberships.create(token, params)
end

def get_membership_details(id)
  res = API::REST::Memberships.get_details(token, id)
end

def train_flow_example
  puts "creating room....."
  res = create_room
  json res
  puts "\n\n"
  puts "adding priel@cisco.com to #{res["title"]}....."
  res = create_membership(res["id"], "priel@cisco.com")
  json res
  puts "\n\n"
  puts "getting membership details....."
  res = get_membership_details(res["id"])
  json res
  puts "\n\n"
  puts "deleting room....."
  json delete_room
  puts "\n\n"
end



##### -> send_message(text, files, room_id, to_person_id, to_person_email)
##### -> sending a 1v1 message or sending a message to a room
##### -> one of the id's/email must be non nil
##### -> a file must be a publicly available url
#####
##### -> returns: a json array

def send_message(text, files, room_id, to_person_id, to_person_email)
  params = {
    "text": text,
    "files": files,
    "room_id": room_id,
    "toPersonId": to_person_id,
    "toPersonEmail": to_person_email
  }
  res = API::REST::Messages.create(token, params)
end

# json send_message


# json train_flow_example

# json get_people_list
# json get_person_details
# json get_my_details

# json get_rooms_list
# json delete_room
# json get_room
# json update_room
# json create_room
# train_flow_example
# json list_memberships