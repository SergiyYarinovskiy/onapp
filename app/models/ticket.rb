class Ticket < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  has_many :replies
  belongs_to :status
  belongs_to :admin_user

  before_create :set_code, :set_status
  after_save :create_reply_status, if: :status_id_changed?
  after_save :create_reply_admin_user, if: :admin_user_id_changed?

  validates_presence_of :name, :subject, :email, :department, :description
  validates :email, email: true

  scope :find_by_statuses, ->(statuses) { where(status_id: statuses) }

  private

  def set_code
    begin
      self.code = Generator.ticket_random_code
    end while Ticket.exists?(code: code)
  end

  def set_status
    self.status = Status.find_by_name Status::DEFAULT_STATUS
  end

  def create_reply_status
    Reply.create(
      ticket_id: id,
      admin_user_id: 1,
      body: I18n.t('strings.status_changed_reply', status_name: status.name)
    )
  end

  def create_reply_admin_user
    Reply.create(
      ticket_id: id,
      admin_user_id: 1,
      body: I18n.t(
        'strings.admin_user_changed_reply',
        admin_user_email: admin_user.email
      )
    )  
  end
end
