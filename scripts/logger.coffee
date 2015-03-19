_ = require('lodash')
mongojs = require('mongojs')

USER = process.env.MONGO_USER
PASS = process.env.MONGO_PASS
HOST = process.env.MONGO_HOST
PORT = process.env.MONGO_PORT
DB   = process.env.MONGO_DB
COLL = process.env.MONGO_COLL

db = mongojs("#{USER}:#{PASS}@#{HOST}:#{PORT}/#{DB}", [COLL])

module.exports = (robot) ->
  robot.hear /.*/, (msg) ->
    msg = _.clone(msg.message)
    delete msg.rawMessage._client
    delete msg.rawMessage.deleteMessage
    delete msg.rawMessage.updateMessage
    db[COLL].save(msg)
