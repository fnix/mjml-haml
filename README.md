# MJML-Rails

[![Build Status](https://api.travis-ci.org/sighmon/mjml-rails.svg?branch=master)](http://travis-ci.org/sighmon/mjml-rails) [![Gem Version](https://badge.fury.io/rb/mjml-rails.svg)](https://badge.fury.io/rb/mjml-rails)

**MJML-Rails** allows you to render HTML e-mails from an [MJML](https://mjml.io) template.

An example template might look like:

```erb
<!-- ./app/views/user_mailer/email.mjml -->
<mjml>
  <mj-body>
    <mj-container>
      <mj-section>
        <mj-column>
          <mj-text>Hello World</mj-text>
          <%= render :partial => 'info', :formats => [:html] %>
        </mj-column>
      </mj-section>
    </mj-container>
  </mj-body>
</mjml>
```

And the partial `_info.mjml`:

```erb
<!-- ./app/views/user_mailer/_info.mjml -->
<mj-text>This is <%= @user.username %></mj-text>
```

* Notice you can use ERb and partials inside the template.

Your `user_mailer.rb` might look like this::

```ruby
# ./app/mailers/user_mailer.rb
class UserMailer < ActionMailer::Base
  def user_signup_confirmation()
    mail(to: 'test@example.com', subject: 'test') do |format|
      format.text
      format.mjml
    end
  end
end
```

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
npm install -g mjml@2.1.4
```

## Deploying with Heroku

To deploy with [Heroku](https://heroku.com) you'll need to setup [multiple buildpacks](https://devcenter.heroku.com/articles/using-multiple-buildpacks-for-an-app) so that Heroku first builds Node for MJML and then the Ruby environment for your app.

Once you've installed the [Heroku Toolbelt](https://toolbelt.heroku.com/) you can setup the buildpacks from the commandline:

`$ heroku buildpacks:set heroku/ruby`

And then add the Node buildpack to index 1 so it's run first:

`$ heroku buildpacks:add --index 1 heroku/nodejs`

Check that's all setup by running:

`$ heroku buildpacks`

Next you'll need to setup a `package.json` file in the root, something like this:

```json
{
  "name": "your-site",
  "version": "1.0.0",
  "description": "Now with MJML email templates!",
  "main": "index.js",
  "directories": {
    "doc": "doc",
    "test": "test"
  },
  "dependencies": {
    "mjml": "2.1.4"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/your-repo/your-site.git"
  },
  "keywords": [
    "mailer"
  ],
  "author": "Your Name",
  "license": "ISC",
  "bugs": {
    "url": "https://github.com/sighmon/mjml-rails/issues"
  },
  "homepage": "https://github.com/sighmon/mjml-rails"
}
```

Then `$ git push heroku master` and it should Just WorkTM.

## Bug reports

If you discover any bugs, feel free to create an issue on GitHub. Please add as much information as possible to help us fixing the possible bug. We also encourage you to help even more by forking and sending us a pull request.

[github.com/sighmon/mjml-rails/issues](https://github.com/sighmon/mjml-rails/issues)

## Maintainers

* Simon Loffler [github.com/sighmon](https://github.com/sighmon)
* Steven Pickles [github.com/thatpixguy](https://github.com/thatpixguy)

## License

MIT License. Copyright 2016 Simon Loffler. [sighmon.com](http://sighmon.com)

Lovingly built on [github.com/plataformatec/markerb](https://github.com/plataformatec/markerb)
