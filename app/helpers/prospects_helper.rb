module ProspectsHelper


  def is_prospect_setting_checked?(this_attr, val)
    return false if current_user.prospect_settings[this_attr].nil?
    return true if current_user.prospect_settings[this_attr].include?(val)
    return false    
  end

end