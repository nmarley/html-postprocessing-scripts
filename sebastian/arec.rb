#! /usr/bin/env ruby
#
# active_record.rb
#
# Example of using ActiveRecord without Rails to query a (Postgres) DB.

require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:  'postgresql',
  database: 'sebastmarsh_dev',
  username: 'sebastmarsh'
)

class Post < ActiveRecord::Base
  validates :slug, presence: true,
    uniqueness: { case_sensitive: false }
end

