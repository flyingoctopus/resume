require_relative 'resume_actions'
require_relative 'support/text_adventure_game'

class InteractiveShell
  include ResumeActions

  COLUMN_WIDTH = 80

  def initialize
    @vincent = VincentVanHaaff.new
  end

  def start
    puts format_text("🎉 Welcome to #{@vincent.first_name} #{@vincent.last_name}'s Interactive Resume! 🎉")
    puts format_text("\nSummary:\n#{VincentVanHaaff.who}")
    menu
  end

  def menu
    loop do
      puts format_text("\n")
      puts format_text("🔍 What would you like to do? Please choose an option and press enter:")
      puts format_text("1. 📄 Render PDF")
      puts format_text("2. ✉️ Get in touch!")
      puts format_text("3. 🌐 View website")
      puts format_text("4. 🧭 Explore")
      puts format_text("5. 🎮 Let's Play A Text Adventure Game")
      puts format_text("6. 🚪 Exit")
      print "> "

      choice = gets.strip

      case choice
      when '1'
        render_pdf
      when '2'
        get_in_touch
      when '3'
        view_website
      when '4'
        explore
      when '5'
        play_text_adventure_game
      when '6'
        exit_program
      when '42', 'secret'
        easter_egg
      else
        puts format_text("⚠️ Invalid choice. Please try again.")
      end
    end
  end

  def view_website
    puts format_text("🌐 Opening website #{@vincent.website}...")
    `open https://#{@vincent.website}`
  end

  def explore
    loop do
      puts format_text("\n")
      puts format_text("🧭 Explore Vincent's Resume:")
      puts format_text("1. 🧑‍💻 Who is Vincent?")
      puts format_text("2. 🎓 View Acknowledgements & Affiliations")
      puts format_text("3. 🎯 View Objectives")
      puts format_text("4. 🔙 Back to Main Menu")
      print "> "

      choice = gets.strip

      case choice
      when '1'
        puts format_text("\n")
        puts "#{format_text(VincentVanHaaff.who)}"
      when '2'
        puts format_text("\n")
        puts format_text("🎓 Acknowledgements & Affiliations:")
        VincentVanHaaff.acknowledgements.each do |ack|
          puts format_text("• #{ack}")
        end
      when '3'
        puts format_text("\n")
        puts format_text("🎯 Objectives:")
        VincentVanHaaff.objectives.each do |obj|
          puts format_text("• #{obj}")
        end
      when '4'
        return
      else
        puts format_text("⚠️ Invalid choice. Please try again.")
      end
    end
  end

  def play_text_adventure_game
    puts format_text("🎮 Starting Text Adventure Game...")
    TextAdventureGame.new.start
  end

  def easter_egg
    puts format_text("\n")
    puts format_text("🎉 Congratulations! You've found the Easter egg! 🎉")
    puts format_text("As a reward, here's a secret message:")
    puts format_text("\"The answer to life, the universe, and everything is 42.\"")
    puts format_text("Feel free to explore more, or just take a moment to appreciate the little things. 😉")
  end

  def exit_program
    puts format_text("👋 Goodbye!")
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
