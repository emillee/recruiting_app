module ImagesHelper
  
  def image_exists?(path)
    FileTest.exist?(path)
  end
  
  def insert_image_or_text(name)
    ext_arr = %w(jpeg png jpg gif)
    ext_arr.each_with_index do |ext, idx|
      filepath = "#{name.downcase}" + ".#{ext}"
      if image_exists?("#{Rails.root}/public/images/back_end_skills/#{filepath}")
        return image_tag('back_end_skills/' + "#{filepath}", alt: "#{name}", class: 'is-draggable')
      elsif (idx == ext_arr.length - 1)
        return name
      end
    end
  end
  
  # assumes the path is a full file_path with an extension
  def get_paperclip_ext(path)
    return File.extname(path)
  end
  
  def check_all_extensions(path)
    correct_ext = nil
    ext_arr = %w(.jpeg .png .jpg .gif)
    this_ext = get_paperclip_ext(path)
    ext_arr.each_with_index do |ext, idx|
      new_filepath = path.gsub(this_ext, ext)
      correct_ext = ext if image_exists?(new_filepath)
    end
    
    return correct_ext
  end
  
end