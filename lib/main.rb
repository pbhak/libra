require 'dotenv'
require 'pg'
require 'tty-prompt'
require 'pg'

require_relative 'book_info'

include BookInfo

print 'Establishing database connection.'

sleep 0.5
print '.'

begin 
  Dotenv.load('.env')
  conn = PG.connect( dbname: ENV['dbname'], user: ENV['psql_username'], password: ENV['psql_password'] )
  conn.type_map_for_results = PG::BasicTypeMapForResults.new(conn)
rescue
  puts "\nError connecting to database. Check your PostgreSQL credentials."
  exit
end

2.times do
  sleep 0.5
  print '.'
end

Gem.win_platform? ? system('cls') : system('clear')

conn = PG.connect( dbname: 'postgres', user: 'postgres', password: 'postgres' )
conn.type_map_for_results = PG::BasicTypeMapForResults.new(conn)

puts 'Welcome to Libra!'

prompt = TTY::Prompt.new

# prompt for sign in?
options = [
  'Book status',       # 0
  'Book information',  # 1
  'Check out',         # 2
  'Check in',          # 3
  'Renew'              # 4
]

selected_option = prompt.select('What would you like to do?', options)

case selected_option
when 'Book status'
  # TODO implement book status
when 'Book information'
  # TODO add a spinner while the request is being made and add handling for invalid ISBNs/invalid requests
  isbn = prompt.ask('ISBN:')
  p book_info(isbn)
when 'Check out'
  # TODO implement check out
when 'Check in'
  # TODO implement check in
when 'Renew'
  # TODO implement renew
end

# all_arrays = []
# conn.exec("SELECT books FROM users").each do |books|
#   all_arrays << books['books']
# end

# p all_arrays
