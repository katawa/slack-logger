_ = require('lodash')
mongojs = require('mongojs')
moment = require('moment')

USER = process.env.MONGO_USER
PASS = process.env.MONGO_PASS
HOST = process.env.MONGO_HOST
PORT = process.env.MONGO_PORT
DB   = process.env.MONGO_DB
COLL = process.env.MONGO_COLL

db = mongojs("#{USER}:#{PASS}@#{HOST}:#{PORT}/#{DB}", [COLL])

module.exports = (robot) ->
  robot.hear /.*/, (msg) ->
    message = _.clone(msg.message)
    delete message.rawMessage._client
    delete message.rawMessage.deleteMessage
    delete message.rawMessage.updateMessage
    message.datetime = moment(message.rawMessage.ts * 1000).toDate()
    db[COLL].save(message)
