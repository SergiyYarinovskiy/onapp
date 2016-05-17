class Status < ActiveRecord::Base
  DEFAULT_STATUS = 'Waiting for Staff Response'.freeze
  WAIT_CUSTOMER = 'Waiting for Customer'.freeze
  ON_HOLD = 'On Hold'.freeze
  CANCELED = 'Cancelled'.freeze
  COMPLETED = 'Completed'.freeze

  has_many :tickets

  validates_uniqueness_of :name
  validates_presence_of :name

  scope :ids_by_name, ->(names) { where(name: names).pluck(:id) }

  def self.filter_ids(statuses)
    names = []
    statuses ||= []

    names << Status::DEFAULT_STATUS if statuses.include? '1'
    names << Status::WAIT_CUSTOMER if statuses.include? '2'
    names << Status::ON_HOLD if statuses.include? '3'
    names.concat([Status::CANCELED, Status::COMPLETED]) if statuses.include? '4'

    Status.ids_by_name names
  end
end
