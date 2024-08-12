#require_relative 'resume_pdf'
require 'io/console'

class InteractiveShell
  def initialize
    @vincent = VincentVanHaaff.new
  end

  def start
    puts "Welcome to #{@vincent.first_name} #{@vincent.last_name}'s Interactive Resume!"
    puts "\nSummary:\n#{VincentVanHaaff.who}"
    menu
  end

  def menu
    loop do
      puts "\nPlease choose an option:"
      puts "1. Render PDF"
      puts "2. Get in touch!"
      puts "3. View website"
      puts "4. Exit"
      print "> "

      choice = $stdin.getch.strip

      case choice
      when '1'
        render_pdf
      when '2'
        get_in_touch
      when '3'
        view_website
      when '4'
        exit_program
      else
        puts "Invalid choice. Please try again."
      end
    end
  end

  #def render_pdf
    #puts "Rendering PDF..."
    #ResumePDF.new
    #puts "PDF rendered successfully."
  #end

  def render_pdf
    puts "Rendering PDF..."
    ResumePDF.new
    pdf_filename = "#{@vincent.first_name}_#{@vincent.last_name}_Resume.pdf"

    case RUBY_PLATFORM
    when /darwin/
      system("open", pdf_filename)       # macOS
    when /linux/
      system("xdg-open", pdf_filename)   # Linux
    when /mingw|mswin/
      system("start", pdf_filename)      # Windows
    else
      puts "Unsupported platform. Please open the PDF manually."
    end

    puts "PDF rendered and opened successfully."
  end


  def get_in_touch
    mailto = "mailto:#{@vincent.first_name.downcase}@#{@vincent.last_name.downcase.gsub(' ', '')}.com"

    case RUBY_PLATFORM
    when /darwin/
      system("open", mailto)       # macOS
    when /linux/
      system("xdg-open", mailto)   # Linux
    when /mingw|mswin/
      system("start", mailto)      # Windows
    else
      puts "Unsupported platform. Please open your email client manually."
    end
  end


  #def get_in_touch
    #puts "Opening mailto:#{@vincent.first_name.downcase}@#{@vincent.last_name.downcase.gsub(' ', '')}.com"
    #@vincent.contact
  #end

  #def get_in_touch
    #puts "Opening mailto:#{@vincent.first_name.downcase}@#{@vincent.last_name.downcase.gsub(' ', '')}.com"
    #VincentVanHaaff.contact
  #end

  def view_website
    puts "Opening website #{@vincent.website}..."
    `open https://#{@vincent.website}`
  end

  def exit_program
    puts "Goodbye!"
    exit
  end
end
