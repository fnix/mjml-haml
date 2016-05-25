# MJML-Rails

[![Build Status](https://api.travis-ci.org/sighmon/mjml-rails.png?branch=master)](http://travis-ci.org/sighmon/mjml-rails)

**MJML-Rails** allows you to render HTML e-mails from an [MJML](https://mjml.io) template.

An example template might look like `app/views/user_mailer/email.mjml`:

```erb
<mj-body>
  <mj-section>
    <mj-column>
      <mj-text>Hello World</mj-text>
      <%= render :partial => 'info', :formats => [:html] %>
    </mj-column>
  </mj-section>
</mj-body>
```

And the partial `_info.mjml`:

```erb
<mj-text>This is <%= @user.username %></mj-text>
```

* Notice you can use ERb and partials inside the template.

## Installation

Add it to your Gemfile.

```ruby
gem 'mjml-rails', git: 'https://github.com/sighmon/mjml-rails.git', require: 'mjml'
```

Run the following command to install it:

```console
bundle install
```

Install the MJML parser

```console
npm install -g mjml@1.3.4
```

* Note that this gem only supports MJML 1.x at the moment.
* If you'd like to help me upgrade it to support MJML 2.x that'd be great!

## Bug reports

If you discover any bugs, feel free to create an issue on GitHub. Please add as much information as possible to help us fixing the possible bug. We also encourage you to help even more by forking and sending us a pull request.

[github.com/sighmon/mjml-rails/issues](https://github.com/sighmon/mjml-rails/issues)

## Maintainers

* Simon Loffler [github.com/sighmon](https://github.com/sighmon)
* Steven Pickles [github.com/thatpixguy](https://github.com/thatpixguy)

## License

MIT License. Copyright 2016 Simon Loffler. [sighmon.com](http://sighmon.com)

Lovingly built on [github.com/plataformatec/markerb](https://github.com/plataformatec/markerb)
