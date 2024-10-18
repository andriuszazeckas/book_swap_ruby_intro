class BookNotAvailableError < StandardError
  def initialize(message = "The requested book is not available for borrowing")
    super(message)
  end
end