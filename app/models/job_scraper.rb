class JobScraper 
  
  
  
  def initialize(job)
    @job = job
  end
  
  def input_job_data
    get_text
    get_title
    get_dept
    get_sub_dept
    get_years_exp
  end
  
  def get_text
    html = HTTParty.get(@job.link)
    doc = Nokogiri.HTML(html)
    doc.css('script').remove
    text = doc.at('body').inner_text
    @job.full_text = text.squish.downcase
    @job.save
  end

  def get_company
    Company.all.each do |company|
      if @job.first_thirty.match(/#{company.name}/i)
        @job.company_id = company.id 
        @job.save
        return
      end
    end
  end
  
  def get_title
    title_match, index = nil, nil
    
    Job.all_unique_titles.each do |uniq_title|
      if @job.full_text.match(/#{uniq_title}/i)
        if title_match.nil?
          title_match = uniq_title
          index = @job.full_text.index(uniq_title.downcase)
        elsif index && @job.full_text.index(uniq_title.downcase) < index
          title_match = uniq_title
          index = @job.full_text.index(uniq_title)
          puts title_match
          puts index
        end         
      end
    end
    
    @job.title = title_match
    @job.save
  end
  
  def get_dept
    if @job.title
      job = Job.all.find { |job| job.title == @job.title && !job.dept.nil? }
      @job.dept = job.dept if job.dept
      @job.save
    end
  end

  def get_sub_dept
    if @job.title
      job = Job.all.find { |job| job.title == @job.title && !job.sub_dept.nil? }
      @job.sub_dept = job.sub_dept if job.sub_dept
      @job.save
    end
  end
  
  def get_years_exp
    if @job.full_text.match(/(\d+)\+ years/)
      years = @job.full_text.match(/(\d+)\+ years/)[1]
    elsif @job.full_text.match(/(\d)-\d years/)
      years = @job.full_text.match(/(\d)-\d years/)[1]
    elsif @job.full_text.match(/(\d) years/)
      years = @job.full_text.match(/(\d+) years/)[1]
    else
      years = nil
    end

    @job.years_exp = years
    @job.save
  end
  
  
end














