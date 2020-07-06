require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

#stops sql queries from showing up on terminal
ActiveRecord::Base.logger = nil