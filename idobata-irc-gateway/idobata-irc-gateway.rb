#!/usr/bin/env ruby
# coding: utf-8

require 'net/irc'
require 'redis'
require 'json'

class IdobataIrcGateway < Net::IRC::Server::Session
  @channels = {}

  def server_name
    "idobata"
  end

  def server_version
    "0.0.0"
  end

  def main_channel
    @opts[:main_channel]
  end

  def initialize(*args)
    super
    create_idobata_redis_observer(@opts[:redis])
  end

  def on_join(m)
    channels = m.params.first.split(/,/)
    channels.each do |channel|
      post @prefix, JOIN, channel
      post nil, RPL_NAMREPLY,   @prefix.nick, "=", channel, "@#{@prefix.nick}"
      post nil, RPL_ENDOFNAMES, @prefix.nick, channel, "End of NAMES list"
    end
  end

  def create_idobata_redis_observer(conf)
    Thread.start(conf[:host], conf[:port], conf[:key]) do |host, port, key|
      Thread.pass
      redis = Redis.new(:host => host, :port => port)

      loop do
        begin
          item = redis.blpop(key)
          msg = JSON.load(item.last)
          msg['data']['body_plain'].each_line do |line|
            post msg['user']['name'], PRIVMSG, '#' + msg['data']['room_name'], line
          end
        rescue Exception => e
          @log.error "Error: #{e.inspect}"
          e.backtrace.each do |l|
            @log.error "\t#{l}"
          end
        end
      end
    end
  end
end
