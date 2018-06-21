# encoding: utf-8

require "active_support"
require "active_record"


module Skills
  def skills
    {
      :direction              => %w(User_Experience_Design Product_Design Behaviour_Design
                                      Systems_Engineering Data_Visualization
                                      Startup_Consulting Data_Driven_Intelligence
                                    ),
      :programming_languages  => %w(Ruby Golang Swift Python JS Node PHP Scala Cpp openFrameworks
                                      Java Processing C# Apex
                                    ),
      :development_frameworks => %w(Rails Django CQRS Docker),
      :database               => %w(MySQL Postres SQLite MongoDB Redis Salesforce Eventstore),
      :testing                => %w(Test::Unit MiniTest RSpec Shoulda
                                      Cucumber Selenium
                                    ),
      :orms                   => %w(ActiveRecord Sequel Mongoid MongoMapper),
      :front_end              => %w(React_js React Javascript CSS HTML
                                      OpenFrameworks Processing WebGL
                                      Backbone CoffeeScript Webpack
                                    ),
      :scm                    => %w(Git Perforce Subversion),
      :web_servers            => %w(Nginx Apache AWS),
      :app_servers            => %w(Merb Phusion Passenger Mod_php WSGI)

    }
  end
end


module Experience
  def self.included(base)
    base.extend Skills

    class << base
      def experience
        jobs = []

        jobs << { :company  => "flyingoctopus",
                  :industry => "Technical Consulting, Installation and Sound Art, Interactive Visuals",
                  :roles    => ["Creative Director"],
                  :when     => ("2006.05.01".to_date...Time.now.to_s) }

        jobs << { :company  => "Xeraflop Technologies Inc",
                  :industry => "Medical Seed to Sale Tracking Software",
                  :roles    => ["Full Stack Senior Software Engineer", "Mobile", "Web"],
                  :when     => ("2017.04.01".to_date..."2018.01.01".to_date) }
        
        jobs << { :company  => "Vancouver Airport Authority",
                  :industry => "Automated Border Control & Biometrics",
                  :roles    => ["Biometrics Research and Design", "Hardware Research", "ISO Compliance Research", "Optical Analysis"],
                  :when     => ("2016.03.01".to_date..."2016.07.01".to_date) }

        jobs << { :company  => "David Suzuki Foundation",
                  :industry => "Non profit",
                  :roles    => ["Data Evangelist", "Salesforce Admin", "Database Management", "Analytics Intelligence"],
                  :when     => ("2015.11.01".to_date..."2016.03.01".to_date) }

        jobs << { :company  => "tzoa.com",
                  :industry => "Internet of Things, Quantified Self",
                  :roles    => ["Firmware Engineer", "Bluetooth protocol", "iOS/Android client app developer", "Analytics and Business Intelligence Consultant"],
                  :when     => ("2015.05.01".to_date...Time.now.to_s) }

        jobs << { :company  => "Newland Systems/Accent Steel Manufacturing",
                  :industry => "Brewery Barrel System Fabricator & Manufacturer",
                  :roles    => ["Salesforce Consultant", "Database Management", "Front-End APEX/Reactjs Developer"],
                  :when     => ("2015.06.01".to_date...Time.now.to_s) }

        jobs << { :company  => "Rouxbe Cooking School",
                  :industry => "Web and Mobile Remote Education, Culinary Health and Wellness, Learning and Content Management System Development",
                  :roles    => ["Chief Technical Officer"],
                  :when     => ("2014.09.01".to_date..."2015.09.01".to_date) }

        jobs << { :company  => "Crossfader.fm",
                  :industry => "Native Mobile Music/Entertainment App, Social Network and Community-contributed Internet Radio Station",
                  :roles    => ["Co-founder, Chief Technical Officer"],
                  :when     => ("2014.09.01".to_date..."2015.03.01".to_date) }

        jobs << { :company  => "Hybridity",
                  :industry => "Record Label, Installation and Sound Art, Interactive Visuals & Events",
                  :roles    => ["Technical Director", "Consultant"],
                  :when     => ("2013.06.01".to_date..."2014.09.14".to_date) }

        jobs << { :company  => "Coverall Crew",
                  :industry => "Software as a Service, RoR Dojo",
                  :roles    => ["Technical Design", "Technical Lead"],
                  :when     => ("2012.08.01".to_date..."2014.08.01".to_date) }

        jobs << { :company  => "Blitzoo Games Inc.",
                  :industry => "Online Social Gaming",
                  :roles    => ["Software Lead", "Platform Specialist"],
                  :when     => ("2011.06.01".to_date..."2012.07.01".to_date) }

        jobs << { :company  => "BigPark => Microsoft/Games for Windows Live",
                  :industry => "Online Social Gaming, Platforms Expert, Computer Vision Expert",
                  :roles    => ["Software Engineer 2", "Platform Specialist", "User Experience Designer"],
                  :when     => ("2009.01.01".to_date.."05.01.2011".to_date) }


        jobs << { :company  => "BigPark",
                  :industry => "Video Gaming",
                  :roles    => ["User Experience Designer", "Software Developer", "Sound Designer"],
                  :when     => ("2008.09.01".to_date..."2009.01.01".to_date) }

        # TODO: add previous positions on request

        jobs
      end
    end
  end
end



class VincentVanHaaff < ActiveRecord::Base

  include Experience
  extend Skills

  has_one :passion, :through => "computing"
  has_many :skills, :through => "experience", :source => "practice"
  has_many :projects, :through => "github",
                          :foreign_key => "github.com/flyingoctopus"

  validates_presence_of :innovation
  validates_presence_of :learning_opportunities
  validates_presence_of :friendly_team
  validates_presence_of :pair_programming

  def self.objectives
    begin
      returning Array.new do |objs|
        objs << "Further develop my development skills"
        objs.push "Have fun while contributing to some smart people's growth plans"
      end
    rescue Exception => e
      puts e
      # TODO: retry harder
    end
  end

  def self.contact
    `open mailto:##{first_name.downcase}@##{last_name.downcase}.com`
  end

  def self.inspect
    who << "
    I am a passionate technical creative and engineer with over fifteen years of commercial experience
    and full-stack skills in the design, development and maintenance of modern,
    user centered tech driven products and services. I also create engaging experiences for installation and
    video games on both the web and console, with a strong interest in  performance,
    engagement, clean efficient code, and accomplishing it with a strong team.

    Besides work, I am a co-founder of Vancouver Maker Faire as well as Vancouver Hackspace,
    educator, and artist while living in Vancouver with my cat, Lord Nibbler.
    I love climbing, cycling, good eats, and good times!"
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
