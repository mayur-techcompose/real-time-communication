class Message < ApplicationRecord
  belongs_to :user
  after_create_commit { ActionCable.server.broadcast 'room_channel', message: self }
end
