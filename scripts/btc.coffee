# Description:
#   Get the latest crypto-currency value in a given currency
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot btc <currency> - Gives current Bitcoin value in in <currency|USD> from Coinbase
#   hubot bch <currency> - Gives current Bitcoin Cash value in in <currency|USD> from Coinbase
#   hubot eth <currency> - Gives current Etherium value in in <currency|USD> from Coinbase
#   hubot ltc <currency> - Gives current Litecoin value in in <currency|USD> from Coinbase

module.exports = (robot) ->
  robot.respond /(btc|bch|eth|ltc)\s?(.*)$/i, (msg) ->
    currency_from = msg.match[1]
    currency_to = msg.match[2] || 'USD'
    getForexData currency_from, currency_to, msg

  getForexData = (coin, curr, msg) ->
    url = "https://api.coinbase.com/v2/prices/#{coin}-#{curr}/buy"
    msg.http(url)
      .header('CB-VERSION', '2018-01-23')
      .get() (err,res,body) ->
        if res.statusCode != 200
          msg.send "Got a HTTP/" + res.statusCode
          msg.send "Cannot get your quote right now."
        else
          result = JSON.parse(body)
          msg.send "Last average price: " + result.data.amount + " " + result.data.currency

