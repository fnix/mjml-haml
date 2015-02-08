# Markerb

[![Build Status](https://api.travis-ci.org/plataformatec/markerb.png?branch=master)](http://travis-ci.org/plataformatec/markerb)

**Markerb** allows you to render multipart e-mails from a single template. The template is written in Markdown, which is delivered as a text part, but also rendered and delivered as an HTML part.

The usage is quite simple. Assuming you have a notifier as below:

```ruby
class Notifier < ActionMailer::Base
  def contact(recipient)
    @recipient = recipient
    mail(:to => @recipient, :from => "john.doe@example.com") do |format|
      format.text
      format.html
    end
  end
end
```

If you create a template at `app/views/notifier/contact.markerb`:

```erb
Multipart templates **rocks**, right <%= @recipient %>?!
```

It will generate two parts, one in text and another in html when delivered. Before we finish, here are a few things you might need to know:

* The `contact.markerb` template should not have a format in its name. Adding a format would make it unavailable to be rendered in different formats;

* The order of the parts matter. It is important for e-mail clients that you call `format.text` before you call `format.html`;

* Notice you can normally use ERb inside the template.

Enjoy!

## Installation

Add it to your Gemfile, with either the `redcarpet` or `kramdown` parser:

```ruby
gem 'markerb'
gem 'redcarpet', '>= 2.0'
# gem 'kramdown'
```

Run the following command to install it:

```console
bundle install
```

## Bug reports

If you discover any bugs, feel free to create an issue on GitHub. Please add as much information as
possible to help us fixing the possible bug. We also encourage you to help even more by forking and
sending us a pull request.

https://github.com/plataformatec/markerb/issues

## Maintainers

* José Valim (https://github.com/josevalim)

## License

MIT License. Copyright 2011-2015 Plataformatec. http://plataformatec.com.br
