require 'dotenv'
require 'tty-prompt'

# Module for user handling (CRUD operations)
# This module assumes an already-functional PostgreSQL connection
module Users
  def users_prompt(conn)
    prompt = TTY::Prompt.new
    options = [
      'Get all users',
      'Get user information',
      'Create user',
      'Update user',
      'Delete user'
    ]
    case prompt.select('Users', options)
    when 'Get all users'
    when 'Get user information'
    when 'Create user'
      create_user(conn, prompt.ask('Name:'))
    when 'Update user'
    when 'Delete user'
    end
  end

  def create_user(conn, name)
    # Create a new user given a Postgres connection object and the user's name
    puts conn.exec("INSERT INTO users (name) VALUES ('#{name}')")
  end

  def get_all_users_as_hash(conn)
    # Get a hash of all users given a Postgres connection object

  end
end