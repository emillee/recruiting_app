FactoryGirl.define do
	factory :user do |f|
		f.sequence(:email) { |n| "foo#{n}@example.com" }
		f.password "secret"
	end

	factory :company do |f|
		f.sequence(:name) { |n| "company-#{n}" }
	end
end

