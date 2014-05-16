module PermissionsHelper

	def editable_if_admin(user)
		return false if user.nil?
		user.is_admin
	end

  def bcard_editable?(user)
    (user == current_user || current_user.is_admin) ? "true" : "false"
  end	

end