require 'csv'
require_relative 'csv_record'

module RideShare
  class Driver < CsvRecord
    attr_reader :id, :name, :vin, :status, :trips
    def initialize(
      id:,
      name:,
      vin:,
      status: :AVAILABLE,
      trips: nil
      )
      super(id)
      (vin.length == 17) ? (@vin = vin) : (raise ArgumentError)
      [:AVAILABLE, :UNAVAILABLE].include?(status) ? (@status = status.to_sym) : (raise ArgumentError)

      @name = name
      @trips = trips || []

    end

    def add_trip(trip)
      @trips << trip
    end

    private

    def self.from_csv(record)
      return new(
        id: record[:id],
        name: record[:name],
        vin: record[:vin],
        status: record[:status].to_sym
      )
    end
  end
end