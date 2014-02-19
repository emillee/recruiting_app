module JobsHelper
  
  def req_skill_checked?(job, skill)
    return true if job.req_skills.include?(skill)
    return false
  end    
  
  def dept_checked?(dept)
    return false if current_user.job_settings[:dept].nil?
    return true if current_user.job_settings[:dept].include?(dept)
    return false
  end
  
  def sel_or_hide(dept)
    if current_user.job_settings[:dept].nil?
      return ''
    elsif current_user.job_settings[:dept].include?(dept)
      return 'selected'
    else
      return 'hidden'
    end
  end
    
  def num_years_checked?(num_years)
    return false if current_user.job_settings[:experience].nil?
    return true if current_user.job_settings[:experience].include?(num_years.to_s)
    return false
  end
  
  def sub_dept_checked?(sub_dept)
    return false if current_user.job_settings[:sub_dept].nil?
    return true if current_user.job_settings[:sub_dept].include?(sub_dept)
    return false
  end
  
  def key_skill_checked?(skill)
    return false if current_user.job_settings[:key_skills].nil?
    return true if current_user.job_settings[:key_skills].include?(skill)
    return false
  end
  
  def show_keywords?
    current_user.job_settings[:keywords]
  end
  
  def show_company_keywords?()
    
  end
  
  def sortable(column, title=nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, {sort: column, direction: direction}, {class: css_class}
  end
  
  def return_sub_depts
    current_depts = current_user.job_settings[:dept] 
    sub_dept_arr = []
    
    if current_depts
      Job.all.each do |job|
  		  sub_dept_arr << job.sub_dept if current_depts.include?(job.dept)
  	  end
  	end
	  sub_dept_arr.uniq! if sub_dept_arr.any? 
	  sub_dept_arr.sort!
	end
	
end