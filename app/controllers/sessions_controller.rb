class SessionsController < ApplicationController

  def new
  end

  def sensor
    session[:app]["sensor"]["condition"] = params[:condition] 
  respond_to do |format|
    format.js {render 'share/resource_form_check', locals: {resource: 'sensor'}}
  end
  end

  def actuator
    session[:app]["actuator"]["params"] = params[:params]
    respond_to do |format|
    format.js {render 'share/resource_form_check', locals: {resource: 'actuator'}}
  end
  end


  def create
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if user
      session[:user_id] = user.id
      flash[:success] = "登陆成功！欢迎回来~"
      redirect_to pages_index_path
    else
      flash[:danger] = "糟糕! 邮箱或密码错误"
      redirect_to signin_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
