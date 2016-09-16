require 'sinatra'
require 'money'
require 'httparty'

I18n.config.available_locales = :en
GIFS = [
  'https://i.imgur.com/lnK1nBF.gif',
  'https://i.imgur.com/ptqA6dW.gif',
  'https://i.imgur.com/r1o0uyH.gif',
  'https://i.imgur.com/N0aYJTJ.gif',
  'https://i.imgur.com/j25gaOc.gif',
  'https://i.imgur.com/tkbHsDZ.gif',
  'https://i.imgur.com/HaNu5ka.gif',
  'https://i.imgur.com/5ZcUxTg.gif',
  'https://i.imgur.com/5CiZA5v.gif',
  'https://i.imgur.com/nDUasjq.gif',
  'https://i.imgur.com/8ExBVb4.gif',
  'https://i.imgur.com/cskbcM2.gif',
  'https://i.imgur.com/49tP7pc.gif',
  'https://i.imgur.com/28bfK1I.gif',
  'https://i.imgur.com/ERyoPf3.gif',
  'https://i.imgur.com/PbADlZW.gif',
  'https://i.imgur.com/dgBtPpD.gif',
  'https://i.imgur.com/2BgTeUI.gif',
  'https://i.imgur.com/OYAgYcf.gif',
  'https://i.imgur.com/gh7uW50.gif',
  'https://i.imgur.com/6fYah3Z.gif',
  'https://i.imgur.com/yuB67q5.gif',
  'https://i.imgur.com/JeEHZL9.gif',
  'https://i.imgur.com/BxFlFvv.gif',
  'https://i.imgur.com/n6K78PG.gif',
  'https://i.imgur.com/AbHWKoc.gif',
  'https://i.imgur.com/uRVbxua.gif',
  'https://i.imgur.com/HI8F2m6.gif',
  'https://i.imgur.com/JWnWT39.gif',
  'https://i.imgur.com/ufXbK5N.gif',
  'https://i.imgur.com/ymGjIgw.gif',
  'https://i.imgur.com/tc0C2YO.gif',
  'https://i.imgur.com/U9uk9nI.gif',
  'https://i.imgur.com/knOT0mG.gif',
  'https://i.imgur.com/EzsvmRP.gif',
  'https://i.imgur.com/XF7BkOy.gif',
  'https://i.imgur.com/21XLOln.gif',
  'https://i.imgur.com/Ic0An1a.gif',
  'https://i.imgur.com/6d1nV51.gif',
  'https://i.imgur.com/b4njPYd.gif',
  'https://i.imgur.com/8kaGt4i.gif',
  'https://i.imgur.com/e26eOBC.gif'
]

get '/' do
  'Configured and running.'
end

post '/now' do
  request.body.rewind
  payload = JSON.parse request.body.read

  currency = payload['currency']
  amount = payload['amount']
  formated_amount = Money.new(amount, currency).format
  puts formated_amount

  index = rand(GIFS.size)
  gif = GIFS[index]

  endpoint = ENV['SLACK_WEBHOOK_URL']
  options = {
      body: {
        attachments: [
          {
            text: "#{formated_amount} - #{gif}",
            username: 'Incoming money',
            icon_emoji: ':money_with_wings:',
            unfurl_links: true
          }
        ]
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    }
  result = HTTParty.post(endpoint, options)
  "Ok"
end
