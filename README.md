# Untitled

Untitled is a general-purpose static site generator. It allows you to use your
favorite Ruby templating languages (via Tilt) and asset transpilers (via
Sprockets) to create rich web applications with ease.

## Installation

```
$ gem install untitled
```

## Getting started

The fastest way to get started is to create a bare-bones app:

```
$ untitled new my_app
```

Which will create a project folder with the following file structure:

```
my_app
├── Gemfile
├── assets
│   ├── css
│   │   └── screen.css
│   └── js
│       └── foo.js
├── config.ru
└── index.html
```

If you already know which templating language(s) and/or transpiler(s) you'd like
to use, simply specify them when creating your app:

```
$ untitled new -s haml,coffee,scss my_app
```

This will add a little sugar to your application's file structure...

```
my_app
├── Gemfile
├── assets
│   ├── css
│   │   └── screen.css.scss
│   └── js
│       └── foo.js.coffee
├── config.ru
└── index.html.haml
```

...and automatically add the necessary gem dependencies to your `Gemfile`:

```ruby
source :rubygems

gem "untitled", "~> 0.0.1"

gem "haml", "~> 3.1.3"
gem "coffee-script", "~> 2.2.0"
gem "sass", "~> 3.1.15"
```

## Layouts

## Helper Methods

## Templating Support

## Transpiler Support

## Deployment

## Security


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Rebase the master branch (`git pull origin master --rebase`)
5. Push to the feature branch (`git push origin my-new-feature`)
6. Create new Pull Request
