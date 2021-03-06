class UsersController < ApplicationController
  
  skip_before_action :authorize_request, only: [:create, :show]
  # POST /signup
  # return authenticated token upon signup

  def show
    @users = User.all
    json_response(@users)
  end

  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token, user: user }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(
        :name,
        :email,
        :location,
        :position,
        :fun_facts,
        :first_img,
        :second_img,
        :password,
        :password_confirmation
    )
  end
end
