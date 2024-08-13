module ResumeActions
  def render_pdf
    puts format_text("📄 Rendering PDF...")
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
      puts format_text("⚠️ Unsupported platform. Please open the PDF manually.")
    end

    puts format_text("✅ PDF rendered and opened successfully.")
  end

  def get_in_touch
    mailto = "mailto:#{@vincent.first_name.downcase}@#{@vincent.last_name.downcase.gsub(' ', '')}.com"
    puts format_text("✉️ Opening mailto:#{mailto}...")

    case RUBY_PLATFORM
    when /darwin/
      system("open", mailto)       # macOS
    when /linux/
      system("xdg-open", mailto)   # Linux
    when /mingw|mswin/
      system("start", mailto)      # Windows
    else
      puts format_text("⚠️ Unsupported platform. Please open your email client manually.")
    end
  end

  def view_linkedin
    linkedin_url = "https://#{@vincent.linkedin}"
    puts format_text("💼 Opening LinkedIn profile #{linkedin_url}...")

    case RUBY_PLATFORM
    when /darwin/
      system("open", linkedin_url)       # macOS
    when /linux/
      system("xdg-open", linkedin_url)   # Linux
    when /mingw|mswin/
      system("start", linkedin_url)      # Windows
    else
      puts format_text("⚠️ Unsupported platform. Please open your browser manually.")
    end
  end

  def call_vincent
    puts format_text("📞 You dial Vincent's number: #{@vincent.phone}.")
  end
end
