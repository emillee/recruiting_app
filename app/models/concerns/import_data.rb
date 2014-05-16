module ImportData
  extend ActiveSupport::Concern

  def get_req_skills
    req_skills_hash = Taxonomy.req_skills["#{self.sub_dept}"]

    req_skills_hash.each do |keyword_skill, key_skill_array|
      key_skill_array.each do |skill_keyword|
        self.req_skills << keyword_skill if self.full_text.scan(/ #{skill_keyword} /).any?
      end
    end

    self.req_skills_will_change!
    self.req_skills.uniq!
    self.save
  end
  
  def get_title
    title_match, index = nil, nil
    
    Job.all_unique_titles.each do |uniq_title|
      if self.full_text.downcase.match(/#{uniq_title.downcase}/i)
        if title_match.nil?
          title_match = uniq_title
          index = self.full_text.downcase.index(uniq_title.downcase)
        end

        if index && self.full_text.downcase.index(uniq_title.downcase) && (self.full_text.downcase.index(uniq_title.downcase) < index)
          title_match = uniq_title
          index = self.full_text.downcase.index(uniq_title.downcase)
        end                
      end
    end
    
    self.title = title_match
    self.save
  end
  
  def get_dept
    if self.title
      job = Job.all.find { |job| job.title == self.title && !job.dept.nil? }
      if job
        self.dept = job.dept
        self.save
      end
    end
  end

  def get_sub_dept
    if self.dept
      job = Job.all.find { |job| job.title == self.title && !job.sub_dept.nil? }
      self.sub_dept = job.sub_dept
      self.save
    end
  end
  
end