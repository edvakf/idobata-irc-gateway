# log-redis.coffee

Redis = require('redis')

module.exports = (robot) ->
  redis = Redis.createClient()

  robot.hear /.*/, (msg) ->
    redis.lpush('hubot', JSON.stringify(msg.message))
