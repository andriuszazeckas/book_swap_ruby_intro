require 'csv'
require_relative 'available_books'

module BorrowBook
  def self.borrow(book_id, username)
    available_books = get_available_books(BOOKS_TABLE_PATH, BOOKED_BOOKS_PATH)

    find_book = available_books.find { |book| book['Book ID'] == book_id }
    if find_book

      File.write('borrowed_books.db', "#{book_id}, #{username}\n", mode: 'a')

      puts "You have borrowed: #{find_book['Book Name']}"
    else
      puts "Book with ID #{book_id} not found."
    end
  end
end

