# FreqFinder

[![Build Status](https://travis-ci.com/jufemaiz/freq-finder.svg?branch=master)](https://travis-ci.com/jufemaiz/freq-finder)
[![](https://img.shields.io/coveralls/github/jufemaiz/freq-finder.svg)](https://coveralls.io/github/jufemaiz/freq-finder)
[![](https://img.shields.io/codeclimate/issues/jufemaiz/freq-finder.svg)](https://codeclimate.com/github/jufemaiz/freq-finder/)
[![](https://img.shields.io/codeclimate/maintainability/jufemaiz/freq-finder.svg)](https://codeclimate.com/github/jufemaiz/freq-finder/)
[![Yard Docs](https://img.shields.io/badge/yard-docs-blue.svg)](https://www.rubydoc.info/github/jufemaiz/freq-finder/)

Not finding freaks but freqs - radio frequencies for when you're out and about.

Why? Because while Australia's ACMA publishes some things, a simple "what radio
is available near me?" response just doesn't exist! It was inspired when my
girlfriend called me wanting to know the TripleJ frequencies near her!

GeoCode base stations (not taking into account power...yet) against a location
and get going with options to listen to!

## API Support

### v1: [JSON:API](https://jsonapi.org/)

Available at: https://freqfinder.herokuapp.com/v1/

* Station `https://freqfinder.herokuapp.com/v1/stations`
* Transmitter `https://freqfinder.herokuapp.com/v1/transmitters`

### v2: [GraphQL](https://graphql.org/)

Available at: https://freqfinder.herokuapp.com/v2/

#### Stations

```graphql
query {
  allStations {
    edges {
      node {
        title
        id
      }
    }
  }
}
```

#### Transmitters

```graphql
query {
  allTransmitters(location: "-33.88051,151.20948") {
    edges {
      node {
        frequency
        band
        distance
        station {
          title
        }
      }
    }
  }
}
```

## Requirements

If you are developing locally, bust out your [Docker](https://docker.org) so
that.

## Development

Docker makes life lovely here.

```bash
docker-compose -f docker-compose.dev.yml build web
docker-compose -f docker-compose.dev.yml up web
docker-compose -f docker-compose.dev.yml run web bundle exec rake db:drop
docker-compose -f docker-compose.dev.yml run web bundle exec rake db:create
docker-compose -f docker-compose.dev.yml run web bundle exec rake db:migrate
docker-compose -f docker-compose.dev.yml run web bundle exec rake db:seed
```

You should then be able to access the service at:

[localhost:3000](http://localhost:3000)

## Testing

Testing is also nice with Docker!

```bash
docker-compose -f docker-compose.test.yml build web
docker-compose -f docker-compose.test.yml up web
docker-compose -f docker-compose.test.yml run web bundle exec rake db:drop
docker-compose -f docker-compose.test.yml run web bundle exec rake db:create
docker-compose -f docker-compose.test.yml run web bundle exec rake db:migrate
docker-compose -f docker-compose.test.yml run web bundle exec rake db:seed
docker-compose -f docker-compose.test.yml run web bundle exec rspec
```
