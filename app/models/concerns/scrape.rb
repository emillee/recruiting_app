module Scrape
  extend ActiveSupport::Concern

  def get_text_from_link(link = nil)
    link = link || self.link
    html = HTTParty.get(link)
    doc = Nokogiri.HTML(html)
    text = clean_full_text(doc)
    self.full_text = text
    self.save
  end
  
  def clean_extra_text_and_periods
    # index = self.full_text.index(self.title.downcase) || 0
    # text = self.full_text[index..-1]
    # text = remove_consecutive_periods(text)
    text = remove_consecutive_periods(self.full_text)
    self.full_text = text
    self.save
  end
  
	# PRIVATE ---------------------------------------------------------------------------
  private
  
    def clean_full_text(doc)
      doc.css('script').remove
      text = doc.at('body').inner_text
      text = text.gsub(/\n/, '.')
      text = text.squish
    end
    
    def remove_consecutive_periods(text)
      text = text.gsub!(/\.+/, '.')
      text = text.gsub!(/\ \./, '')
      text = text.gsub!(/\.+/, '.')
      text
    end

end
    








