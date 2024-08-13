require_relative '../vincent_vanhaaff_resume'
require 'fileutils'

class GenerateMarkdown
  def initialize
    @vincent = VincentVanHaaff.new
  end

  def generate
    markdown = []
    markdown << "# #{@vincent.first_name} #{@vincent.last_name}"
    markdown << "[#{@vincent.website}](https://#{@vincent.website}) | [#{@vincent.phone}](tel:#{@vincent.phone.gsub(' ', '')}) | [LinkedIn](https://#{@vincent.linkedin})"
    markdown << "\n## Summary\n#{VincentVanHaaff.who}"
    markdown << "\n## Skills"
    
    Experience.skills.each do |category, skills|
      markdown << "### #{category.to_s.humanize}"
      markdown << skills.map { |skill| "- #{skill}" }.join("\n")
    end

    markdown << "\n## Experience"
    Experience.work.each do |job|
      markdown << "### #{job[:company]}"
      markdown << "**#{job[:roles].join(', ')} | #{job[:when].first.strftime('%b %Y')} - #{job[:when].last == Time.now.to_s ? 'Present' : job[:when].last.strftime('%b %Y')}**"
      markdown << job[:description].map { |desc| "- #{desc}" }.join("\n")
    end

    markdown << "\n## Acknowledgements & Affiliations"
    markdown << VincentVanHaaff.acknowledgements.map { |ack| "- #{ack}" }.join("\n")

    save_to_file(markdown.join("\n\n"))
  end

  def save_to_file(content)
    # Ensure the static/ directory exists
    FileUtils.mkdir_p("../static")

    File.open("../static/vincent_vanhaaff_resume.md", "w") do |file|
      file.write(content)
    end

    puts "Markdown file generated at ../static/vincent_vanhaaff_resume.md"
  end
end

GenerateMarkdown.new.generate
