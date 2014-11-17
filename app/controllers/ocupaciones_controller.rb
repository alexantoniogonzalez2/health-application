class OcupacionesController < ApplicationController
	def new
	end
	def edit
		@ocupacion = OcuPersonasOcupaciones.where('id = ?',params[:id]).first			
	end
	def index
		@ocupaciones = OcuPersonasOcupaciones.where('persona_id = ?',current_user.id);
	end	
	def create

		case params[:tipo]
		when 'agregar'
			@persona_ocupacion = OcuPersonasOcupaciones.new
			@persona_ocupacion.persona = PerPersonas.find(current_user.id)
			@persona_ocupacion.ocupacion = OcuOcupaciones.find(params[:value])
			@persona_ocupacion.fecha_inicio = params[:f_i]
			@persona_ocupacion.fecha_termino = params[:f_f]
			@persona_ocupacion.save!
		when 'editar'
			@persona_ocupacion = OcuPersonasOcupaciones.find(params[:id])
			@persona_id = @persona_ocupacion.persona.id 
			if @persona_id == current_user.id
				@persona_ocupacion.ocupacion = OcuOcupaciones.find(params[:value])
				@persona_ocupacion.fecha_inicio = params[:f_i]
				@persona_ocupacion.fecha_termino = params[:f_f]
				@persona_ocupacion.save!
			end					
		end

		respond_to do |format|
			format.json { render :json => { :success => true }	}
		end		
	end	
	def cargarOcupaciones
		ocu = []  	
		term = params[:q]

		@ocupaciones = OcuOcupaciones.where("nombre LIKE ? ","%#{term}%")

		@ocupaciones.each do |p|
			ocu << p.formato_ocupaciones			
		end

		respond_to do |format|
			format.json { render json: ocu}
		end
	end	
end
