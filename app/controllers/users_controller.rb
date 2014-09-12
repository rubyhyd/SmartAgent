class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
	
	def queryApps
    response.headers['Access-Control-Allow-Origin'] = '*'
		@apps = User.find(params[:user_id]).apps
		#@apps = current_user.apps
		render json: @apps
	end
  
  def create
    @user = User.new(user_params)
    if @user.save
      status = "success"
      info = "注册成功！请登录~"
      respond_to do |format| 
        format.js { render :create, locals: {status: status, info: info}}
      end
    else
      status = "danger"
      info = "糟糕! 邮箱或密码错误"
      respond_to do |format|
        format.js {render :create, locals: {status: status, info: info}}
      end
    end
  end

  private

  def user_params 
    params.require(:user).permit(:email, :hashed_password, :salt, :password, :password_confirmation)      
  end
end
