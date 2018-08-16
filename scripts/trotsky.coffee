# Description:
#   devops leon trotsky brings truth to the insurgency
#
# Commands:
# hubot trotsky fact - devops trotsky facts

factarr = ["Insurrection is an art, and like all arts has its own laws.",
           "You may not be interested in strategy, but strategy is interested in you.",
           "Learning carries within itself certain dangers because out of necessity one has to learn from one's enemies.",
           "The end may justify the means as long as there is something that justifies the end.",
           "In a serious struggle there is no worse cruelty than to be magnanimous at an inopportune time.",
           "Revolutions are always --verbose.",
           "Ideas that enter the mind under fire remain there securely and for ever.",
           "Technique is noticed most markedly in the case of those who have not mastered it.",
           "Under all conditions well-organized violence seems to him the shortest distance between two points.",
           "Not believing in --force is the same as not believing in gravity.",
           "If we had had more time for discussion we should probably have made a great many more mistakes.",
           "Where --force is necessary, there it must be applied boldly, decisively and completely. But one must know the limitations of --force; one must know when to blend --force with a maneuver, a blow with an agreement.",
           "There are no absolute rules of conduct, either in peace or war. Everything depends on circumstances.",
           "There is a limit to the application of democratic methods. You can inquire of all the passengers as to what type of car they like to ride in, but it is impossible to question them as to whether to apply the brakes when the train is at full speed and accident threatens." ]

module.exports = (robot) ->
  robot.respond /trotsky (?:facts?|me)/i, (msg) ->
    msg.send msg.random(factarr)

