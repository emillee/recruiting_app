require 'spec_helper'

describe User do
	before(:each) do 
		@attr = {
			fname: 'john',
			lname: 'smith',
			email: 'test@gmail.com',
			password: 'please'
		}
	end

	it "should create an instance given valid attributes" do
		User.create!(email: 'test@email.com', password: 'please')
	end

	it "should require an email" do
		no_email_user = User.new(@attr.merge(email: ''))
		no_email_user.should_not be_valid
	end

	it "should reject first name that is too long" do
		long_name = 'a' * 25
		long_name_user = User.new(@attr.merge(fname: long_name))
		long_name_user.should_not be_valid
	end

	it "should reject last name that is too long" do 
		long_name = 'a' * 35
		long_name_user = User.new(@attr.merge(lname: long_name))
		long_name_user.should_not be_valid
	end

	it "should accept valid email addresses" do
		addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
		addresses.each do |address|
			valid_email_user = User.new(@attr.merge(email: address))
			valid_email_user.should be_valid
		end
	end

	it "should reject invalid email addresses" do
		addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
		addresses.each do |address|
			invalid_email_user = User.new(@attr.merge(email: address))
			invalid_email_user.should_not be_valid
		end
	end

	it "should reject duplicate email addresses" do
		User.create!(@attr)
		user_with_duplicate_email = User.new(@attr)
		user_with_duplicate_email.should_not be_valid
	end

	it "should reject email addresses identical up to case" do
		upcased_email = @attr[:email].upcased
		User.create!(@attr.merge(email: upcased_email))
		user_with_duplicate_email = User.new(@attr)
		user_with_duplicate_email.should_not be_valid
	end

	describe "password" do
		before(:each) do
			@user = User.new(@attr)
		end

		it "should have a password attribute" do
			@user.should respond_to(:password)
		end

		it "should require a password" do
			User.new(@attr.merge(password: '')).should_not be_valid
		end

		it "should reject short password" do
			short = 'a' * 5
			hash = @attr.merge(password: short)
			User.new(hash).should_not be_valid
		end

		it "should reject long password" do
			long = 'a' * 20
			hash = @attr.merge(password: long)
			User.new(hash).should_not be_valid
		end

	end

	describe "password encryption" do
		before(:each) do
			@user = User.create(@attr)
		end

		it "should have an encrypted password attribute" do
			@user.should respond_to(:password_digest)
		end

		it "should set the encrypted password attribute" do
			@user.password_digest.should_not be_blank
		end

		describe "password_match?(password_string) method" do

			it "should exist" do
				@user.should respond_to(password_match?('something'))
			end

			it "should return true if passwords match" do
				@user.password_match?(@attr[:password]).should be_true
			end

			it "should return false if passwords don't match" do
				@user.password_match?('invalid').should be_false
			end
		end
	end

end































