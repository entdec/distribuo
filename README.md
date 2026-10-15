# Distribuo

Easy to use in-house distribution of Mobile apps. For now Enterprise and Ad-Hoc apps only.

## Features

- Several app operating systems: iOS/Android/Windows/MacOS/tvOS
- Several release types: Alpha/Beta/Enterprise/Production/Store/Custom
- Icon extraction from apk/ipa
- Build-information extraction from apk/ipa (build-number, version-string, bundle-id, etc)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'distribuo'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install distribuo
```

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Tables (Mensa)

Distribuo's tables inherit from `Distribuo::ApplicationTable < Mensa::Base`.
They require PostgreSQL. The bundled Mensa revision and its migrations are tested
with Rails 8.1.4 (Mensa declares Rails >= 7.1). In the host application's Gemfile,
configure `git_source(:entdec) { |repo| "git@github.com:entdec/#{repo}.git" }`
and add `gem "mensa", entdec: "mensa"`, then bundle. Run `rails g mensa:install`,
`rails mensa:install:migrations`, and `rails db:migrate`; include Mensa's assets
and configure its base controller and authentication for your host application.
Keep the Mensa endpoints behind the same admin authentication as Distribuo.
The tables preserve the existing unrestricted admin scopes; they do not introduce
new policy scopes or change controller authorization.

Render apps with `table("distribuo/apps", params: {})` and releases with
`table("distribuo/releases", params: {app_id: app.id})`. The explicit app ID
survives pagination, filtering, sorting and exports. Both tables support custom
views and exports. Download counts are calculated in SQL without loading downloads.
The operating system column provides the platform filter.

From `test/dummy`, run `RAILS_ENV=test bundle exec rails db:prepare db:seed`
and `RAILS_ENV=test bundle exec rails mensa:verify_all`. Set `DATABASE_URL` for
your PostgreSQL service. The dummy task discovers the engine tables explicitly.
In a host, use `rails "mensa:verify[distribuo/apps]"` and
`rails "mensa:verify[distribuo/releases]"`. Run `bundle exec rake test` from the
repository root for regressions.
