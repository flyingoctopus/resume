# Vincent's Resume Builder

## Overview

This project dynamically generates a resume written in Ruby as a professional PDF resume and provides an interactive shell for users to explore various functionalities, such as rendering the resume as a PDF, viewing a website, or contacting via email. Take a look at [vincent_vanhaaff_resume.rb](vincent_vanhaaff_resume.rb)!

## Project Structure

The project consists of three main Ruby files:

- `rubyresume.rb`: The core file that defines the `VincentVanHaaff` class, manages skills, experience, and other resume-related data.
- `resume_pdf.rb`: Handles the PDF generation using the `Prawn` library.
- `interactive_shell.rb`: Provides an interactive command-line interface for users to interact with the resume.

## Features

- **Resume PDF Generation**: Generate a PDF version of the resume with the latest data.
- **Interactive Shell**: Allows users to interact with the resume data through a command-line interface.
- **Hyperlinks**: The generated PDF includes clickable links for email and website.
- **Customizable Content**: Easily update skills, experience, and acknowledgements.

## Getting Started

### Prerequisites

Ensure you have the following installed:

- Ruby 2.5 or higher
- Bundler (to manage gem dependencies)

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
Welcome to Vincent van Haaff's Interactive Resume!

Summary:
I am a passionate technical creative and engineer...

Please choose an option:
1. Render PDF
2. Get in touch!
3. View website
4. Exit
```

#### Options:

- **Render PDF**: Generates a PDF of the resume and opens it automatically.
- **Get in touch**: Opens your default email client with a pre-filled "mailto" link.
- **View website**: Opens the default web browser to your personal website.
- **Exit**: Exits the interactive shell.

### Customization

You can customize the resume content by editing the `rubyresume.rb` file. Here, you can update:

- **Personal Information**: Name, website, phone number, etc.
- **Skills**: Programming languages, tools, and other competencies.
- **Experience**: Job history, including companies, roles, and descriptions.
- **Acknowledgements & Affiliations**: Special recognitions and affiliations.

### Dependencies

This project relies on the following Ruby gems:

- `prawn`: For PDF generation.
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
