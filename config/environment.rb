require 'bundler'

Bundler.require


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
ActiveRecord::Base.logger = nil
<<<<<<< HEAD

require 'colorize'
require 'colorized_string'
=======
>>>>>>> efc8b8a504419dbd219b99baabae7c129d73a4cc
