require 'csv'

def get_booked_book_ids(file_path)
  booked_ids = []

  return booked_ids unless File.exist?(file_path)

  File.readlines(file_path).each do |line|
    book_id, _user = line.strip.split(',')
    booked_ids << book_id
  end

  booked_ids
end

def get_available_books(books_csv_path, booked_books_file_path)
  booked_books = get_booked_book_ids(booked_books_file_path)
  available_books = []

  unless File.exist?(books_csv_path)
    puts 'Books file not found.'
    return available_books
  end

  CSV.foreach(books_csv_path, headers: true) do |row|
    available_books << row unless booked_books.include?(row['Book ID'])
  end

  available_books
end

def list_available_books(books)
  if books.empty?
    puts 'No books available for borrowing.'
  else
    puts 'Book ID, Book Name, Author, Release Year'
    books.each do |book|
      puts "#{book['Book ID']}, #{book['Book Name']}, #{book['Author']}, #{book['Release Year']}"
    end
  end
end
