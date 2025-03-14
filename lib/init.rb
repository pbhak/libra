require 'dotenv'
require 'pg'

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
puts "\n"

begin
  conn.exec("CREATE TABLE users ( 
              id SERIAL PRIMARY KEY, 
              name TEXT NOT NULL, 
              creation_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP, 
              books INTEGER[] DEFAULT ARRAY[]::INTEGER[])")
rescue PG::DuplicateTable
  puts 'Table users already exists'
end