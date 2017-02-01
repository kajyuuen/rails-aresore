# Gemfile
gem_group :test, :development do
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'
  gem 'guard-rspec', require: false
  gem 'terminal-notifier-guard'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'rails-erd'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'faker'
  gem 'faker-japanese'
  gem 'hirb'
  gem 'brakeman', require: false
  gem 'rails_best_practices'
end

gem_group :development do
  gem 'capistrano',             require: false
  gem 'capistrano-rails',       require: false
  gem 'capistrano-rbenv',       require: false
  gem 'capistrano-bundler',     require: false
  gem 'capistrano3-unicorn',    require: false
end

gems = {}

if yes?('create API?')
  gems['grape'] = yes?('use grape?')
  if gems['grape']
    gem 'grape'
    gem 'grape-entity'
  end
else
  gems['slim-rails'] = yes?('use slim ?')
  if gems['slim-rails']
    gem 'slim-rails'
  end

  gems['twitter'] = yes?('use twitter ?')
  if gems['twitter']
    gem 'omniauth'
    gem 'omniauth-twitter'

    if yes?('use twitter api ?')
      gem 'twitter'
    end
  end

  gems['facebook'] = yes?('use facebook ?')
  if gems['facebook']
    gem 'omniauth'
    gem 'omniauth-facebook'

    if yes?('use facebook api ?')
      gem 'koala'
    end
  end
end

if yes?('bundle install to vendor/bundler?')
  run 'bundle install --path=vendor/bundler'
else
  run 'bundle install'
end

# 各gemの初期設定

# rspec
run 'rm -rf test'
generate 'rspec:install'

# cp database.yml
run 'cp config/database.yml config/database.yml.sample'

if yes?('run migrate ?')
  rake "db:create"
  rake "db:migrate"
end
