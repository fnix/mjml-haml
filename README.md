# MJML-Haml

[![Build Status](https://api.travis-ci.org/fnix/mjml-haml.svg?branch=master)](http://travis-ci.org/fnix/mjml-haml) [![Gem Version](https://badge.fury.io/rb/mjml-rails.svg)](https://badge.fury.io/rb/mjml-rails)

**MJML-Haml** allows you to render HTML e-mails from an [MJML](https://mjml.io) template.

An example template might look like:

```haml
/ ./app/views/user_mailer/email.mjml
%mjml
  %mj-body
    %mj-container
      %mj-section
        %mj-column
          %mj-text
          = render :partial => 'info', :formats => [:html]
```

And the partial `_info.mjml`:

```haml
/ ./app/views/user_mailer/_info.mjml
%mj-text= "This is #{@user.username}"
```

* Notice you can use Haml and partials inside the template.

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
gem 'mjml-haml'
```

Run the following command to install it:

```console
bundle install
```

Install the MJML parser (optional -g to install it globally):

```console
npm install -g mjml@^2.0
```

## Sending Devise user emails

If you use [Devise](https://github.com/plataformatec/devise) for user authentication and want to send user emails with MJML templates, here's how to override the [devise mailer](https://github.com/plataformatec/devise/blob/master/app/mailers/devise/mailer.rb):
```ruby
# app/mailers/devise_mailer.rb
class DeviseMailer < Devise::Mailer
  def reset_password_instructions(record, token, opts={})
    @token = token
    @resource = record
    # Custom logic to send the email with MJML
    mail(
      template_path: 'devise/mailer',
      from: "some@email.com", 
      to: record.email, 
      subject: "Custom subject"
    ) do |format|
      format.mjml
      format.text
    end
  end
end
```

Now tell devise to user your mailer in `config/initializers/devise.rb` by setting `config.mailer = 'DeviseMailer'` or whatever name you called yours.

And then your MJML template goes here: `app/views/devise/mailer/reset_password_instructions.mjml`

Devise also have [more instructions](https://github.com/plataformatec/devise/wiki/How-To:-Use-custom-mailer) if you need them.

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
    "mjml": "^2.0"
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
    "url": "https://github.com/fnix/mjml-haml/issues"
  },
  "homepage": "https://github.com/fnix/mjml-haml"
}
```

Then `$ git push heroku master` and it should Just WorkTM.

## Bug reports

If you discover any bugs, feel free to create an issue on GitHub. Please add as much information as possible to help us fixing the possible bug. We also encourage you to help even more by forking and sending us a pull request.

[github.com/fnix/mjml-haml/issues](https://github.com/fnix/mjml-haml/issues)

## Maintainers

* Simon Loffler [github.com/sighmon](https://github.com/sighmon)
* Steven Pickles [github.com/thatpixguy](https://github.com/thatpixguy)

## License

MIT License. Copyright 2016 Kadu Diógenes.

Lovingly built on [github.com/sighmon/haml-rails](https://github.com/sighmon/haml-rails)
