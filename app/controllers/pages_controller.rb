class PagesController < ApplicationController
  before_action :authenticate, except: [:start]


  def start
    if signin?
      redirect_to pages_index_url 
    end
  end

  def index
			@apps = current_user.apps.all
  end

  def location
  end

  def myapps
      @apps = current_user.apps.all
  end

  def createapp
    @app = current_user.apps.build()
    #important to initalize the session[:app]
    session[:app] = Hash.new unless session[:app]
  end


  def viewapps
  	@apps = App.all
	end
  def resources
    @sensors = Sensor.all
    @actuators = Actuator.all
  end
  def developer
		@sensor = current_user.sensors.build
		@actuator = current_user.actuators.build
		@sensors = current_user.sensors.all
		@actuators = current_user.actuators.all
  end
  def pages_myaccount
  end
end
