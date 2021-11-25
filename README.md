# rails-assignment-boilerplate

Contains a minimal Rails installation to start off your Rails assignment.

## How to run on local machine

You need to have [nodejs](https://nodejs.org/en/download/) and [yarn](https://yarnpkg.com/lang/en/docs/install) installed.

Run `yarn && bundle && ./bin/dev` to make the magic happen.

## How to run with Docker

You need `docker` and `docker-compose` installed (for MacOS just use [official app](https://docs.docker.com/engine/installation/mac/)).

## Provisioning

Run the following commands to prepare your Docker dev env:

```sh
$ docker-compose build
$ docker-compose run runner yarn install
$ docker-compose run runner ./bin/setup
```

It builds the Docker image, installs Ruby and NodeJS dependencies, creates database, run migrations and seeds.

You're all set! Now you're ready to code!

## Running the app

You can run the Rails up using the following command:

```sh
$ docker-compose up rails
```
