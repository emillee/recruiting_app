module ImageHelper
  
  def insert_image_or_text(name)
    ext_arr = %w(jpeg png jpg gif)
    ext_arr.each_with_index do |ext, idx|
      filepath = "#{name.downcase}" + ".#{ext}"
      if FileTest.exist?("#{Rails.root}/public/images/back_end_skills/#{filepath}") 
        return image_tag('back_end_skills/' + "#{filepath}", alt: "#{name}", class: 'is-draggable')
      elsif (idx == ext_arr.length - 1)
        return name
      end
    end
  end

end