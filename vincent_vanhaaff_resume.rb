require 'active_support/all'
require 'active_model'
require_relative 'support/resume_pdf'
require_relative 'support/interactive_shell'

class VincentVanHaaff
  include ActiveModel::Model

  attr_accessor :first_name, :last_name, :website, :linkedin, :phone

  def initialize
    @first_name = "Vincent"
    @last_name = "van Haaff"
    @website = "vvh.io"
    @linkedin = "www.linkedin.com/in/vincentvanh/"
    @phone = "778.819.8605"
  end

  # Symbolic validations
  validates_presence_of :innovation
  validates_presence_of :learning_opportunities
  validates_presence_of :friendly_team
  validates_presence_of :pair_programming

  def self.objectives
    begin
      returning Array.new do |objs|
      objs << "Further develop my web development skills"
      objs.push "Have fun while contributing to some smart people's growth plans"
    end
    rescue Exception => e
      puts e
      # TODO: retry harder
    end
  end

  def self.contact
    `open mailto:##{@first_name.downcase}@##{@last_name.downcase}.com`
  end

  def self.who
    <<~WHO
      I am a passionate technical creative and engineer with over eighteen years of commercial experience and full-stack skills in the design, development, and maintenance of modern, user-centered tech-driven products and services. I also create engaging experiences for installation and video games on both the web and console, with a strong interest in performance, engagement, clean efficient code, and accomplishing it with a strong team.

      Besides work, I am a co-founder of Vancouver Maker Faire as well as Vancouver Hackspace and others. I am an educator, artist, and mentor living in Vancouver. I love climbing, cycling, good eats, and good times!
    WHO
  end

  def self.acknowledgements
    [
      "Stanford CCRMA Fellow",
      "El Camino Math Olympian",
      "Co-founder of Vancouver Mini-Makerfaire",
      "Co-founder of Vancouver Hackspace",
      "Co-founder of Aurora Digitalis"
    ]
  end

  def self.method_missing(method, *args, &block)
    if method =~ /^reference$/
      raise StandardError, "Talk to me first!"
    else
      puts "Got any questions about #{method} (#{args.join(', ')})?" \
      " then contact me!"
      contact
    end
  end

  private

  def self.returning(value)
    yield(value)
    value
  end
end

module Skills
  extend self

  def skills
    {
      engineering_direction: %w(User_Experience_Design Product_Design Systems_Engineering Data_Visualization 
                                Startup_Consulting Data_Driven_Intelligence Behaviour_Design),
      programming_languages: %w(C C++ Rust Ruby Golang Swift Python TensorFlow Node CUDA),
      web_development: %w(HTML CSS JavaScript React_js WebGL Webpack OpenFrameworks Processing),
      frameworks_tools: %w(Rails Django CQRS Docker),
      databases: %w(MySQL Postgres SQLite MongoDB Redis Salesforce Eventstore),
      testing_debugging: %w(Shoulda Cucumber RSpec Test::Unit Selenium gdb LLDB PyTest pdb GoTest Delve CargoTest Clippy),
      software_design_architecture: %w(ActiveRecord Sequel CQRS Microservices),
      infrastructure: %w(Kubernetes Docker Kafka Zookeeper Elasticsearch Logstash Kibana 
                        Terraform Ansible Jenkins GitHubActions AWS Azure Prometheus Grafana),
      version_control: %w(Git Perforce Subversion),
      servers_deployment: %w(Nginx Apache AWS HuggingFace Azure),
    }
  end
end

