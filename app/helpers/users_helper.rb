module UsersHelper
  
  def editable?(user)
    (user == current_user || current_user.is_admin) ? "true" : "false"
  end

end