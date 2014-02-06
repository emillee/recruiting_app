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
    @job.full_text = text.squish
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
    Job.all_unique_titles.each do |uniq_title|
      if @job.full_text.match(/#{uniq_title}/i)
        @job.title = uniq_title 
        @job.save
        return
      end
    end
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
    years = @job.full_text.match(/(\d+)\+ years/) || 
      @job.full_text.match(/(\d)-\d years/)[1]
    if years
      @job.years_exp = years
      @job.save
    end
  end
  
  
end














