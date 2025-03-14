require 'dotenv'
require 'pg'
require 'tty-prompt'
require 'pg'

require_relative 'book_info'
require_relative 'users'

include BookInfo
include Users

def ctrlc
  puts
  puts 'Ctrl-C received, exiting...'
  exit 130
end

trap 'SIGINT' do # Control+C received
  ctrlc
end

print 'Establishing database connection.'

sleep 0.25
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
  sleep 0.25
  print '.'
end

puts 'Welcome to Libra!'

sleep 0.5

prompt = TTY::Prompt.new

# prompt for sign in?
options = [
  'Book status',     
  'Book information',
  'Check out',       
  'Check in',        
  'Renew',           
  'Users'
]

begin
  loop do
    Gem.win_platform? ? system('cls') : system('clear')
    selected_option = prompt.select('What would you like to do?', options)

    case selected_option
    when 'Book status'
      # TODO implement book status
    when 'Book information'
      isbn = prompt.ask('ISBN:')
      p book_info(isbn)
    when 'Check out'
      # TODO implement check out
    when 'Check in'
      # TODO implement check in
    when 'Renew'
      # TODO implement renew
    when 'Users'
      users_prompt(conn)
    end

    prompt.keypress('Press any key to continue...')

    puts
  end
rescue TTY::Reader::InputInterrupt
  # tty-reader throws a seperate exception when a Control+C is received
  ctrlc
end
