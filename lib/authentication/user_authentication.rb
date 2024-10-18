require 'digest'

class UserAuthenticator
  attr_accessor :users_path

  def initialize(users_path)
    @users_path = users_path
    ensure_users_file_exists
  end

  def login
    puts "\nPlease enter your username to login:"
    username = gets.chomp.strip.downcase

    puts "\nPlease enter your password:"
    entered_password = gets.chomp.strip

    # Retrieve users data in a hash format
    users_data = read_users_data

    if users_data.key?(username) && users_data[username] == hash_password(entered_password)
      puts "\n'#{username}' welcome to Vinted book swap!\n"
    else
      puts 'Invalid username or password.'
      handle_registration(users_data)
    end
  end

  private

  def ensure_users_file_exists
    File.write(@users_path, "") unless File.exist?(@users_path)
  end

  def read_users_data
    # Read users from file and parse into a hash
    users_data = {}
    File.foreach(@users_path) do |line|
      user, password_hash = line.split(',')
      users_data[user.strip] = password_hash.strip if user && password_hash
    end
    users_data
  end

  def handle_registration(users_data)
    loop do
      puts 'You are not registered or entered wrong credentials! Register as a new user (y/n)?'
      confirmation = gets.chomp.strip.downcase

      case confirmation
      when 'y'
        register_new_user(users_data)
        break
      when 'n'
        puts 'You must register to use the app. Exiting.'
        exit
      else
        puts "Invalid input. Please enter 'y' to register or 'n' to exit."
      end
    end
  end

  def register_new_user(users_data)
    loop do
      puts 'Enter new username:'
      new_user = gets.chomp.strip.downcase

      if users_data.include?(new_user)
        puts 'Username exists, try another username.'
      else
        puts 'Enter new password:'
        new_password = gets.chomp.strip

        append_new_user(new_user, new_password)
        puts "User '#{new_user}' has been registered.\n"
        break
      end
    end
  end

  def append_new_user(new_user, new_password)
    File.open(@users_path, 'a') do |file|
      password_hash = hash_password(new_password)
      file.puts("#{new_user},#{password_hash}")
    end
  end

  def hash_password(password)
    # Use a simple hashing algorithm for demonstration purposes
    Digest::SHA256.hexdigest(password)
  end
end
