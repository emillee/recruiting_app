module CompaniesHelper
  
  def add_placeholder_if_nil(company, section)
    return company.public_send(section) unless company.public_send(section).nil?
  end
  
end