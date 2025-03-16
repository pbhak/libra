require 'dotenv'
require 'tty-prompt'
require 'tty-table'

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
      get_all_users_as_hash(conn)
    when 'Get user information'
    when 'Create user'
      user = create_user(conn, prompt.ask('Name:'))
      puts "Created user #{user['name']} with ID #{user['id']}"
    when 'Update user'
    when 'Delete user'
      if delete_user(conn, prompt.ask('ID of user to delete:'))
        puts 'User deleted successfully'
      else
        puts 'Error deleting user'
      end
    end
  end

  def create_user(conn, name)
    # Create a new user given a Postgres connection object and the user's name, returns the id and name in a hash
    conn.exec("INSERT INTO users (name) VALUES ('#{name}') RETURNING id, name")[0]
  end

  def get_all_users_as_hash(conn)
    # Get a hash of all users given a Postgres connection object
    res = conn.exec('SELECT * FROM users')
    table = TTY::Table.new(['ID', 'Name', 'Creation Date', '# Books'], [])
    all_fields = [res.field_values('id'), res.field_values('name'), res.field_values('creation_date'), res.field_values('books')]
    
    all_fields[0].length.times do |index|
      table << [all_fields[0][index], all_fields[1][index], all_fields[2][index].strftime("%m/%e/%y %r UTC%-:::z"), all_fields[3][index].length]
    end

    puts table.render(:unicode)
  end

  def delete_user(conn, id)
    # Given a connection object and a user ID, attempt to delete the user with that ID.
    # Returns the ID of the deleted user if succesful, and false if otherwise (e.g. the user does not exist)
  end
end