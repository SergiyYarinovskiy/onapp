require 'spec_helper'

describe Ticket do
  let!(:status) { create(:status) }
  let(:ticket) { create(:ticket) }

  it 'returns ticket by status id' do
    found_ticket = Ticket.find_by_statuses(ticket.status.id).first
    expect(ticket).to eql found_ticket
  end

  describe 'callbacks before create' do
    it 'creates ticket with code' do
      expect(ticket.code).to match code_matcher
    end

    it 'creates ticket with status' do
      expect(ticket.status_id).not_to be_nil
    end
  end

  describe 'callback after update' do
    it 'creates reply after status was changed' do
      status = create(:status, name: 'new_status')
      ticket.update_attribute(:status_id, status.id)
      expect(ticket.replies).not_to be_empty
    end

    it 'creates reply after owner was changed' do
      new_admin_user = create(:new_admin_user)
      ticket.update_attribute(:admin_user_id, new_admin_user.id)
      expect(ticket.replies).not_to be_empty
    end
  end
end # describe Ticket
