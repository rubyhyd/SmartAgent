require 'rexml/document'
module ResourceParser
  extend ActiveSupport::Concern

  include REXML

	private
    # Sensor
	def sensor_parse xml
		a = Hash.new
		doc = Document.new(xml)
		
		doc.elements.each('sml:SensorML/sml:Parameter/*') do |ele|
			a[(ele.attribute :name).to_s] = ele.get_elements("gml:description").first.text
		end

		doc.elements.each('sml:SensorML/sml:Observation/swe:DataRecord/swe:field/*') do |ele|
			if ele.get_elements("sml:isTrigger").first.text == 'true'
				a[(ele.attribute :name).to_s] = ele.get_elements("gml:description").first.text
			end
		end
		a
	end

	def sensor_identifier xml
		a = Hash.new
		doc = Document.new(xml)
		doc.elements.each("sml:SensorML/sml:Identification/sml:IdentifierList/sml:identifier") do |ele|
			a[(ele.attribute :name).to_s] = ele.get_elements("sml:Term/sml:value").first.text
		end
		a	
	end

	def sensor_description xml
		a = Hash.new
		doc = Document.new(xml)
		doc.elements.each("sml:SensorML/sml:Capability/swe:DataRecord/swe:field/swe:Text") do |ele|
			a[ele.get_elements("gml:description").first.text.to_s] = ele.get_elements("swe:value").first.text
		end
		a
	end
	# Actuator
	def actuator_parse xml
		a = Hash.new
		doc = Document.new(xml)
		doc.elements.each('sml:SensorML/sml:Parameter/swe:DataRecord/swe:field/*') do |ele|
			a[(ele.attribute :name).to_s] = ele.get_elements("gml:description").first.text
		end
		a
	end

	def actuator_identification xml
		a = Hash.new
	  doc = Document.new(xml)
	  doc.elements.each("sml:SensorML/sml:Identification/sml:IdentifierList/sml:identifier") do |ele|
	  	a[(ele.attribute :name).to_s] = ele.get_elements("sml:Term/sml:value").first.text
	  end
	  a
	end

	def actuator_description xml
		a = Hash.new
		doc = Document.new(xml)
		doc.elements.each("sml:SensorML/sml:Capability/swe:Text") do |ele|
			a[ele.get_elements("gml:description").first.text.to_s] = ele.get_elements("swe:value").first.text
		end
		a
	end
	def actuator_parameter xml
		a = Hash.new
		doc = Document.new(xml)
		doc.elements.each("sml:SensorML/sml:Observation/swe:DataRecord/swe:field/*") do |ele|
			if ele.get_elements("sml:toActuator").first.text == true
				a[(ele.attributs :name).to_s] = ele.get_elements("gml:description").first.text
			end
		end
		a
	end
end
