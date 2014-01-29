module ApplicationHelper

  def category_checked?(category)
    return false if current_user.job_settings[:category].nil?
    return true if current_user.job_settings[:category].include?(category)
    return false
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
  
  def show_keywords?
    current_user.job_settings[:keywords]
  end
  
end
