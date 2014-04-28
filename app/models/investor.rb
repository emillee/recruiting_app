class Investor < ActiveRecord::Base
  
  attr_reader :article_id

  has_many :employees, class_name: 'User', foreign_key: :investor_company_id  
  has_many :articles

  has_attached_file :logo, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  has_attached_file :snapshots, styles: { original: '200x400', medium: '300x300', large: '300x500' },
    path: ":rails_root/public/system/:class/:attachment/:id_partition/:style/:normalized_investorpic_file_name.:extension",
    url: "/system/:class/:attachment/:id_partition/:style/:normalized_investorpic_file_name.:extension"
  
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  Paperclip.interpolates :normalized_investorpic_file_name do |attachment, style|
    attachment.instance.normalized_investorpic_file_name
  end
  
  # reads this above with attr_read
  def store_article_id_temporarily(article_id)
    @article_id = article_id
  end  
  
  def normalized_investorpic_file_name
    "id-#{self.id}-name-#{self.name.downcase.gsub(' ', '-')}-articleid-#{self.article_id}"
  end

end