module Experience
  extend Skills
  extend self

  def parse_date(date_string)
    Date.parse(date_string) rescue nil
  end

  def work
    jobs = []

    jobs << { company: "a flyingoctopus consulting",
              industry: "Technical Consulting, Installation and Sound Art, Interactive Visuals",
              roles: ["Creative Director/Co-founder"],
              when: (parse_date("2010.11.01")...Time.now),
              description: [
                "Introduced improvements to systems and hardware enabling clients to reach their goals. Clients such as _Vancouver Airport Authority_, _Hewlett Packard_, _O'Reilly Media_, _Science World_, _Emerson Connect_, _Canadian Border Services Agency_, and _U.S. Customs & Border Patrol_.",
                "Focused on rapid **computer vision** solutions and hardware prototypes with a focus on **biometrics** and **machine learning**.",
                "Guided clients through product and business development cycles, utilizing **Agile** methodologies.",
                "Leveraged devOps and CI/CD pipelines **to bring technical teams to the finish line**.",
                "Established technical and project management infrastructure, including version control, data analysis, and documentation processes."
              ] }

    jobs << { company: "Synervoz Communications Inc.",
              industry: "AI-driven Audio DSP",
              roles: ["Senior Embedded Software Engineer"],
              when: (parse_date("2023.06.01")...parse_date("2024.04.01")),
              description: [
                "Crafted embedded firmware and infrastructure for an AI-driven audio DSP project on the Xtensa platform.",
                "Produced real-time embedded software for next-gen Bluetooth earbuds.",
                "Enhanced audio DSP pipeline reliability with low-level drivers and middleware in C.",
                "Optimized on-device model inferencing to bring extremely low power and low latency ai-driven AINR & DSP to market.",
                "Conducted system debugging, maintained code quality, and provided detailed technical documentation for project stakeholders.",
                "Delivered project requirements on time ensuring _client satisfaction_."
              ] }

    jobs << { company: "FarmLink Marketing Solutions",
              industry: "AI-driven SaaS Platform",
              roles: ["DevOps Automation/Quality Assurance Engineer"],
              when: (parse_date("2021.06.01")...parse_date("2022.10.01")),
              description: [
                "Supported pivot from financial newsletter for grain farmers to full-fledged ai-driven SaaS platform.",
                "Assembled and upheld GitHub Actions-centered development pipeline.",
                "Wrote automation and integration tests; including documented information architecture for the project.",
                "Managed a team of junior QA hires to achieve 100% test coverage.",
                "Met and exceeded stakeholder expectations."
              ] }

    jobs << { company: "Fluency Labs Inc.",
              industry: "Cloud-Native Applications",
              roles: ["Technical Lead"],
              when: (parse_date("2018.01.01")...parse_date("2020.10.01")),
              description: [
                "Constructed distributed computing framework for cloud-native applications with decentralized features.",
                "Launched and scaled Kafka/Zookeeper/Akka/Atom Kubernetes clusters for IoT data ingestion.",
                "Developed C++ libraries for distributed actor-driven systems.",
                "Mentored junior developers.",
                "Successfully deployed IoT data ingestion solution for Smart City pilot program for  Park City, Utah."
              ] }

    jobs << { company: "Xeraflop Technologies Inc.",
              industry: "Medical Seed to Sale Tracking Software",
              roles: ["Senior Software Generalist"],
              when: (parse_date("2017.04.01")...parse_date("2018.01.01")),
              description: [
                "Adapted self-service and point-of-sale payment terminals with new biometric verification and e-commerce capabilities required by the new customer base.",
                "Migrated a Ruby on Rails monolith to an Eventstore-centric CQRS microservices architecture, optimizing cluster performance with Golang on Kubernetes.",
                "Designed front-end toolchain for a migration from Angular.js to Node/React.",
                "Deployed microservices solution for the Washington State Liquor and Cannabis Board tracking of legal cannabis sales and production.",
                "Facilitated company growth by increasing client base and SaaS cloud offerings."
              ] }

    jobs << { company: "Vancouver Airport Authority",
              industry: "Automated Border Control & Biometrics",
              roles: ["Biometrics R&D Lead"],
              when: (parse_date("2016.03.01")...parse_date("2017.07.01")),
              description: [
                "Incubated an R&D lab from the ground up to modernize automated border control kiosks globally. Led the team and leveraged modern biometrics techniques to fulfill requirements from border services & other government agencies.",
                "Wrote automated test pipelines and evaluated optical system performance for biometric systems. Ensured accurate and reliable functionality for a wide scale of _internationally deployed_ units to other airports.",
                "Oversaw fabrication of kiosk case and custom hardware as well as prototype assembly.",
                "Steered through design problems and resolved issues in a timely manner."
              ] }

    jobs << { company: "David Suzuki Foundation",
              industry: "Non-profit",
              roles: ["Data Evangelist"],
              when: (parse_date("2015.11.01")...parse_date("2016.12.01")),
              description: [
                "Implemented bulk data import processes and Salesforce tooling, integrating all SaaS products and creating data reporting tools for an internal digitization mandate.",
                "Identified stakeholder requirements and formulated proposal for backops tooling rework, reducing non-profit overhead and optimizing team performance."
              ] }

    jobs << { company: "tzoa dot com",
              industry: "Internet of Things, Quantified Self",
              roles: ["Hardware/Data Consultant"],
              when: (parse_date("2015.09.01")...parse_date("2016.03.01")),
              description: [
                "Wrote firmware and mobile apps for air quality trackers, developing Bluetooth communication protocols and testing hardware/software communication.",
                "Assisted customers in planning their activities and protecting their health."
              ] }

    jobs << { company: "rouxbe dot com",
              industry: "Web and Mobile Remote Education, Culinary Health and Wellness",
              roles: ["Interim CTO"],
              when: (parse_date("2014.09.01")...parse_date("2015.09.01")),
              description: [
                "Managed DevOps and implemented new features for an online culinary education platform built on Ruby on Rails and Node.",
                "Handled scaling of servers seamlessly while adding Whole Foods as a client for our culinary education offering, doubling our viewership through increased capacity."
              ] }

    jobs << { company: "Hybridity",
              industry: "Record Label, Installation and Sound Art, Interactive Visuals & Events",
              roles: ["Product Development Advisor"],
              when: (parse_date("2014.06.01")...parse_date("2015.09.14")),
              description: [
                "Wireframed and executed backend business logic for a multi-platform mobile app.",
                "Integrated computer vision and HCI features."
              ] }

    jobs << { company: "crossfader dot fm",
              industry: "Native Mobile Music/Entertainment App, Social Network and Community-contributed Internet Radio Station",
              roles: ["Co-founder, Chief Technical Officer"],
              when: (parse_date("2013.09.01")...parse_date("2015.09.01")),
              description: [
                "Created a popular music production and community platform for iOS.",
                "Built a robust track recommendation engine and supported the engineering team by contributing real-time DSP editing features when needed.",
                "Provided HR and Backops support during startup growing pains.",
                "Grew the team from three to 50 employees and managed back-office operations and HR in the first year."
              ] }

    jobs << { company: "Graffiti Research Lab",
              industry: "Interactive Visuals & Events",
              roles: ["Software Lead/Interaction Consultant"],
              when: (parse_date("2013.02.01")...parse_date("2014.11.01")),
              description: [
                "Drafted networked real-time projected graffiti systems in Java.",
                "Wrote blob detection/computer vision software and various shaders for graffiti emulation.",
                "Installed required hardware at the Woodwards W2 building in Downtown Vancouver to be networked in real-time to similar installations in Seoul, South Korea, and Berlin, Germany.",
                "Highly popular interactive graffiti exhibitions deployed internationally."
              ] }

    jobs << { company: "Coverall Crew",
              industry: "Software as a Service, RoR Dojo",
              roles: ["Software Lead/Platform Specialist"],
              when: (parse_date("2012.08.01")...parse_date("2014.08.01")),
              description: [
                "Oversaw the development of a white-label online ticketing service, creating a full-stack web product and a database layer using Ruby on Rails and MongoDB."
              ] }

    jobs << { company: "eatART Labs",
              industry: "Interactive Art Installations",
              roles: ["Event/Installation Coordinator"],
              when: (parse_date("2012.01.01")...parse_date("2015.11.01")),
              description: [
                "Provided interactive installation art for events leveraging real-time GLSL graphics shaders, computer vision, and custom hardware controllers."
              ] }

    jobs << { company: "weelooms dot com",
              industry: "Virtual Assistant Software and Hardware",
              roles: ["Co-founder"],
              when: (parse_date("2013.01.01")...parse_date("2014.08.01")),
              description: [
                "Created tablet-dock/robot/conferencing assistant software and firmware, leading the tech team to create a virtual assistant platform for Android."
              ] }

    jobs << { company: "Eco-clix/Adrena LINE Zipline Adventure Tours @Sooke",
              industry: "Interactive Installations",
              roles: ["Hardware/Software Developer"],
              when: (parse_date("2010.08.01")...parse_date("2011.06.01")),
              description: [
                "Fabricated kiosk and camera systems for photo capture and sharing, developing weatherproof cameras and motion sensors."
              ] }

    jobs << { company: "monome",
              industry: "Digital Music Instruments and Synthesizers",
              roles: ["Firmware Developer"],
              when: (parse_date("2009.01.01")...parse_date("2011.12.01")),
              description: [
                "Developed digital music instruments and synthesizers for the monome community.",
                "Built generative interface applications and embedded firmware for multi-architecture chipsets."
              ] }

    jobs << { company: "Microsoft/BigPark",
              industry: "Video Gaming",
              roles: ["Senior Software Developer II"],
              when: (parse_date("2008.08.01")...parse_date("2011.05.01")),
              description: [
                "Worked with incubation team on the Xbox Kinect and Xbox 360 platforms.",
                "Integrated social features and created sound effects for online gaming.",
                "Sold 8 million devices in 60 days."
              ] }

    jobs
  end
end

# Only start the interactive shell if this file is run as the main program
if __FILE__ == $0
  InteractiveShell.new.start
end
