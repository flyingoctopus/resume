# Vincent's Resume Builder

## Overview

This project dynamically generates a resume written in Ruby as a professional PDF resume, provides an interactive shell for users to explore various functionalities, and even includes a text adventure game inspired by classic Infocom games like Zork. Take a look at [vincent_vanhaaff_resume.rb](vincent_vanhaaff_resume.rb) to see how it all comes together!

## Project Structure

The project consists of several Ruby files, each with a specific purpose:

- `vincent_vanhaaff_resume.rb`: The core file that defines the `VincentVanHaaff` class, managing skills, experience, and other resume-related data.
- `support/resume_pdf.rb`: Handles the PDF generation using the `Prawn` library.
- `support/interactive_shell.rb`: Provides an interactive command-line interface for users to interact with the resume.
- `support/text_adventure_game.rb`: A text-based adventure game that lets users explore Vincent's office and interact with the resume content in a playful way.
- `support/generate_markdown.rb`: Generates a Markdown version of the resume for use as a static website.
- `support/resume_actions.rb`: Contains shared methods for rendering PDFs, opening links, and other actions used across the application.

## Features

- **Resume PDF Generation**: Generate a PDF version of the resume with the latest data.
- **Interactive Shell**: Allows users to interact with the resume data through a command-line interface.
- **Text Adventure Game**: Explore Vincent's office and interact with objects in a text-based game.
- **Markdown Resume Generation**: Convert the resume data into a Markdown file for use as a static website.
- **Hyperlinks**: The generated PDF includes clickable links for email, website, and LinkedIn.
- **Customizable Content**: Easily update skills, experience, and acknowledgements.

## Getting Started

### Prerequisites

Ensure you have the following installed:

- macOS with Homebrew installed

### Installing Ruby

To quickly install Ruby on macOS (system Ruby requires sudo now, ew), you can use Homebrew, which is a popular package manager for macOS.

1. Install Homebrew if you haven't already. Follow the instructions
   [here](https://brew.sh) if you need help.

2. Install Ruby using Homebrew:

   ```bash
   brew install ruby
   ```

3. Add Ruby to your `PATH`:

   ```bash
   echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
   source ~/.zshrc
   ```

4. Verify the installation:

   ```bash
   ruby -v
   ```

For more detailed instructions and alternative installation methods for other OSes, visit the [official Ruby installation guide](https://www.ruby-lang.org/en/documentation/installation/).

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/flyingoctopus/resume.git
   cd resume
   ```

2. Install the required gems:

   ```bash
   bundle install
   ```

### Usage

You can run the resume project using the following command:

```bash
ruby vincent_vanhaaff_resume.rb
```

### Interactive Shell

After running the script, you will be presented with an interactive shell:

```
🎉 Welcome to Vincent van Haaff's Interactive Resume! 🎉

Summary:
I am a passionate technical creative and engineer...

🔍 What would you like to do? Please choose an option and press enter:
1. 📄 Render PDF
2. ✉️ Get in touch!
3. 🌐 View website
4. 💼 View LinkedIn Profile
5. 🧭 Explore
6. 🎮 Let's Play A Text Adventure Game
7. 🚪 Exit
```

#### Options:

- **Render PDF**: Generates a PDF of the resume and opens it automatically.
- **Get in touch**: Opens your default email client with a pre-filled "mailto" link.
- **View website**: Opens the default web browser to your personal website.
- **View LinkedIn Profile**: Opens the default web browser to your LinkedIn profile.
- **Explore**: Dive deeper into the resume content by exploring personal details, acknowledgements, and objectives.
- **Text Adventure Game**: Engage in a fun, text-based adventure game set in Vincent's office.
- **Exit**: Exits the interactive shell.

### Markdown Resume Generation

To generate a Markdown version of the resume for use as a static website, run the following command:

```bash
ruby support/generate_markdown.rb
```

The generated Markdown file will be saved in the `build/` directory.

### Customization

You can customize the resume content by editing the `vincent_vanhaaff_resume.rb` file. Here, you can update:

- **Personal Information**: Name, website, phone number, etc.
- **Skills**: Programming languages, tools, and other competencies.
- **Experience**: Job history, including companies, roles, and descriptions.
- **Acknowledgements & Affiliations**: Special recognitions and affiliations.

### Dependencies

This project relies on the following Ruby gems:

- `prawn`: For PDF generation.
- `mini_magick`: For image processing in PDF generation.
- `active_support`: For various utility methods and extensions.
- `active_model`: For object modeling.

These are automatically installed when you run `bundle install`.

## Contributing

Feel free to fork this repository and submit pull requests if you have any improvements or additional features you would like to add.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

## Acknowledgments

Special thanks to the open-source community for providing the tools and libraries used in this project.

Technical resume: vincent_vanhaaff_resume.rb  
Site: https://vvh.io  
Old boring resume: http://resume.linkedinlabs.com/6lz5adls
