source 'https://rubygems.org'

group :jekyll_plugins do
  gem 'jekyll', '~> 4.3'
  gem 'jekyll-email-protect'
  gem 'jekyll-github-metadata'
  gem 'jekyll-paginate-v2'
  gem 'jekyll-scholar'
  gem 'jekyll-twitter-plugin'
  gem 'jemoji'
  gem 'unicode_utils'
  gem 'bibtex-ruby'
  gem 'webrick'
end

# Needed by jemoji / activesupport on newer Rubies
gem 'activesupport', '~> 7.1.0'
gem 'json', '~> 2.7.2'

# eventmachine native build can fail on newer macOS; use upstream master
gem 'eventmachine', github: 'eventmachine/eventmachine', branch: 'master'

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem 'tzinfo', '~> 1.2'
  gem 'tzinfo-data'
end

# Performance-booster for watching directories on Windows
gem 'wdm', '~> 0.1.1', platforms: [:mingw, :x64_mingw, :mswin]

gem 'ffi', '~> 1.15'
