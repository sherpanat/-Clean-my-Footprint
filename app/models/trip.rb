class Trip < ApplicationRecord
  attr_accessor :num_return, :recurring, :occasional, :number_per, :time_unit, :date_since, :number_of_times

  belongs_to :user
  belongs_to :transportation
  #validates :transportation_id, presence: true #???
  belongs_to :compensation, optional: true
  validates :km, presence: true, numericality: { greater_than: 0 }
  validates :number, numericality: { greater_than: 0 }
  validates :start_address, presence: true
  validates :destination_address, presence: true
  geocoded_by :start_address
  after_validation :geocode
  scope :pending, -> { where(compensation_id: nil) }
  scope :clean, -> { where.not(compensation_id: nil) }
end
