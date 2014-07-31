class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
	
	def queryApps
		@apps = User.find(params[:user_id]).apps
		#@apps = current_user.apps
		render json: @apps
	end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "注册成功！请登录~"
      redirect_to signin_path 
    else
      flash[:danger] = "糟糕! 邮箱或密码错误"
      redirect_to signup_path
    end
  end

  private

  def user_params 
    params.require(:user).permit(:email, :hashed_password, :salt, :password, :password_confirmation)      
  end
end
