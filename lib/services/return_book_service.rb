require_relative 'available_books'

class ReturnBookService

  def return_book(booked_books_file_path, target_book_id)
    return unless File.exist?(booked_books_file_path)

    booked_books = get_booked_book_ids(BOOKED_BOOKS_PATH)
    if booked_books.include?(target_book_id)

      remaining_lines = get_remaining_lines(booked_books_file_path, target_book_id)

      File.open(booked_books_file_path, 'w') do |file|
        file.puts(remaining_lines)
      end
      puts "Book with ID #{target_book_id} returned successfully."
    else
      puts "Book with ID #{target_book_id} was not borrowed."
    end
  end

  private

  def get_remaining_lines(booked_books_file_path, target_book_id)
    File.readlines(booked_books_file_path).reject do |line|
      book_id, _user = line.strip.split(',')
      book_id == target_book_id
    end
  end
end
