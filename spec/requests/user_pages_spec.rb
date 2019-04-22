require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do

    # Only admin user can see users table
    let(:user) { FactoryGirl.create(:admin) }

    before do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: 'Users') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_link('Next') }
      its(:html) { should match('>2</a>') }

      it "should list each user" do
        User.all[0..2].each do |user|
          page.should have_selector('td', text: user.email)
        end
      end
    end
  end

  describe "signup" do

    before { visit root_path }

    let(:submit) { "Register!" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "user[email]",                 with: "test@gmail.com"
        fill_in "user[password]",              with: "foobar"
        fill_in "user[password_confirmation]", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
