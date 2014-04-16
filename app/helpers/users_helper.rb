module UsersHelper
  
  def editable?(user)
    (user == current_user || current_user.is_admin) ? "true" : "false"
  end
  
  # def add_placeholder_if_nil(attr, user)
  #   if user && user.public_send(attr)
  #     return user.public_send(attr)
  #   end
  #   
  #   case attr
  #   when 'biography'
  #     return '<h3>Biography</h3>
  #             <p>Tell us about you!</p>'
  #   when 'intro'
  #     return "<h3>Introduction</h3>
  #             <p>Provide brief intro here!</p>
  #             <p>Example: I'm an [title] at [company]</p>
  #             <p>Example: I'm working on [brief description]</p>
  #             <p>For fun I... (Or insert a random fact about yourself)</p>"
  #   when 'interested_in_meeting'
  #     return "<h3>I'm Interested in Meeting...</h3>
  #             <p>Give me a shout if...</p>"
  #   end
  # end

end