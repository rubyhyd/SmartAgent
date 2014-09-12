class AppsController < ApplicationController
  def index
  end

  def confirm
    respond_to do |format|
      format.js
    end
  end

  def query
    response.headers['Access-Control-Allow-Origin'] = '*'
    @app = User.find(params[:user_id]).apps.find(params[:app_id])
    render json: @app
  end

  def destroy
    @app = current_user.apps.find(params[:id])
    if @app.destroy
      redirect_to pages_index_path, notice: 'Delete an App!'
    else
      render pages_myapps_path
    end
  end

  def create
    @app = current_user.apps.build()
    @app.sensor_id = session[:app]["sensor"]["sensorid"]
    @app.actuator_id = session[:app]["actuator"]["actuatorid"]
		@app.name = params[:app_name]
		@app.description = params[:app_description]
    #生成崔爹格式json
    崔爹 = Hash.new
    崔爹["userid"] = current_user.id
    崔爹["name"] = params[:app_name]
    崔爹["description"] = params[:app_description]

    崔爹["triggerinfos"] = Array.new
    崔爹["triggerinfos"] << session[:app]["sensor"]
    崔爹["triggerinfos"][0]["sensoruri"] = Sensor.find(@app.sensor_id).url
    崔爹["triggerinfos"][0]["params"] = {"board" => "1"}
    崔爹["actuatorinfos"] = Array.new
    崔爹["actuatorinfos"] << session[:app]["actuator"] 
    崔爹["actuatorinfos"][0]["actuatoruri"] = Actuator.find(@app.actuator_id).url
    @app.sensor_params = 崔爹["triggerinfos"].to_s
    @app.actuator_params = 崔爹["actuatorsinfos"].to_s

    if @app.save
      崔爹["appid"] = @app.id
      sess = Patron::Session.new
      sess.base_url = "http://192.168.4.222:10000"
      sess.post("/ruleService/addRule", 崔爹.to_json, {"Content-Type" => "text/plain"})
      redirect_to pages_index_path
    else
      render pages_createapp_path 
    end
  end





  private

  def app_params
    params.require(:app).permit(:name)
  end


end


