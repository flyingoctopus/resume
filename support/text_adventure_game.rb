require_relative 'resume_actions'

class TextAdventureGame
  include ResumeActions

  def initialize
    @vincent = VincentVanHaaff.new
    @location = :living_room
  end

  def start
    puts format_text("Welcome to Vincent van Haaff's Office! You are currently in the living room. What would you like to do?")
    game_loop
  end

  def game_loop
    loop do
      case @location
      when :living_room
        living_room
      when :office
        office
      when :mailbox
        mailbox
      else
        puts format_text("You seem lost. Let's go back to the living room.")
        @location = :living_room
      end
    end
  end

  def living_room
    puts format_text("\nYou are in the living room. You see a desk with a computer and a door leading to the office.")
    puts format_text("1. Go to the office")
    puts format_text("2. Look around")
    puts format_text("3. Exit Game")
    print "> "

    choice = gets.strip.downcase

    case choice
    when '1'
      @location = :office
    when '2'
      puts format_text("You see a picture of Vincent's family, some books on a shelf, and a cozy couch.")
    when '3'
      exit_game
    else
      puts format_text("I don't understand that command.")
    end
  end

  def office
    puts format_text("\nYou are in Vincent's office. You see Vincent sitting at his desk, a phone on the desk, and a mailbox.")
    puts format_text("1. Talk to Vincent")
    puts format_text("2. Use the phone")
    puts format_text("3. Open the mailbox")
    puts format_text("4. View LinkedIn Profile")
    puts format_text("5. Go back to the living room")
    print "> "

    choice = gets.strip.downcase

    case choice
    when '1'
      talk_to_vincent
    when '2'
      call_vincent
    when '3'
      @location = :mailbox
    when '4'
      view_linkedin
    when '5'
      @location = :living_room
    else
      puts format_text("I don't understand that command.")
    end
  end

  def mailbox
    puts format_text("\nYou are at the mailbox. You can:")
    puts format_text("1. Send an email to Vincent")
    puts format_text("2. Go back to the office")
    print "> "

    choice = gets.strip.downcase

    case choice
    when '1'
      get_in_touch
    when '2'
      @location = :office
    else
      puts format_text("I don't understand that command.")
    end
  end

  def talk_to_vincent
    puts format_text("\nYou talk to Vincent. He shares his story with you.")
    puts format_text("\n\"#{VincentVanHaaff.who}\"")
  end

  def exit_game
    puts format_text("You have left Vincent's Office. Goodbye!")
    exit
  end

  def format_text(text, width = 80)
    paragraphs = text.split("\n\n")
    formatted_paragraphs = paragraphs.map do |paragraph|
      paragraph.scan(/.{1,#{width}}(?:\s+|\Z)/).map(&:strip).join("\n")
    end
    formatted_paragraphs.join("\n\n")
  end
end
