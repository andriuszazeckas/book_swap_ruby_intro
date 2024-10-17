require 'csv'
require_relative 'available_books'

class BorrowBook
  def initialize(books_table_path, booked_books_path)
    @books_table_path = books_table_path
    @booked_books_path = booked_books_path
  end

  def borrow(book_id, username)
    available_books = get_available_books(@books_table_path, @booked_books_path)

    find_book = available_books.find { |book| book['Book ID'] == book_id }
    if find_book
      File.write(@booked_books_path, "#{book_id}, #{username}\n", mode: 'a')
      puts "You have borrowed: #{find_book['Book Name']}"
    else
      puts "Book with ID #{book_id} not found."
    end
  end
end


