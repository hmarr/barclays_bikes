require 'open-uri'
require "barclays_bikes/version"

module BarclaysBikes
  URL = 'https://web.barclayscyclehire.tfl.gov.uk/maps'

  # Scrape the bike availability data from the Barclays Bike website and return
  # a hash mapping station names to bike and space counts.
  def self.load_bike_data
    data = open(URL) { |io| io.read }
    stations = Hash[data.scan(/station={([^}]+)}/).map do |match|
      [js_val(match.first, :name), {
        bikes: js_val(match.first, :nbBikes).to_i,
        spaces: js_val(match.first, :nbEmptyDocks).to_i,
      }]
    end]
  end

  # Display a summary of bike and space availability for a given query.
  def self.print_bike_info(query)
    bike_data = load_bike_data
    query = query.split.map { |term| Regexp.escape(term) }.join("[^\w]+")
    query = Regexp.new(query, Regexp::IGNORECASE)
    matches = bike_data.select { |station_name| station_name =~ query }

    matches.each_pair do |name, info|
      puts "\n\033[1m#{name}\033[0m:"
      puts "  #{colorize("#{info[:bikes]} bikes available", info[:bikes])}"
      puts "  #{colorize("#{info[:spaces]} spaces available", info[:spaces])}"
    end
    puts matches.empty? ? "No matches found" : ""
  end

  private

  # Extract a value from a Javascript (not JSON) object literal.
  def self.js_val(js, prop)
    /#{prop}:\s*"([^"]+)"/.match(js)[1]
  end

  # Colorize the text appropriately for the given number. If the number is 5 or
  # greater, the text will be green. It'll be red for 0, and yellow for
  # anything inbetween.
  def self.colorize(text, n)
    color_code = n > 0 ? 32 : 31
    color_code = 33 if (1...5).include? n
    "\033[#{color_code}m#{text}\033[0m"
  end
end

