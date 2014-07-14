module Recommend
	extend ActiveSupport::Concern

	def increase_recs
		self.recs = self.recs + 1
		self.save
	end

end