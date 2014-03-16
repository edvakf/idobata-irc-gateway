# Idobata IRC Gateway

## Setup

1. Install dependencies

```
npm install
bundle install
```

2. Create a bot and on idobata and obtain an API token following the [instruction](https://github.com/idobata/hubot-idobata)

3. Create .env

```.env
HUBOT_IDOBATA_API_TOKEN=*****
HUBOT_NAME=my-bot
IIG_MAIN_CHANNEL=my-main-channel
```

4. Launch

```
bundle exec foreman start
```

## References

 * https://github.com/cho45/net-irc
 * https://github.com/github/hubot
 * https://github.com/idobata/hubot-idobata
