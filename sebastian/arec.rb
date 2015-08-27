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

class ArchivePage < ActiveRecord::Base
end

class Post < ActiveRecord::Base
  def get_url
    self.slug.empty? ? "uid/#{self.post_uid}" : self.slug
  end
end

class Stat < ActiveRecord::Base
end
