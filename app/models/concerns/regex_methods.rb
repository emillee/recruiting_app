module RegexMethods
  extend ActiveSupport::Concern

  def get_years_exp
    if self.full_text.match(/(\d+)\+ years/)
      years = self.full_text.match(/(\d+)\+ years/)[1]
    elsif self.full_text.match(/(\d)-\d years/)
      years = self.full_text.match(/(\d)-\d years/)[1]
    elsif self.full_text.match(/(\d) years/)
      years = self.full_text.match(/(\d+) years/)[1]
    else
      years = nil
    end

    self.years_exp = years
    self.save
  end
  
end