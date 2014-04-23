FactoryGirl.define do
	factory :user do |f|
		f.sequence(:email) { |n| "foo#{n}@example.com" }
		f.password "secret"
	end
end