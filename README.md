# What is Worlds Wiki?

Worlds wiki is a web application that allows for the construction of wikipedia style wiki's without the need of constructing your own wikimedia server. It is built with [worldbuilding](https://en.wikipedia.org/wiki/Worldbuilding) in mind, however wikis could be built for just about anything.

Worlds wiki is completely unrelated to wikimedia, while it did draw inspiration from it in its design.

Worlds Wiki is a project that I started mainly to help develop my Ruby on Rails skills. I wanted to develop an app that I myself would use.

Currently, Worlds wiki is a fairly bare bones wikibuilder. However, it is completely free to use and I intend on it staying that way.

[Here](https://www.worldswiki.com/worlds/Worlds%20Wiki/wiki/pages/Welcome) is a live version of the app.

# Development

Feel free to make branches and add features and/or bug fixes to this project. If there is interest I'd love to see this project grow.

## Versions

This project uses ruby 2.6.5 and rails 6.0.0

## Getting Started

- First, create a fork of this repository
- then make a local clone of your fork
- Generate some sample data with: `rake dev:reset_db`
- Launch to rails server with `rails s`
- go to localhost:3000 to see the running app.

## Make Changes

Once you have the app running locally, feel free to start making changes. I am open to any kind of pull request so long as it does not break the app or change it in some fundamental way. That said, feel free to do that for your own personal version!

## Testing

There is a very basic rspec test suite that can be run using `rspec`, however it is not a very comprehensive test suite and a passing suite should not be taken as a rigorously tested version.


# License

[GNU General Public License v3.0](https://github.com/cnmorgan/worlds-wiki/blob/master/LICENSE)
