class BookNotAvailableError < StandardError
  attr_reader :book_id

  def initialize(book_id)
    @book_id = book_id
    # Provide a default message if none is given
    super("The book with ID #{book_id} is not available for borrowing")
  end
end
