class Image < ActiveRecord::Base

	belongs_to :article

	has_attached_file :image_file, styles: { original: '200x200', thumb: '100x100' },
		default_url: '/images/:style/missing.png'

	validates_attachment_content_type :image_file, content_type: /\Aimage\/.*\Z/

end

 