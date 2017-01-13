# Currency

[![Build Status](https://travis-ci.org/NIHERASE/currency.svg?branch=master)](https://travis-ci.org/NIHERASE/currency)

## Зависимости

* Redis, доступный по `REDIS_URL` (указать в `.env`, значние по умолчанию `redis://0.0.0.0:6379`)

## Запуск приложения:
```bash
git clone git@github.com:NIHERASE/currency.git && cd currency
bundle install
RAILS_ENV=production rake assets:precompile
foreman start
```
