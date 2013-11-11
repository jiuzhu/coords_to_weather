require 'open-uri'
require 'json'

class CoordsController < ApplicationController
  def fetch_weather
    @address = params[:the_address]
    if @address != nil
        @url_safe_address = URI.encode(@address)
        url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + @url_safe_address + "&sensor=false"
        raw_data = open(url).read
        parsed_data = JSON.parse(raw_data)
        @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
        @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
        url = "https://api.forecast.io/forecast/3d28dfc2555461b10ea8e40021eae604/" + @latitude.to_s + "," + @longitude.to_s     
        raw_data = open(url).read
        @parsed_data = JSON.parse(raw_data)
        @temperature = @parsed_data["currently"]["temperature"]
        @minutely_summary = @parsed_data["minutely"]["summary"]
        @hourly_summary = @parsed_data["hourly"]["summary"]
        @daily_summary = @parsed_data["daily"]["summary"]
  end
end
end