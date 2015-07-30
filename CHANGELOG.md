## 1.1.0

### enhancements

* Add support for Rails 4.2
* Rails 4.2 generates a generic layout for mailers, and so do Markerb now.
* Support Kramdown as a different option to parse markdown, which has better
  JRuby support. Now you need to add either `redcarpet` or `kramdown` to your
  Gemfile, as `markerb` does not have `redcarpet` as a dependency anymore.

## 1.0.2

### enhancements

* Add support for Rails 4.0/4.1
* Drop support for Rails 3.0/3.1 and Ruby 1.8, keep support for Rails 3.2
