module ImportData
  extend ActiveSupport::Concern
  
  def get_title
    title_match, index = nil, nil
    
    Job.all_unique_titles.each do |uniq_title|
      puts "SELF #{self}"
      if self.full_text.match(/#{uniq_title}/i)
        if title_match.nil?
          title_match = uniq_title
          index = self.full_text.index(uniq_title.downcase)
        elsif index && self.full_text.index(uniq_title.downcase) < index
          title_match = uniq_title
          index = self.full_text.index(uniq_title)
        end         
      end
    end
    
    self.title = title_match
    self.save
  end

  
  def get_dept
    if self.title
      job = Job.all.find { |job| job.title == self.title && !job.dept.nil? }
      self.dept = job.dept
      self.save
    end
  end

  def get_sub_dept
    if self.title
      job = Job.all.find { |job| job.title == self.title && !job.sub_dept.nil? }
      self.sub_dept = job.sub_dept
      self.save
    end
  end
  
  # ARCHIVE - not in use currently
  def get_company
    Company.all.each do |company|
      if @job.first_thirty.match(/#{company.name}/i)
        @job.company_id = company.id 
        @job.save
        return
      end
    end
  end
  
end