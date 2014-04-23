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
    text = remove_extra_text(self.full_text)
    text = remove_consecutive_periods(text)
    self.full_text = text
    self.save
  end
  
	# PRIVATE ---------------------------------------------------------------------------
  private
  
    def remove_extra_text(text)
      return self.full_text if self.title.nil?
      
      sentences = text.split('.')
      lower_case = sentences.map(&:downcase)

      return_arr = []
      lower_case.each_with_index do |sentence, index|
        return_arr << index if sentence =~ /#{self.title}/
      end

      first_idx = return_arr.first if return_arr.any?
      if first_idx
        return sentences[first_idx..-1].join('.').strip 
      else
        return self.full_text
      end
    end

    def clean_full_text(doc)
      doc.css('script').remove
      text = doc.css('body').to_s.scan(/\<\/li\>/).any? ? doc.css('body').to_s.gsub!(/\<\/li\>/, '.</li>') : doc.css('body').to_s
      text = ActionView::Base.full_sanitizer.sanitize(text)
      # text = doc.at('body').inner_text
      text = text.gsub(/\n/, '. ')
      text = text.squish
    end
    
    def remove_consecutive_periods(text)
      # replace consecutive periods with one period
      text = text.gsub(/[\s*\.*]\.*[\s*\.*]/, '. ')
      text = text.gsub(/ \. /, '')
      text = text.gsub(/[\s*\.*]\.*[\s*\.*]/, '. ')
      text
    end

end
    








