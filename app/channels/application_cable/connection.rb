module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # identified_by :current_user

    # def connect
    #   self.current_user = find_verified_user
    #   binding.pry
    # end

    # protected

    # def find_verified_user
    #   User.find_by(id: session["user_id"])
    # end
  end
end
