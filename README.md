# Currency

[![Build Status](https://travis-ci.org/NIHERASE/currency.svg?branch=master)](https://travis-ci.org/NIHERASE/currency)

This is a demo project I've done for an interview at Fun-box.

## The task

Develop a web application (a Rails project) that satisfies the following conditions:
* the application provides two pages: `/` and `/admin`;
* page `/` displays current exchange rate of RUB to USD;
* the application periodically updates the exchange rate in a backround job;
* the exchange rate should update (without reload) on all currently open `/` pages;
* `/admin` page contains a form that has a number field, a date-time field and a submit button;
* when this form is submitted the number field becomes the forced exchange rate until the specified date-time has passed. During this time the real exchange rate is ignored and the force rate is displayed;
* `/admin` page retains entered values upon reload;
* when the forced rate is submitted it is displayed on all open `/` pages. When forced rate expires the real rate is shown;
* the form has appropriate validations;
* the application should look reasonably neat (e.g. use Twitter Bootstrap);
* using a JS framework for frontend is a plus;
* the application should work correctly on the latest versions of Chrome and Firefox;
* the application's code should be covered by tests;
* it should be possible to run the application locally by running the `Procfile`;

## Highlights of my solution

* Redis is used for both PubSub and storage. No additional DB was used.
* Architecture can support multiple currency providers. If none worked a dummy provider is invoked.

## Dependencies

* **Redis** should be available at `REDIS_URL` (specify the url in `.env`, default is `redis://0.0.0.0:6379`)
* **Foreman** should be installed `gem install foreman`

## Run
```bash
git clone git@github.com:NIHERASE/currency.git && cd currency
bundle install
RAILS_ENV=production rake assets:precompile
foreman start
```
