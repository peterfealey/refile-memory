# Refile::Shopify

A ShopifyAPI backend for [Refile](https://github.com/elabs/refile).

This is a work in progress, pull requests etc welcome. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'refile-shopify'
```

Set up Refile to use the Shopify backend:

``` ruby
Refile.configure do |config|
  config.cache = Refile::Shopify::Backend.new
  config.store = Refile::Shopify::Backend.new
end
```

## License

[MIT](License.txt)
