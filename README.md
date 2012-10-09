# Untitled

Untitled is a general-purpose static site generator. It allows you to use your
favorite Ruby templating languages (eg. HAML) and asset transpilers (eg. SASS)
to create rich web applications with ease.

**WARNING:** This library doesn't implement any of the features it claims to.
Shortly after beginning development I found [Middlemman](middleman), which is a
stable and feature-complete gem that does the exact same thing.

[middleman]: http://middlemanapp.com

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
.
├── Gemfile
├── app
│   ├── assets
│   │   ├── javascripts
│   │   │   └── application.js
│   │   └── stylesheets
│   │       └── application.css
│   ├── includes
│   ├── layouts
│   │   └── application.html.erb
│   ├── pages
│   │   └── index.html.erb
│   └── public
│       └── humans.txt
├── config.ru
├── config.yml
└── vendor
    └── assets
        ├── javascripts
        └── stylesheets
```

Untitled initializes your app with the erb templating system by default. If you
want to use a different templating system or a JS/CSS transpiler you can specify
them when you initiailize your app like so:

```
$ untitled new -s haml,coffee,scss my_app
```

This will add a little sugar to your application's file structure...

```
.
├── Gemfile
├── Gemfile.lock
├── app
│   ├── assets
│   │   ├── javascripts
│   │   │   └── application.js.coffee
│   │   └── stylesheets
│   │       └── application.css.scss
│   ├── includes
│   ├── layouts
│   │   └── application.html.haml
│   ├── pages
│   │   └── index.html.haml
│   └── public
│       └── humans.txt
├── config.ru
├── config.yml
└── vendor
    └── assets
        ├── javascripts
        └── stylesheets
```

...and automatically add the necessary gem dependencies to your `Gemfile`:

```ruby
source :rubygems

gem "untitled", "~> 0.0.1"

gem "haml", "~> 3.1.3"
gem "coffee-script", "~> 2.2.0"
gem "sass", "~> 3.1.15"
```

## YAML Front Matter

Untitled uses YAML Front Matter to configure the behaviour of your static pages
(<strike>inspired</strike> stolen from [jekyll][jekyll]). An page with Front
Matter looks like this:

```
---
some_option: lolcat
---

<h1>This is fun!</h1>
```

[jekyll]: http://jekyllrb.com/

## Layouts

By default, Untitled will use a layout called `application`. You can specify
an alternate layout to use with the `layout` option:

```
---
layout: admin
---

<h1>Welcome to the admin section</h1>
```

## Helper Methods

Coming soon...

## Template and Transpiler Support

Untitled supports any template or transpiler that [Tilt][tilt] supports.

[tilt]: https://github.com/rtomayko/tilt

## Deployment

Coming soon...

## Security

Coming soon...


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some awesome'`)
4. Rebase the master branch (`git pull upstream master --rebase`)
5. Push to the feature branch (`git push origin my-new-feature`)
6. Create new Pull Request
