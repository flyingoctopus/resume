require 'prawn'
require 'mini_magick'
require 'prawn/measurement_extensions'  # For easier size management with points
require 'tempfile'

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

    repeat(:all) do
      centered_header
      #footer_text
    end

    # Render the skills summary in the sidebar column first
    bounding_box([bounds.width * 0.75, cursor + 5], width: bounds.width * 0.25, height: bounds.height - 150) do
      skills_summary
    end

    # Adjust cursor to start the main content area after the header
    move_cursor_to bounds.top - 125

    # Render the summary and experience sections in the main column
    bounding_box([0, cursor], width: bounds.width * 0.7) do
      summary
      move_down 20
      experience
    end

    # Add acknowledgements at the end
    move_down 20
    acknowledgements

    # Now, add the page numbers after the content is generated
    number_pages "<page> / <total>", {
      start_count_at: 1,
      at: [bounds.right - 50, 0],
      align: :right,
      size: 10,
      inline_format: true
    }

    save_to_file
  end

  def centered_header
    # Process the image at build time and get it in memory
    circular_image_file = process_image_at_build_time

    # Calculate the size and position of the image
    image_height = 3 * 12  # 3x the height of a 12px line height
    image_width = image_height  # Keeping it square
    image_x = bounds.width / 2 - image_width / 2
    image_y = bounds.top

    # Insert the processed image directly into the PDF
    image circular_image_file.path, at: [image_x, image_y], width: image_width, height: image_height

    # Clean up the tempfile
    circular_image_file.close
    circular_image_file.unlink

    move_down image_height

    # Add the text header below the image
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
        { text: "#{@vincent.phone}", link: "tel:#{@vincent.phone.gsub(' ', '')}", styles: [:underline] },
        #{ text: " | ", styles: [] },
        #{ text: "LinkedIn", link: "https://#{@vincent.linkedin}", styles: [:underline] }
      ]
      text formatted_text.map { |entry| entry[:text] }.join, align: :center, inline_format: true
    end
    move_down 30
  end

  def process_image_at_build_time
    original_image_path = 'static/vincent.png'

    # Open the original image
    image = MiniMagick::Image.open(original_image_path)

    # Resize and crop the image to a square
    image.combine_options do |c|
      c.resize "100x100^"  # Resize to fill a 100x100 square, maintaining aspect ratio
      c.gravity "center"   # Center the crop
      c.crop "100x100+0+0" # Crop to a 100x100 square
    end

    # Create a circular mask
    mask = MiniMagick::Image.open(original_image_path)
    mask.combine_options do |c|
      c.alpha 'transparent'
      c.background 'none'
      c.gravity 'center'
      c.fill 'white'
      c.draw 'circle 50,50 50,0'
    end

    # Apply the circular mask to the image
    circular_image = image.composite(mask) do |c|
      c.compose "DstIn" # Only keep the parts inside the circle
    end

    # Write the circular image to a tempfile
    tempfile = Tempfile.new(['vincent_circle', '.png'])
    circular_image.write(tempfile.path)

    tempfile
  end

  def footer_text
    bounding_box([bounds.left, bounds.bottom + 25], width: bounds.width) do
      font("Helvetica", size: 6) do
        text "PDF resume generated my resume written in Ruby", align: :center
      end
    end
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
    font("Helvetica", size: 20, style: :bold) do
      text "Experience"
    end
    move_down 15

    Experience.work.each do |job|
      font("Helvetica", size: 16, style: :bold) do
        text "#{job[:company]}"
      end
      font("Helvetica", size: 12, style: :italic) do
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
    formatted_text = [{ text: "• ", styles: [:bold], size: 12 }] # Add the bullet point first

    desc.split(/(\*\*.*?\*\*|_.*?_)/).each do |segment|
      if segment.start_with?('**') && segment.end_with?('**')
        formatted_text << { text: segment[2..-3], styles: [:bold], size: 12 }
      elsif segment.start_with?('_') && segment.end_with?('_')
        formatted_text << { text: segment[1..-2], styles: [:italic], size: 12 }
      else
        formatted_text << { text: segment, size: 12 }
      end
    end

    formatted_text(formatted_text)
  end

  def acknowledgements
    font("Helvetica", size: 20, style: :bold) do
      text "Acknowledgements & Affiliations"
    end
    move_down 15
    VincentVanHaaff.acknowledgements.each do |ack|
      font("Helvetica", size: 12) do
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
