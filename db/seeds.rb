# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'uri'
require 'net/http'

url = URI('https://api.themoviedb.org/3/movie/movie_id?language=en-US')
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request['accept'] = 'application/json'

response = http.request(request)
puts response.read_body

result['movie'].each do |key, value|
  if Exchange.find_by(currency: key)
    rate = Exchange.find_by(currency: key)
    rate.update(rate: value)
  else
    Exchange.create(currency: key, rate: value)
  end
end
