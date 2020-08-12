# URL Shortener (Backend) Api

## Context

We would like to build a simple backend API for a URL shortening application (e.g. bitly.com) using modern web frameworks and build tools. The goal of this application is that a user can provide a URL and will be given a custom shortened URL that will redirect to the original URL.

## Project

Your project should include a backend API application. We are interested in getting a sense of the quality of your code and how you structure and build an application. You should use whatever tools you are most comfortable with and will be most effective to solve the problem and demonstrate your skills. Some examples of tools we use on our team are Node.js, MongoDB, Docker, Typescript, Yarn, these are not requirements they are just examples.

## User requirements

* As a user I want to create a new shortened URL
* As a user I want to view the details of a shortened URL
* As a user I want to see all shortened URLs that have been created
* As a user I want my shortened URL to redirect to the original URL

## What we care about

Write this like you would write production code at your company.
* It works
* The code is clear, easy to follow and documented
* The code is tested
* The code is resilient and has error handling

## Areas to ignore

* User authentication / security
* Application hosting / infrastructure

## Submitting / Running the application

* The application should include clear instructions to install dependencies, run tests and run the application
* Let us know how long you worked on the project
  * We know this is a very open-ended project and a lot of time could be spent on it, we are looking for you to prioritize the most important areas of the problem and focus on those, we don’t want you spending multiple days on this project
* Let us know what things you may not have completed but you think could be additions if you were to spend more time

## Api Reference

You can make the following API requests.

**POST /api/v1.0/links**

Params
* link (hash object)
  * url (string) - The URL you would like to shorten.

Response
* Hash
  * slug (string) - the shortened slug
  * url (string) - the original URL to be shortened
  * usage_count (integer) - the number of times this link has redirected
  * expires_at (datetime) - an optional expiry attribute, iso formatted
  * created_at (datetime) - creation datetime, iso formatted
