require 'coveralls'
Coveralls.wear_merged!('rails')
require 'webmock/rspec'
WebMock.enable!

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'spec_helper'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
  config.include ResponseJSON
  config.before do
    movie_db = "https://api.themoviedb.org/3/discover"
    stub_request(:get, %r[#{movie_db}.*])
         .to_return(status: 200, body: file_fixture("random_movie_response.json").read, headers: {})
  end
  config.before(:each) do
    StripeMock.start
  end
  config.after(:each) do
    StripeMock.stop
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end