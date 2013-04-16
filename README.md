# Converge

A convenient [Rack](http://rack.github.io/) middleware for flexible HTTP redirection.

## Installation

Add this line to your application's Gemfile:

    gem 'converge'

And then execute:

    $ bundle

## Usage with Rails

Create a new initializer `config/initializers/converge.rb` and define your rules, as for example:

```
Converge.configure do
  redirect "/en/contact", "/en/about-us"
  redirect({path: "/secure", scheme: "http"}, {scheme: "https"})

  match(/^(\/.+?)\/+$/) { |match| redirect(match) }
  match(fullpath: /\?set_locale=true$/) { redirect(request.url.gsub("?set_locale=true", "")) }
  match(/^\/([a-z]{2})\/categories\/\d+\-(.+)$/) { |locale, category| redirect("/#{locale}/#{category}") }
end
```

Use the middleware: `config/application.rb`

```

module MyApp
  class Application < Rails::Application
    ...    
    config.middleware.use Converge::Middleware
    ...    
  end
end

```

## TODO

* Proper specs

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
