# include Devise::TestHelpers
def login
  visit new_user_session_path
  user = FactoryGirl.create(:user)
  fill_in 'Email', with: user.email
  fill_in 'Senha', with: user.password
  click_on 'Entrar'
end