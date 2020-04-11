class Ticket < ApplicationRecord
  belongs_to :order
  belongs_to :ticket_type

  before_validation :check_capacity
  before_save :update_stats_save
  before_destroy :update_stats_destroy

  private
  def update_stats_save
    es = self.ticket_type.event.event_stat
    es.tickets_sold =+ 1
    es.attendance =+ 1
    es.save!
  end

  private
  def update_stats_destroy
    es = self.ticket_type.event.event_stat
    es.tickets_sold =- 1
    es.attendance =- 1
    es.save!
  end

  private
  def check_capacity
    es = self.ticket_type.event.event_stat
    ev = self.ticket_type.event.event_venue

    if es.ticket_sold > ev.capacity
      errors.add(:capacity, "amount of tickets sold for an event surpasses the capacity of the corresponding event venue")
      throw(:abort)
    end
  end
end
