# MJML-Haml

[![Build Status](https://api.travis-ci.org/fnix/mjml-haml.svg?branch=master)](http://travis-ci.org/fnix/mjml-haml) [![Gem Version](https://badge.fury.io/rb/mjml-haml.svg)](https://badge.fury.io/rb/mjml-haml)

**MJML-Haml** allows you to render HTML e-mails from a [MJML](https://mjml.io) template.

An example layout might look like:

```haml
/ app/views/layouts/user_mailer.html.mjml
%mjml
  %mj-body
    %mj-container
      %mj-section{ background: { color: '#222' }, padding: '10px' }
        %mj-column{ width: '30%' }
          %mj-image{ alt: 'fnix', href: root_url, src: image_url('my-logo.png') }
        %mj-column{ width: '30%' }
        %mj-column{ width: '40%' }
          %mj-social{ 'base-url': '/images/mailer/', display: 'facebook:url google:url linkedin:url twitter:url',
            'facebook-content': '', 'facebook-href': 'https://www.facebook.com/Fnix-804357709655741/',
            'facebook-icon-color': 'transparent', 'google-content': '',
            'google-href': 'https://plus.google.com/+FnixBr', 'google-icon-color': 'transparent', 'icon-size': '32px',
            'linkedin-content': '', 'linkedin-href': 'https://www.linkedin.com/company/fnix',
            'linkedin-icon-color': 'transparent', 'twitter-content': '', 'twitter-href': 'https://twitter.com/fnixbr',
            'twitter-icon-color': 'transparent' }
      %mj-section{ 'text-align': 'left' }
        = yield
      %mj-section{ 'background-color': '#E5E5E5', padding: '10px 0' }
        %mj-text{ 'font-size': '11px', 'line-height': '15px' }
          My awesome footer
```

And the template for an action:

```haml
/ app/views/user_mailer/password.html.haml
%mj-text
  %h2 Password
%mj-text
  %p{style: 'text-align: justify;'}
    == You sign up with #{provider_to_name @user.identities.first.try(:provider)}, so we generate a password for you:
%mj-button= @password
%mj-text
  %p
    == You need this password to change your #{link_to 'account', edit_user_registration_url} details. Do you want to
    change this cryptic password, no problem::
%mj-button{ href: edit_user_registration_url } Change Password

```

Note that the layout is named `.html.mjml` and the template `.html.haml`. Why? mjml only output content that are wrapped
by:

```html
<mjml>
  <mj-body>
    ...
  </mj-body>
</mjml>
```

So, for the template we just want to use HAML and for the layout + template we use mjml + haml.

You write your mailer as usual:

```ruby
# app/mailers/user_mailer.rb
class UserMailer < ActionMailer::Base
  def password()
    mail(to: 'test@example.com', subject: 'test')
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

* Kadu Diógenes [github.com/cerdiogenes](https://github.com/cerdiogenes)

## License

MIT License. Copyright 2016 Kadu Diógenes.

Lovingly built on [github.com/sighmon/mjml-rails](https://github.com/sighmon/mjml-rails)
