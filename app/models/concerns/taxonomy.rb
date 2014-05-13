module Taxonomy
  extend ActiveSupport::Concern

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

  # TAGS
	def self.categories_hash
		{
			# "Random" => ["Random Musings", "Foosball", "Beer"],
			# "Let's Meet" => ["I'm looking to Meet...", "Coffee chat", "Happy hour", "Cofounder", "Advisory"],
			"About Me" => ['Intro', "My Skills", "Prior Work", "References"],
      # "Recent Activity" => ["A Day in the Life", "Stuff I'm Working On"],
      # "News / Updates" => ["News", "Milestones", "Fundraisings"],
      # "Recruiting" => ["I'm Looking to Hire", "I'm available for hire", "Freelance", "Consulting", "Part-Time"],
		}
	end

	# PREFERENCES SIDEBAR ---------------------------------------------------------------------------
	
	def self.company_stage
	  [
	    'Pre-Seed',
	    'Seed (~$250K)',
	    'Traction ($1M+)',
	    'Growth ($3-10M+)',
	    'Crushing It ($10M+)',	    	    
	    'Big Company (IPO??)'	    	    
	  ]
  end

  def self.company_industry
    [
      'Fashion',
      'FinTech',
      'AdTech',
      'Social',
      'ECommerce',            
      'Mobile',
      'Big Data'         
    ].sort
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
      # ['Internship', 0],
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
      'Designer',
      'Engineer',
      # 'Bus. Development',
      # 'Prod. Management',
      # 'Sales'
      # 'Administrative',
      # 'Finance, Accting',
      # 'Human Resources',
      # 'Legal',
      # 'Marketing',
      # 'Operations',      
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
  
end
