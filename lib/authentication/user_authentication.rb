class UserAuthenticator
  def initialize(users_path)
    @users_path = users_path
    ensure_users_file_exists
  end

  def login
    loop do
      puts "\nPlease enter your username to login:"
      users_data = read_users_data
      user_input = gets.chomp.strip.downcase

      if users_data.include?(user_input)
        puts "\n'#{user_input}' welcome to Vinted book swap!\n"
        return user_input
      else
        handle_registration(users_data)
      end
    end
  end

  private

  def ensure_users_file_exists
    File.write(@users_path, "") unless File.exist?(@users_path)
  end

  def read_users_data
    File.read(@users_path).split.map(&:strip)
  end

  def handle_registration(users_data)
    loop do
      puts 'You are not registered! Register as a new user (y/n)?'
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
      new_user = gets.chomp.strip
      if users_data.include?(new_user)
        puts 'Username exists, try another username.'
      else
        append_new_user(new_user)
        puts "User '#{new_user}' has been registered.\n"
        break
      end
    end
  end

  def append_new_user(new_user)
    File.open(@users_path, 'a') { |file| file.puts(new_user) }
  end
end
