# frozen_string_literal: true

require 'csv'
require_relative 'available_books'

class BorrowBookService
  def initialize(books_table_path, booked_books_path)
    @books_table_path = books_table_path
    @booked_books_path = booked_books_path
  end

  def borrow_book(book_id, username)
    available_books = get_available_books(@books_table_path, @booked_books_path)

    find_book = available_books.find { |book| book['Book ID'] == book_id }
    raise BookNotAvailableError, book_id unless find_book

    File.write(@booked_books_path, "#{book_id}, #{username}\n", mode: 'a')
    puts "You have borrowed: #{find_book['Book Name']}"
  end
end
