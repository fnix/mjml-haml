# MJML-Rails

[![Build Status](https://api.travis-ci.org/sighmon/mjml-rails.png?branch=master)](http://travis-ci.org/sighmon/mjml-rails)

**MJML-Rails** allows you to render HTML e-mails from an [MJML](https://mjml.io) template.

If you create a template at `app/views/notifier/contact.mjml`:

```erb
<mj-body>
  <mj-section>
    <mj-column>
      <mj-text>Hello World</mj-text>
      <%= render :partial => 'user_info', :formats => [:mjml] %>
    </mj-column>
  </mj-section>
</mj-body>
```

It will generate the responsive HTML template for you.

* Notice you can normally use ERb inside the template.

Enjoy!

## Installation

Add it to your Gemfile.

```ruby
gem 'mjml-rails', git: 'https://github.com/sighmon/mjml-rails.git'
```

Run the following command to install it:

```console
bundle install
```

Install the MJML parser

```console
npm install -g mjml
```

## Bug reports

If you discover any bugs, feel free to create an issue on GitHub. Please add as much information as possible to help us fixing the possible bug. We also encourage you to help even more by forking and sending us a pull request.

[github.com/sighmon/mjml-rails/issues](https://github.com/sighmon/mjml-rails/issues)

## Maintainers

* Simon Loffler [github.com/sighmon](https://github.com/sighmon)

## License

MIT License. Copyright 2016 Simon Loffler. [sighmon.com](http://sighmon.com)

Lovingly modified from [github.com/plataformatec/markerb](https://github.com/plataformatec/markerb)
