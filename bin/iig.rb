#!/usr/bin/env ruby

Net::IRC::Server.new(ENV['IIG_LISTEN_HOST'] || 'localhost', ENV['IIG_PORT'] || 6667, IdobataIrcGateway, {
  redis: {
    host: '127.0.0.1',
    port: 6379,
    key: 'hubot'
  },
  irc: {
    main_channel: ENV['IIG_MAIN_CHANNEL']
  }
}).start
