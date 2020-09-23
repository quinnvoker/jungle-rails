# Jungle

A mini e-commerce application built with Rails 4.2 for purposes of teaching Rails by example, as a part of LHL's web development bootcamp.

## Screenshots

<img alt="Home Page" src="https://github.com/quinnvoker/jungle-rails/blob/master/docs/images/home.png" height="256"> 
<img alt="Product Details and Reviews" src="https://github.com/quinnvoker/jungle-rails/blob/master/docs/images/reviews.png" height="256">
<img alt="Customer's Cart" src="https://github.com/quinnvoker/jungle-rails/blob/master/docs/images/cart.png" height="256">

## Features

* Users can register or log in
* Users can browse a selection of products and categories
* Users can add products to their cart and submit orders
  * On submission, order reciepts will be emailed to user
* Users can read and create reviews on a particular product
* Administrators can create new products and categories
* Administrators can delete products


## Setup

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rake db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env vars
8. Run `bin/rails s -b 0.0.0.0` to start the server

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>


## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe
