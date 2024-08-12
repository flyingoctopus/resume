require 'prawn'

class ResumePDF < Prawn::Document
  def initialize
    @vincent = VincentVanHaaff.new
    super(margin: [50, 50, 50, 50])
    font_families.update("Helvetica" => {
      normal: "Helvetica",
      bold: "Helvetica-Bold",
      italic: "Helvetica-Oblique"
    })
    font("Helvetica")

    repeat(:all) { centered_header }  # Repeats the centered header on all pages

    # Render the skills summary in the sidebar column first
    bounding_box([bounds.width * 0.75, cursor + 0], width: bounds.width * 0.25, height: bounds.height - 150) do
      skills_summary
    end

    # Adjust cursor to start the main content area after the header
    move_cursor_to bounds.top - 100

    # Render the summary and experience sections in the main column
    bounding_box([0, cursor], width: bounds.width * 0.7) do
      summary
      move_down 20
      experience
    end

    # Add acknowledgements at the end
    move_down 20
    acknowledgements

    save_to_file
  end

  def centered_header
    font("Helvetica", size: 36, style: :bold) do
      text "#{@vincent.first_name} #{@vincent.last_name}", align: :center
    end
    move_down 10
    font("Courier", size: 12) do
      formatted_text = [
        { text: @vincent.website, link: "https://#{@vincent.website}", styles: [:underline] },
        { text: " | ", styles: [] },
        { text: mailto_link, link: mailto_link, styles: [:underline] },
        { text: " | ", styles: [] },
        { text: "#{@vincent.phone}", link: "tel:#{@vincent.phone.gsub(' ', '')}", styles: [:underline] }
      ]
      text formatted_text.map { |entry| entry[:text] }.join, align: :center, inline_format: true
    end
    move_down 30
  end

  def mailto_link
    "#{@vincent.first_name.downcase}@#{@vincent.last_name.downcase.gsub(' ', '')}.com"
  end

  def skills_summary
    font("Helvetica", size: 20, style: :bold) do
      text "Skills"
    end
    move_down 15
    skills_hash = Experience.skills
    skills_hash.each do |category, skills|
      font("Helvetica", size: 10, style: :bold) do
        text "#{category.to_s.humanize}:"
      end
      font("Helvetica", size: 8) do
        text skills.join(', ')
      end
      move_down 10
    end
  end

  def summary
    font("Helvetica", size: 20, style: :bold) do
      text "Summary"
    end
    move_down 15
    font("Helvetica", size: 12) do
      text VincentVanHaaff.who
    end
  end

  def experience
    font("Helvetica", size: 24, style: :bold) do
      text "Experience"
    end
    move_down 15

    Experience.work.each do |job|
      font("Helvetica", size: 20, style: :bold) do
        text "#{job[:company]}"
      end
      font("Helvetica", size: 14, style: :italic) do
        text "#{job[:roles].join(', ')} | #{job[:when].first.strftime('%B %Y')} - #{job[:when].last == Time.now.to_s ? 'Present' : job[:when].last.strftime('%B %Y')}"
      end
      move_down 10
      job[:description].each do |desc|
        format_description(desc)
      end
      move_down 20

      # Adjust the starting position of the next job to avoid overlap with the header on the next page
      start_new_page if cursor < 100
    end
  end

  def format_description(desc)
    formatted_text = [{ text: "• ", styles: [:bold], size: 14 }] # Add the bullet point first

    desc.split(/(\*\*.*?\*\*|_.*?_)/).each do |segment|
      if segment.start_with?('**') && segment.end_with?('**')
        formatted_text << { text: segment[2..-3], styles: [:bold], size: 14 }
      elsif segment.start_with?('_') && segment.end_with?('_')
        formatted_text << { text: segment[1..-2], styles: [:italic], size: 14 }
      else
        formatted_text << { text: segment, size: 14 }
      end
    end

    formatted_text(formatted_text)
  end

  def acknowledgements
    font("Helvetica", size: 24, style: :bold) do
      text "Acknowledgements & Affiliations"
    end
    move_down 15
    VincentVanHaaff.acknowledgements.each do |ack|
      font("Helvetica", size: 14) do
        text "• #{ack}"
      end
    end
    move_down 30
  end

  def save_to_file
    filename = "#{@vincent.first_name}_#{@vincent.last_name}_Resume.pdf"
    render_file(filename)
  end
end
