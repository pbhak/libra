# frozen_string_literal: true

require 'pg'

# Module to handle checking out, renewal, and checking in books to users
module BookHandling
  def three_weeks_from_now
    (Time.now + (3 * 7 * 24 * 60 * 60)).strftime('%-m/%-e/%y %r UTC%-:::z')
  end

  def add_book(isbn, conn)
    begin
      conn.exec("INSERT INTO books (isbn, checked_out_on, remaining_renews) VALUES (#{isbn}, NULL, NULL)")
    rescue PG::UniqueViolation
      puts 'Error: book already exists in database'
      return
    end

    puts "Book #{isbn} added"
  end

  def check_book_out(user_id, isbn, conn)
    # Check a book out to a user given the user's ID, the book ISBN, and a Postgres connection object
    # Note: queries here will be using upserts (update row instead of insert if it already exists)
    # TODO: reimplement this in coordination with add_book
    begin
      conn.exec("INSERT INTO books (isbn, checked_out_to, due_on)
                VALUES (#{isbn}, #{user_id}, #{three_weeks_from_now})
                ON CONFLICT (isbn)
                DO UPDATE SET isbn = EXCLUDED.isbn, checked_out_to = EXCLUDED.checked_out_to, due_on = EXCLUDED.due_on")
    rescue # rubocop:disable Style/RescueStandardError
      puts 'Error inserting row'
      return false
    end
    true
  end
end
