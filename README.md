# MakersBNB Project

### Team MADS

* Max
* Arthur
* Doug
* Sergei

## Stack

|                                                        | Tool                                                 | Use?                                       | Where can I see it?                                                  |
|--------------------------------------------------------|------------------------------------------------------|--------------------------------------------|----------------------------------------------------------------------|
| <img src="public/images/rspec.png" height="40" width="auto">       | [RSpec](https://rspec.info/)                         | Testing tool for Ruby.                     | ```/spec/*``` Unit tests for the app's classes.                              |
| <img src="public/images/capybara.png" height="40" width="auto">    | [Capybara](https://github.com/teamcapybara/capybara) | Acceptance test framework for Ruby.        |  ```/spec/features/*``` Feature testing for the app. e.g. Sign in/out                   |
| <img src="public/images/postgres.png" height="40" width="auto">       | [PostgreSQL](https://www.postgresql.org)                         | Object-relation database.                     | ```/db/migrations/*``` In the SQL commands below.                              |
| <img src="public/images/sinatra.png" height="40" width="auto">     | [Sinatra](http://sinatrarb.com/)                     | DSL for quickly making web apps with Ruby. | In the file structure for the project - it is built on Sinatra.      |
| <img src="public/images/bootstrap.png" height="40" width="auto">     | [Bootstrap](https://getbootstrap.com/)                     | Open source tool-kit made by twitter. | All of the design (no custom CSS in this app).       |


## How to run

```
git clone
bundle install
database queries - rack file?
```

**User Stories**

```
As a user,
So that I can log in, 
I want to be able to sign up
```
```
As a user,
So that I can make money,
I want to be able to list a new space.
```
```
As a user, 
So that I can manage my listings,
I want to be able to login
```
```
As a user,
So I can rent all available properties,
I want to be able to list multiple spaces
```
```
As a user,
So that I can provide information on my space,
I want to be able to give them a name, description and price.
```
```
As a user, 
So that people can book my space,
I want to display available dates.
```
```
As a signed-up user,
So that I can book a stay
I want to be able to hire a space for one night
```
```
As a user,
So that people can stay in my space,
I want to be able to approve booking requests
```
```
As a space,
If I'm already booked,
Users should not be able to book me.
```
```
As a space,
If a booking request has not be accepted
I am still available
```

### Headline specifications

- Any signed-up user can list a new space.
- Users can list multiple spaces.
- Users should be able to name their space, provide a short description of the space, and a price per night.
- Users should be able to offer a range of dates where their space is available.
- Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
- Nights for which a space has already been booked should not be available for users to book that space.
- Until a user has confirmed a booking request, that space can still be booked for that night.

### Nice-to-haves

- Users should receive an email whenever one of the following happens:
 - They sign up
 - They create a space
 - They update a space
 - A user requests to book their space
 - They confirm a request
 - They request to book a space
 - Their request to book a space is confirmed
 - Their request to book a space is denied
- Users should receive a text message to a provided number whenever one of the following happens:
 - A user requests to book their space
 - Their request to book a space is confirmed
 - Their request to book a space is denied
- A ‘chat’ functionality once a space has been booked, allowing users whose space-booking request has been confirmed to chat with the user that owns that space
- Basic payment implementation though Stripe.

### User Stories
