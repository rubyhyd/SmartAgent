class SensorsController < ApplicationController
  include ResourceParser

  before_action :set_sensor, only: [:show, :edit, :update, :destroy]

  # GET /sensors
  # GET /sensors.json
  def index
    @resources = Sensor.all
		descriptions = Array.new
		identifications = Array.new
		@resources.each do |sensor|
			descriptions.push(sensor_description sensor.capbility)
			identifications.push(sensor_identifier sensor.capbility)
		end
		respond_to do |format|  
      format.js { render 'share/resource_grid', locals: {resource_name: '传感器', descriptions: descriptions, identifications: identifications}}
      format.html
    end
  end

  def queryAll
    @sensors = Sensor.all
    response.headers['Access-Control-Allow-Origin'] = '*'
    render json: @sensors, content_type: "application/json" 
  end

  # GET /sensors/1
  # GET /sensors/1.json
  def show
    @sensor = Sensor.find(params[:id])
    labels = sensor_parse @sensor.capbility
    session[:app]["sensor"] = Hash.new
    session[:app]["sensor"]["sensorid"] = @sensor.id
    respond_to do |format|
      format.js {render 'share/resource_form', locals: {resource: :sensor,labels: labels}}
      format.html
    end
  end

  # GET /sensors/new
  def new
    @sensor = Sensor.new
  end

  # GET /sensors/1/edit
  def edit
  end

  # POST /sensors
  # POST /sensors.json
  def create
    @sensor = current_user.sensors.build(sensor_params)

    respond_to do |format|
      if @sensor.save
        format.html { redirect_to '/pages/developer', notice: '成功注册了' }
        format.json { render :show, status: :created, location: @sensor }
      else
        format.html { render :new }
        format.json { render json: @sensor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sensors/1
  # PATCH/PUT /sensors/1.json
  def update
    respond_to do |format|
      if @sensor.update(sensor_params)
        format.html { redirect_to @sensor, notice: 'Sensor was successfully updated.' }
        format.json { render :show, status: :ok, location: @sensor }
      else
        format.html { render :edit }
        format.json { render json: @sensor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sensors/1
  # DELETE /sensors/1.json
  def destroy
    @sensor.destroy
    respond_to do |format|
      format.html { redirect_to sensors_url, notice: 'Sensor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sensor
    @sensor = Sensor.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sensor_params
    params.require(:sensor).permit(:name, :capbility, :url)
  end
end
