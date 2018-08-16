# Description:
#   javabot style factoid support for your hubot. Build a factoid library
#   and save yourself typing out answers to similar questions
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   ~<factoid> is <some phrase, link, whatever> - Creates a factoid
#   ~<factoid> is also <some phrase, link, whatever> - Updates a factoid.
#   ~<factoid> - Prints the factoid, if it exists. Otherwise tells you there is no factoid
#   ~tell <user> about <factoid> - Tells the user about a factoid, if it exists
#   ~~<user> <factoid> - Same as ~tell, less typing
#   <factoid>? - Same as ~<factoid> except for there is no response if not found
#   hubot no, <factoid> is <some phrase, link, whatever> - Replaces the full definition of a factoid
#   hubot factoids list - List all factoids
#   hubot factoid delete <factoid> - delete a factoid
#
# Author:
#   arthurkalm

class Factoids
  constructor: (@robot) ->
    @robot.brain.on 'loaded', =>
      @cache = @robot.brain.data.factoids
      @cache = {} unless @cache
      @metrics = @robot.brain.data.factoid_metrics || {}

  add: (key, val) ->
    if @cache[key]
      "#{key} is already #{@cache[key]}"
    else
      this.setFactoid key, val

  append: (key, val) ->
    if @cache[key]
      @cache[key] = @cache[key] + ", " + val
      @robot.brain.data.factoids = @cache
      "Ok. #{key} is also #{val} "
    else
      "No factoid for #{key}. It can't also be #{val} if it isn't already something."

  setFactoid: (key, val) ->
    @cache[key] = val
    @robot.brain.data.factoids = @cache
    "OK. #{key} is #{val} "

  delFactoid: (key) ->
    delete @cache[key]
    @robot.brain.data.factoids = @cache
    "OK. I forgot about #{key}"

  getMetrics: (key) ->
    @metrics[key] || 0

  updateMetrics: (key) ->
    @metrics[key] ||= 0
    @metrics[key] += 1
    @robot.brain.data.factoid_metrics = @metrics

  niceGet: (key) ->
    if result = @cache[key]
      this.updateMetrics(key)
      result
    else
      "No factoid for #{key}"

  get: (key) ->
    result = @cache[key]
    this.updateMetrics(key) if result
    result

  getWithoutMetrics: (key) ->
    @cache[key]

  list: ->
    Object.keys(@cache)

  tell: (person, key) ->
    factoid = this.get key
    if @cache[key]
      "#{person}, #{key} is #{factoid}"
    else
      factoid

  handleFactoid: (text) ->
    if match = /^~(.+?) is also (.+)/i.exec text
      this.append match[1], match[2]
    else if match = /^~(.+?) is (.+)/i.exec text
      this.add match[1], match[2]
    else if match = (/^~tell (.+?) about (.+)/i.exec text) or (/^~~(.+) (.+)/.exec text)
      this.tell match[1], match[2]
    else if match = /^~(.+)/i.exec text
      this.niceGet match[1]

module.exports = (robot) ->
  factoids = new Factoids robot

  robot.hear /^~(.+)/i, (msg) ->
    if match = (/^~tell (.+) about (.+)/i.exec msg.match) or (/^~~(.+) (.+)/.exec msg.match)
      msg.send factoids.handleFactoid msg.message.text
    else
      msg.reply factoids.handleFactoid msg.message.text

  robot.hear /(.+)\?/i, (msg) ->
    factoid = factoids.get msg.match[1]
    if factoid
      msg.reply msg.match[1] + " is " + factoid

  robot.respond /no, (.+) is (.+)/i, (msg) ->
    msg.reply factoids.setFactoid msg.match[1], msg.match[2]

  robot.respond /factoids? list/i, (msg) ->
    msg.send factoids.list().join('\n')

  robot.respond /factoids? delete "(.*)"$/i, (msg) ->
    msg.reply factoids.delFactoid msg.match[1]

  robot.respond /factoids? delete (.*)$/i, (msg) ->
    msg.reply factoids.delFactoid msg.match[1]

  formatValue = (value) ->
    value = value.replace('<', '&lt;').replace('>', '&gt;')
    if match = value.match(/(\S+\.(?:gif|png|jpe?g|tiff?))([, ]|$)/)
      value.replace(match[1], "<img src=\"#{match[1]}\">")
    else if match = value.match(/(\S+\.youtube\.com\S+)([, ]|$)/)
      value.replace(match[1], "<iframe width=\"427\" height=\"255\" src=\"#{match[1]}\" frameborder=\"0\" allowfullscreen></iframe>").replace('/watch?v=', '/embed/')
    else
      value

  robot.router.get '/factoids', (req, res) ->
    body = "<table>"
    body += "<thead><tr><th>Factoid</th><th>Times requested</th><th>Definition</th></tr></thead>"
    for factoid in factoids.list()
      body += "<tr><td>#{factoid}</td><td>#{factoids.getMetrics(factoid)}</td><td>#{formatValue(factoids.getWithoutMetrics(factoid))}</td></tr>"
    body += "</table>"
    html = "<html><head><title>Kerminator | Factoids</title>
      <style>
      img { max-height: 255px; max-width: 427px; }
      td:first-child { text-align: right; padding-right: 75px; }
      </style>
      </head>
      <body>#{body}
      </body></html>"
    res.send html

