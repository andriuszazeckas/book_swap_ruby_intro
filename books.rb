# frozen_string_literal: true

require_relative 'lib/services/borrow_book'
require_relative 'lib/services/available_books'
require_relative 'lib/services/return_book_service'
require_relative 'lib/authentication/user_authentication'
require_relative 'custom_exceptions/book_not_available_error'

USERS_PATH = 'db/users.db'
BOOKS_TABLE_PATH = 'data/books.csv'
BOOKED_BOOKS_PATH = 'db/borrowed_books.db'

authenticator = UserAuthenticator.new(USERS_PATH)
current_user = authenticator.login

def options
  puts "\nPlease choose your options:"
  puts '1. List available books'
  puts '2. Borrow a book'
  puts '3. Return a book'
  puts '4. Exit'
end

loop do
  options
  user_option = gets.chomp.strip

  case user_option
  when '1'
    available_books = get_available_books(BOOKS_TABLE_PATH, BOOKED_BOOKS_PATH)
    list_available_books(available_books)
  when '2'
    puts 'Provide book id to borrow a book:'
    book_id = gets.chomp.strip
    borrow_book = BorrowBook.new(BOOKS_TABLE_PATH, BOOKED_BOOKS_PATH)
    borrow_book.borrow(book_id, current_user)
  when '3'
    puts 'To return book provide its id:'
    return_book_id = gets.chomp.strip
    return_book_service = ReturnBookService.new
    return_book_service.return_book(BOOKED_BOOKS_PATH, return_book_id)
  when '4'
    puts 'Exiting program. Have a great day!'
    break
  else
    puts 'Choose only 1, 2, 3 or 4'
  end
rescue BookNotAvailableError => e
  puts e.message
end
