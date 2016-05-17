class Reply < ActiveRecord::Base
  belongs_to :admin_user
  belongs_to :ticket

  validates_presence_of :body
end
