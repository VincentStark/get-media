require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin process" do
    before { visit root_path }
 
    it { should have_selector('legend', text: 'New User') }
    it { should have_selector('title',  text: 'Login') }

    describe "with invalid information" do
      before { click_button "Login!" }

      it { should have_selector('title', text: 'Login') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }

      describe "after visiting another page" do
        before { click_link "FAQ" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_link('Logout', href: logout_path) }
      it { should_not have_link('Login', href: root_path) }
    end
  end
end
