module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @user = FactoryGirl.create(:admin)
      sign_in :user, @user
    end
  end
end
