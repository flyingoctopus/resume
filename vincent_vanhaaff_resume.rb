# encoding: utf-8

require "active_support"
require "active_record"


module Skills
  def skills
    {
      :direction              => %w(User_Experience_Design Sound_Design Product_Design 
                                      Behaviour_Design Systems_Engineering Startup_Consulting
                                    ),
      :programming_languages  => %w(Ruby Python PHP Node Cpp_openFrameworks Java_Processing Actionscript3),
      :development_frameworks => %w(Rails Django Zend),
      :database               => %w(MySQL Postres SQLite MongoDB Redis),
      :testing                => %w(Test::Unit MiniTest RSpec Shoulda 
                                      Cucumber Selenium
                                    ),
      :orms                   => %w(ActiveRecord Sequel Mongoid MongoMapper),
      :front_end              => %w(Actionscript Javascript CSS HTML
                                      OpenFrameworks Processing WebGL 
                                      Backbone CoffeeScript
                                    ),
      :scm                    => %w(Git Perforce Subversion),
      :web_servers            => %w(Nginx Apache),
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
                  :industry => "Event Management Company", "Installation and Sound Art", "Interactive Visuals",
                  :roles    => ["Creative Director"],
                  :when     => (5.year.ago...Time.now.to_s) }
        
        jobs << { :company  => "Hybridity",
                  :industry => "Record Label", "Installation and Sound Art", "Interactive Visuals & Events",
                  :roles    => ["Technical Director", "Consultant"],
                  :when     => (1.year.ago...Time.now.to_s) }
                  
        jobs << { :company  => "Coverall Crew",
                  :industry => "Software as a Service, RoR Dojo",  
                  :roles    => ["Technical Design", "Technical Lead"],
                  :when     => (2.year.ago...6.months.ago) }
                  
        jobs << { :company  => "Blitzoo Games Inc.",
                  :industry => "Online Social Gaming",  
                  :roles    => ["Software Lead", "Platform Specialist"],
                  :when     => (2.years.ago...1.year.ago) }

        jobs << { :company  => "Microsoft",
                  :industry => "Online Social Gaming, Platforms Expert", "Computer Vision Expert",
                  :roles    => ["Software Engineer 2", "Platform Specialist", "User Experience Designer"],
                  :when     => (3.5.years.ago..2.years.ago) }


        jobs << { :company  => "BigPark",
                  :industry => "Video Gaming",
                  :roles    => ["User Experience Designer", "Software Developer", "Chief Audio Engineer"],
                  :when     => (5.5.years.ago..3.years.ago) }

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
  has_many :skills, :through => "experience", :include => "practice"
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
    `open http://##{first_name.downcase}.##{last_name.downcase}.com/contact/`
  end
 
  def self.inspect
    who << "
    I am a passionate designer/developer with 5+ years commercial experience
    and 360° skills in the design, development and maintenance of modern,
    user centered design. I also create engaging experiences for installation and 
    video games on both the web and console, with a strong interest in performance,
    engagement, clean code, and a pension for enjoying one's day.

    Besides work, I live in Vancouver with my lady-friend and our little baby, Lord Nibbler.
    I love climbing, cycling, and good times!"
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
