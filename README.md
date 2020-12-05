# QueueUp API

## Requirements

- [Docker Compose](https://docs.docker.com/compose/)
- [NodeJS](https://nodejs.org/)
- [Redis](https://redis.io/)
- [RVM with Ruby 2.5.0](https://rvm.io/)

## Installation

Clone the project

`$ git clone git@gitlab.com:queueupgg/QueueUp-API.git`


Install dependencies

`$ bundle install`

Set up environment variables (don't forget to update the values)

`$ cp .env.example .env`

## Run project

```
$ docker-compose up     # Start database
$ rails db:migrate      # Run migrations
$ bundle exec sidekiq   # Start async workers (Sidekiq)
$ rails s               # Start API
```

## Contributing

Please consider reading [CONTRIBUTING.md](CONTRIBUTING.md)
