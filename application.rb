require 'sinatra'
require 'money'
require 'httparty'
require 'yaml'

I18n.config.available_locales = :en

GIFS = YAML.load_file('gifs.yml')['gifs']

use Rack::Auth::Basic, 'Protected Application' do |username, password|
  username == ENV['USERNAME'] && password == ENV['PASSWORD']
end

get '/' do
  'Configured and running.'
end

post '/now' do
  request.body.rewind
  payload = JSON.parse request.body.read

  currency = payload['currency']
  amount = payload['amount']
  formated_amount = Money.new(amount, currency).format

  index = rand(GIFS.size)
  gif = GIFS[index]

  endpoint = ENV['SLACK_WEBHOOK_URL']
  options = {
      body: {
        text: "A bank transfer of #{formated_amount} has been done - #{gif}",
        username: 'Incoming money',
        icon_emoji: ':money_with_wings:',
        unfurl_links: true
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    }
  HTTParty.post(endpoint, options)
  "Ok"
end
