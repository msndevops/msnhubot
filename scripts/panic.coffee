# Description:
#   For when it all goes to hell
#
# Commands:
#   hubot panic - PANIC!!!!!


module.exports = (robot) ->

  robot.respond /panic/i, (msg) ->
      msg.send "http://i.imgur.com/jAU4NIG.gif"

