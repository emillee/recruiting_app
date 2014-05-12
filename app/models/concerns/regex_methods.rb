module RegexMethods
  extend ActiveSupport::Concern

  def numbers_words_hash
    {
      'one'   => 1,
      'two'   => 2,
      'three' => 3,
      'four'  => 4,
      'five'  => 5,
      'six'   => 6,
      'seven' => 7,
      'eight' => 8,
      'nine'  => 9,
      'ten'   => 10,
    }
  end

  def numbers_words_regex
    ''
  end

  .full_text.match(/\d - \d (years|yrs|year\(s\))/)

  def get_years_exp
    if self.full_text.match(/(\d+)\+ (years|yrs|year\(s\))/)
      years = self.full_text.match(/(\d+)\+ (years|yrs|year\(s\))/)[1]
    elsif self.full_text.match(/(\d)-\d (years|yrs|year\(s\))/)
      years = self.full_text.match(/(\d)-\d (years|yrs|year\(s\))/)[1]
    elsif self.full_text.match(/(\d) (years|yrs|year\(s\))/)
      years = self.full_text.match(/(\d+) (years|yrs|year\(s\))/)[1]
    elsif self.full_text.match(/(one|two|three|four|five|six|seven|eight|nine|ten) (or more )*(years|yrs|year\(s\)) (of|experience)/i)
      match = self.full_text.match(/(one|two|three|four|five|six|seven|eight|nine|ten) (or more )*(years|yrs|year\(s\)) (of|experience)/i)[1]
      years = numbers_words_hash[match.downcase]
    end

    self.years_exp = years if years
    self.save
  end
  
end