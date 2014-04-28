module Taxonomy
  extend ActiveSupport::Concern

  module ClassMethods
    def back_end_skills
      [
        'Rails',
        'Python',
        'PHP',
        'Node',
        'Java',
        'C-Plus-Plus',
        'C-Sharp',
        'Perl',
        'Scala',
        'Haskell',
        'Lisp',
        'Clojure',
        'Microsoft.net',
      ]
    end

    def front_end_skills
      [
        'HTML/CSS',
        'Javascript',
        'jQuery',
      ]
    end
  end  
  
  # TAGS
	def self.categories_hash
		{
			"Recent Activity" => ["A Day in the Life", "Stuff I'm Working On"],
			"News / Updates" => ["News", "Milestones", "Fundraisings"],
			"Recruiting" => ["I'm Looking to Hire", "I'm available for hire", "Freelance", "Consulting", "Part-Time"],
			"Referrals, Q&A" => ["Seeking Referral", "Providing Referral", "I Have a Question", "Ask Me Anything"],
			"Random" => ["Random Musings", "Foosball", "Beer"],
			"Let's Meet" => ["I'm looking to Meet...", "Coffee chat", "Happy hour", "Cofounder", "Advisory"],
			"About Me" => ['Intro', 'Prior Employers', "My Skills", "Prior Work", "References"],
		}
	end

  def self.req_skills
    {
      "back-end" => 
      {
        "Ruby/ROR" => ["Rails", "Ruby"],
        "Python" => ["Python"],
        "Java" => ["Java"],
        "PHP" => ["PHP"],
        "Perl" => ["Perl"],
        "Node" => ["Node"],
      }
    }
  end
  
  
	# SIDEBAR ---------------------------------------------------------------------------
	
	def self.company_stages
	  [
	    'Pre-Seed',
	    'Seed (~$250K)',
	    'Traction ($1M+)',
	    'Growth ($3-10M+)',
	    'Crushing It ($10M+)',	    	    
	    'Big Company (IPO??)'	    	    
	  ]
  end
  
	def self.salary_minimum
	  [
	    'Less than $50K',
	    '$50-$75K',
	    '$75-$100K',
	    'Seed-Stage ($250K+)',
	    'Series A ($1M+)',
	    'Series B ($3-10M+)',
	    'Series C ($10M+)',	    	    
	    'Corporate'	    	    
	  ]
  end
  
  def self.years_exp
    [
      ['Internship', 0],
			['Entry (0-1)', 1], 
			['Junior (1-2)', 2], 
			['Mid (2-3)', 3], 
			['Senior / Lead (3-4+)', 4], 
			['VP, Director (4-7+)', 7],
			['CTO (7+)', 10]
		] 
	end   
  
  def self.front_end_key_skills
    [
      'Javascript',
      'HTML / CSS',
      'Design'
    ]
  end
  
  def self.departments
    [
      # 'Bus. Development',
      'Designer',
      'Engineer',
      # 'Prod. Management',
      # 'Sales'
      # 'Administrative',
      # 'Finance, Accting',
      # 'Human Resources',
      # 'Legal',
      # 'Marketing',
      # 'Operations',\      
      # 'Project Management',
    ]
  end

  def extract_level_and_base_title
    level = []
    
    Taxonomy.LEVELS.each do |lvl|
      level << lvl if self.title.match(/#{lvl}/i)
    end 

    if level.any?
      self.level = level.first
      self.base_title = self.title
      self.base_title.slice!(self.level)
      self.base_title.strip!
      self.save
    end
  end

  def self.set_dept
    Taxonomy.all.each do |taxonomy|
      self.dept_hash.each do |dept_key, roles_arr|
        roles_arr.each do |role|
          if taxonomy.title.match(/#{role}/i)
            taxonomy.dept = dept_key
            taxonomy.save
          end
        end
      end
    end 
  end

  # def self.key_skill_degrees
  #   [
  #     ['JS: Expert',
  #     'JS: Solid',
  #     'JS: Entry'],
  #     ['HTML/CSS: Expert',
  #     'HTML/CSS: Solid',
  #     'HTML/CSS: Entry'],
  #     ['Design: Expert',
  #     'Design: Solid',
  #     'Design: Entry']      
  #   ]
  # end  

  # ["In the process of receiving a BS in Computer Science", 
  #   "Experience with front-end web development", 
  #   "Experience with mobile development a plus", 
  #   "genuine interest in databases a HUGE plus", 
  #   "strong visual design", 
  #   "highly detailed, polished interface designs", 
  #   "take their finished designs and make them live and breathe using standards-driven, semantic HTML, CSS and Javascrip", 
  #   "Can show us that your love for design translates into high quality work", 
  #   "at least a working knowledge of HTML/CSS/Javascript (the more advanced, the better)", 
  #   "experienced with different front end technologies and has an eye for design", 
  #   "Solid JavaScript skills: you know the good parts and when its okay to use the bad", 
  #   "Know HTML and CSS like the back of your hand", 
  #   "Have experience with frameworks and libraries, but know when to roll your own", 
  #   "Have created customer-facing web applications in the past.", 
  #   "familiar with responsive design", 
  #   "Know your way around back-end code and build tools like Rake, Grunt", 
  #   "Understand and have worked with RESTful APIs", 
  #   "Like to play around with transpiler languages like CoffeeScript, ClojureScript"]

  #-------------------------------------------------------  
  
end
