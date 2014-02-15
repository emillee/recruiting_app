class Taxonomy < ActiveRecord::Base  
    
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
  
  def self.front_end_skills
    [
      'JS/HTML/CSS: Expert',
      'JS/HTML/CSS: Solid',
      'JS/HTML/CSS: Working Knowledge',
      'Visual Design - UIUX',
      'Finance, Accting',
      'Human Resources',
      'Legal',
      'Marketing',
      'Operations',
      'Product Management',
      'Project Management',
      'Sales'
    ]
  end
  
  def self.departments
    [
      'Administrative',
      'Bus. Development',
      'Design',
      'Engineering',
      'Finance, Accting',
      'Human Resources',
      'Legal',
      'Marketing',
      'Operations',
      'Product Management',
      'Project Management',
      'Sales'
    ]
  end
  
  
  # SCRATCH FORMULAS
  #-------------------------------------------------------

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
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
  

  
end
