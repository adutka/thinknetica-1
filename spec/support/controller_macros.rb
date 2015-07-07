module ControllerMacros
  def sign_in
    before do
      @user = create (:user)
      @request.env['devise.mapping'] = Devise.mappings[:user] # чтоб devise подключался к юзер
      sign_in @user
    end
  end
end
