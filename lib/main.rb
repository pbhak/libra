require 'tty-prompt'

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