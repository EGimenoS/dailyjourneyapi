# DailyJourney API 🚗

- [Introduction](#Introduction)
- [Setup](#Setup)
- [Endpoints examples](#Endpoints)

## Introduction

This is my Master's Dissertation app for the "Master in web applications development" of the UOC (Universitat Oberta de Catalunya).
The project goal is to put people in contact in order to share their cars for their daily travels, such as commuting to go to their workplaces.
This repository contains the backend part of the application, a Ruby On Rails api-only app. There is also a  frontend SPA made with Angular that can be found here: DailyJourney. [DailyJourney Frontend](https://github.com/egimenos/dailyjourney)

## Setup and Installation

The project it's being built with these tools:

- Ruby version `2.7.1`
- Rails version `6.03`
- PostgreSQL 12

1. You need to make sure that the tools are properly installed in your system. The steps to follow are different depending on your system but you can find great guides for all of them in the guides section of GoRails, by Chris Oliver, just select your operating system: <https://gorails.com/setup/>
2. Once the tools are installed, clone the repo `git clone https://github.com/EGimenoS/dailyjourneyapi.git`
3. Move to the project root folder and install the dependencies by using `bundle install`
4. Create the database: `rails db:createe`
5. Run the database migration: `rails db:migrate`
6. Start your development server `rails s`

The app needs a Here Maps apikey to work since it uses their Geocoding and Search REST API v7. You can get a key for free with a generous free tier. More instructions: <https://developer.here.com/documentation/geocoding-search-api/dev_guide/index.html>.

Once you get your key, set it as an ENV variable. You can use for instance the figaro gem bundled with this project gemfile, run `bundle exec figaro install` to generate an `application.yml` file and add a new key with a here_maps_api_key and the value of your new key.

If you prefer to use a different provider than Here, add your own adapter to the Adapter module `app/adapters/adapter`

### Seeding the database

To generate consistent seed data the Faker gem along with Geocoder is used. You can directly run `rails db:seed` to seed the data or modify the file `./db/seeds.rb` to adjust the seed configuration.

## Endpoints

> Asuming your are running your app in `http://localhost:3000`

### User creation

Creates a new user.

`POST` request to `http://localhost:3000/users/sign_up`

Headers: `Content-Type: application/json`

Body:

```json
{
  "email": "testuser@test.com",
  "password": "testpassword",
  "password_confirmation": "testpassword",
  "name": "Test User"
}
```

If the sign up is successful the response contains an access token in the response header that needs to be included later in the header of all the requests made against any protected resources.

### User login

Signs in an existing user

`POST` request to `http://localhost:3000/users/sign_in`

Headers: `Content-Type: application/json`

Body:

```json
{ "email": "testuser@test.com", "password": "testpassword" }
```

If the sign in is successful the response contains an access token in the response header that needs to be included later in the header of all the requests made against protected resources.

### New Travel creation

Allows an authenticated user to create a new travel.

`POST` request to `http://localhost:3000/api/v1/travels`

Headers:

```json
Content-Type: application/json
Authorization: Bearer yourjwtfromthesigninrequest
```

Body:

```json
{
  "capacity": 3,
  "owner_comment": "Lorem Ipsum",
  "departure_time": "2015-11-05 22:32:03",
  "origin_attributes": {
    "address": "Foo street n23",
    "longitude": "1",
    "latitude": "2"
  },
  "destination_attributes": {
    "address": "Bar Boulevard 25",
    "longitude": "2",
    "latitude": "1"
  }
}
```

### Autosuggest addresses

It receives a string as a query and suggests real addresses from the Here Maps API. It is used to implement an input search with suggestions to validate real addreses and provide longitude and latitude values.

`GET` request to `http://localhost:3000/api/v1/search_addresses`

Query parameters:

```json
q: query string to lookup
at: Specifies the center of the search context. Format: {latitude},{longitude}
```

Example: `http://localhost:3000/api/v1/search_addresses?at=39.48728,-0.36593&q=lagranja%201%20almusafes`

Response:

It returns an array with several items that might match the query, including the proper address and the latitude and longitude values.

```json
[
  {
    "address": "Calle La Granja, 1, 46440 Almussafes (Valencia), España",
    "lat": 39.30864,
    "long": -0.41938
  }
]
```

### Travels near of destination target

It receives the desired position as params destination_latitude and destination_longitude and it returns the travels that are closer than 3 km. (TODO: Accepting an additional param to change the reference distamce)

`GET` request to <http://localhost:3000/api/v1/travels?destination_latitude=39.31232&destination_longitude=-0.42108>

Query parameters:

```json
destination_latitude
destination_longitude
```

Example: `http://localhost:3000/api/v1/travels?destination_latitude=39.31232&destination_longitude=-0.42108`

Response:

It returns an array with several items:

```json
[
  {
    "id": 11,
    "departure_time": "2020-11-22T08:30:00.000Z",
    "owner_comment": "Carmen auditor capio. Creber ex voluptatum.",
    "capacity": 2,
    "distance": 1.390576630103044,
    "bearing": "78.828832034937",
    "participants": [],
    "origin": {
      "id": 11,
      "address": "Soternes, Valencia, Valencian Community, Spain",
      "longitude": -0.40775859205660137,
      "latitude": 39.47223605390643
    },
    "destination": {
      "id": 11,
      "address": "Sollana, Valencian Community, Spain",
      "longitude": -0.40541829799190726,
      "latitude": 39.315412911138644
    },
    "owner": {
      "id": 61,
      "name": "Delila Sipes"
    }
  },
  {
    "id": 204,
    "departure_time": "2020-11-22T08:30:00.000Z",
    "owner_comment": "Velum capto viridis. Super amicitia careo.",
    "capacity": 2,
    "distance": 1.4450541568955952,
    "bearing": "55.779401482529",
    "participants": [],
    "origin": {
      "id": 204,
      "address": "Valencia, Valencian Community, Spain",
      "longitude": -0.3782611654945231,
      "latitude": 39.514978074025706
    },
    "destination": {
      "id": 204,
      "address": "Almussafes, Valencian Community, Spain",
      "longitude": -0.40846410588051923,
      "latitude": 39.320900384745485
    },
    "owner": {
      "id": 54,
      "name": "Preston Von"
    }
  },

```
