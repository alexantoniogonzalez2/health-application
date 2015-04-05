class OcupacionesController < ApplicationController
	def new
	end
	def edit
		@ocupacion = OcuPersonasOcupaciones.where('id = ?',params[:id]).first			
	end
	def index
		@persona = PerPersonas.where('user_id = ?',current_user.id).first	
		@ocupaciones = OcuPersonasOcupaciones.where('persona_id = ?',@persona.id);
	end	
	def create
		@tipo = params[:tipo]	
		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first	 
		else 
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
		end	

		case params[:tipo]
		when 'agregar'
		  @ocu = OcuPersonasOcupaciones.new
		  @ocu.persona = @persona
		when 'editar'
		  @ocu = OcuPersonasOcupaciones.find(params[:id])		  			
		end
		@ocu.ocupacion = OcuOcupaciones.find(params[:value])
		@ocu.es_actual = params[:ocu_act]
		@ocu.fecha_inicio = params[:f_i]
		@ocu.fecha_termino = params[:f_f]
	  @ocu.save!

		respond_to do |format|
			format.js   {}
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
