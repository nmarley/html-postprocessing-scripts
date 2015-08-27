#! /usr/bin/env ruby
#
# active_record.rb
#
# Example of using ActiveRecord without Rails to query a (Postgres) DB.

require 'active_record'
require 'pp'

ActiveRecord::Base.establish_connection(
  adapter:  'postgresql',
  database: 'sebastmarsh',
  username: 'sebastmarsh'
)

class Post < ActiveRecord::Base
end

pp Post.first


