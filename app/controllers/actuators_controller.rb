class ActuatorsController < ApplicationController
  include ResourceParser
  before_action :set_actuator, only: [:show, :edit, :update, :destroy]

  # GET /actuators
  # GET /actuators.json
  def index
    @resources =  Actuator.all
		descriptions = Array.new
		identifications = Array.new
		@resources.each do |actuator|
			descriptions.push(actuator_description actuator.capbility)
			identifications.push(actuator_identification actuator.capbility)
		end
		respond_to do |format|
			format.js { render 'share/resource_grid', locals: {resource_name: '执行器', descriptions: descriptions, identifications: identifications}}
			format.html
		end
  end


  def queryAll
    @actuators = Actuator.all
		response.headers['Access-Control-Allow-Origin'] = '*'
    render json: @actuators, content_type: "application/json"
  end

  # GET /actuators/1
  # GET /actuators/1.json
  def show
	@actuator = Actuator.find(params[:id])
	  labels = actuator_parse @actuator.capbility
    session[:app]["actuator"] = Hash.new
    session[:app]["actuator"]["actuatorid"] = @actuator.id
	  respond_to do |format|
	    format.js {render 'share/resource_form', locals: {resource: :actuator, labels: labels }}
		format.html
	end
  end

  # GET /actuators/new
  def new
    @actuator = Actuator.new
  end

  # GET /actuators/1/edit
  def edit
  end

  # POST /actuators
  # POST /actuators.json
  def create
    @actuator = current_user.actuators.build(actuator_params)

    respond_to do |format|
      if @actuator.save
        format.html { redirect_to '/pages/developer', notice: '成功注册一个执行器' }
        format.json { render :show, status: :created, location: @actuator }
      else
        format.html { render :new }
        format.json { render json: @actuator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /actuators/1
  # PATCH/PUT /actuators/1.json
  def update
    respond_to do |format|
      if @actuator.update(actuator_params)
        format.html { redirect_to @actuator, notice: 'Actuator was successfully updated.' }
        format.json { render :show, status: :ok, location: @actuator }
      else
        format.html { render :edit }
        format.json { render json: @actuator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actuators/1
  # DELETE /actuators/1.json
  def destroy
    @actuator.destroy
    respond_to do |format|
      format.html { redirect_to actuators_url, notice: 'Actuator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_actuator
      @actuator = Actuator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def actuator_params
      params.require(:actuator).permit(:name, :capbility, :url)
    end
end
