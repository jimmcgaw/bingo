class User < ActiveRecord::Base
  validates_presence_of :screen_name, :email
end
