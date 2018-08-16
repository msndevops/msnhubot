# Description:
#   None
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_BRAIN_DIR
#
# Commands:
#   None
#
# Author:
#   dustyburwell, stahnma
#
# Note:
# Grabbed from https://raw.githubusercontent.com/github/hubot-scripts/master/src/scripts/file-brain.coffee before modification
#  Note: this file _must_ be loaded last in order to have the brain working with everything else. Hence, why it starts with the letter z.

fs   = require 'fs'
path = require 'path'

module.exports = (robot) ->
  brainPath = process.env.HUBOT_BRAIN_DIR
  unless fs.existsSync brainPath
    brainPath = process.cwd()

  brainPath = path.join brainPath, 'hubot-brain.json'

  try
    data = fs.readFileSync brainPath, 'utf-8'
    if data
      robot.brain.mergeData JSON.parse(data)
  catch error
      console.log('Unable to read file', error) unless error.code is 'ENOENT'

  robot.brain.on 'save', (data) ->
    fs.writeFileSync brainPath, JSON.stringify(data), 'utf-8'
