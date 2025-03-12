require 'tty-prompt'
require 'pg'

puts 'Welcome to Libra!'

# TODO: test compatibility of the TTY toolkit on Windows systems
prompt = TTY::Prompt.new

# prompt for sign in?
options = [
  'Book status',       # 0
  'Book information',  # 1
  'Check out',         # 2
  'Check in',          # 3
  'Renew'              # 4
]

selected_option = options.index(prompt.select('What would you like to do?', options))

puts "Selected option #{selected_option}"

# note: the date string format used here is date %m-%d-%Y %H:%M:%S %Z

conn = PG.connect( dbname: 'postgres', user: 'postgres', password: 'postgres' )
p conn.exec('select books from users where id = 1').values[0][0][1..-2].split(',')