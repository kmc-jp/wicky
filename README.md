wicky
=====

Wiki-based schedule management tool

## Prerequisite

* Ruby 1.9.3 / 2.0.0
* Bundler 1.1.4

    cd path/to/repository
    bundle install --path vendor/bundle

## Configuration

Configure your database settings:

    cd path/to/repository
    cd config
    cp database.yml.sample database.yml
    vi database.yml

Then, create and migrate the DB:

    bundle exec exec db:migrate

## Run server

Run your rack server:

    bundle exec rackup

or, if you like other host:port,

    bundle exec rackup -o host -p port

Then, browse your site!

* http://localhost:9292/ etc.

