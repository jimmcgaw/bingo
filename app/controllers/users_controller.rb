class UsersController < ApplicationController
  def index
    # TODO - restrict _authorization_ to admin-only
    @users = User.all
  end

  def show
    find_user
  end

  def new
  end

  def edit
  end

  def create
    @user = User.create!(user_params)
    redirect_to @user
  end

  def update
    find_user
    if @user.update(user_params)
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to "/" # TODO - maybe add a "thank you page or something?"
  end

  def reset_password
    @user = User.find(params[:id])
    # TODO - for now, email a new random password, expiring after X minutes
    # TODO - maybe setup a lockout table or column... probably table
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user.present?
      # TODO - add password/authentication logic
    end
    raise "User email/password combination not found" if @user.nil?
    redirect_to @user
  end


  private
    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :screen_name)
    end
end
