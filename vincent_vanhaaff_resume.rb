require "active_support"
require "active_record"


module Skills
  def skills
    {
      :programming_languages  => %w(Ruby Python PHP),
      :development_frameworks => %w(Rails Django Zend),
      :database               => %w(MySQL Postres SQLite),
      :testing                => %w(Test::Unit MiniTest RSpec Shoulda 
                                      Cucumber Selenium
                                     ),
      :orms                   => %w(ActiveRecord Sequel),
      :front_end              => %w(Actionscript Javascript CSS HTML openFrameworks Processing WebGL),
      :scm                    => %w(Git Perforce Subversion),
      :web_servers            => %w(Nginx Apache),
      :app_servers            => %w(Merb Phusion Passenger mod_php WSGI)

    }
  end
end


module Experience
  def self.included(base)
    base.extend Skills
   
    class << base
      def experience
        jobs = []

        jobs << { :company  => "Blitzoo Games Inc.",
                  :industry => "Online Social Gaming",  
                  :roles    => ["Software Engineer 2", "Platform Specialist"],
                  :when     => (8.months.ago...Time.now.to_s) }

        jobs << { :company  => "Games For Windows Live",
                  :industry => "Online Social Gaming, Platforms Expert",
                  :roles    => ["Software Engineer 2", "Platform Specialist"],
                  :when     => (2.years.ago..6.month.ago) }


        jobs << { :company  => "BigPark",
                  :industry => "Video Gaming",
                  :roles    => ["User Experience Designer", "Software Developer", "Audio Engineer"],
                  :when     => (3.years.ago..2.years.ago) }

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
  has_and_belongs_to_many :projects, :through => "github", \
                          :foreign_key => "github.com/flyingoctopus"
 
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
    `open http://##{first_name.downcase}.##{last_name.downcase}.com/contact/`
  end
 
  def self.inspect
    who =<<-END

    I am a passionate designer/developer with 5+ years commercial experience
    and 360° skills in the design, development and maintenance of modern,
    user centred design, as well as engaging video games on both
    the web and consol, with a strong interest in performance,
    engagement, clean code, and a pension for enjoying one's day.

    Besides work, I live in Vancouver with my lady-friend and our little baby, Lord Nibbler.
    I love climbing, cycling, and good times!
   
    END
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