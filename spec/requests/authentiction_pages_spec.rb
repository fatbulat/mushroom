require 'spec_helper'

describe "AuthentictionPages" do
  subject { page }

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-warning') }

      describe "after visiting another page" do
        before { click_link "Help" }
        it { should_not have_selector('div.alert.alert-warning') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in(user) }

      it { should have_title(full_title("#{ user.surname } #{ user.name }"))}
      it { should have_link('Users',    href: users_path) }
      it { should have_link('Profile',  href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }

      it { should_not have_link('Sign in', href: signin_path) }

      it { should have_selector('div.alert.alert-success', text: 'Welcome!') }

      describe "following by sign out" do
        before { click_link "Sign out" }

        it { should have_link('Sign in', href: signin_path) }
      end
    end
  end
end