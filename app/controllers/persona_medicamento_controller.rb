class PersonaMedicamentoController < ApplicationController

	def cargarMedicamentos		

		term= params[:q]
		med=[]
		

		@medicamentos = MedMedicamentos.where("med_medicamentos.nombre LIKE ? ", "%#{term}%" )
		
		@medicamentos.each do |f|
			med << f.formato_medicamentos			
		end

		respond_to do |format|
			format.json { render json: med}
		end
				
	end

	def agregarMedicamento		

		persona_examen_actual = FiPersonaMedicamentos.where('atencion_salud_id = ? AND persona_id = ? AND medicamento_id = ? ', params[:atencion_salud_id], params[:persona_id], params[:medicamento_id]).first

		if persona_examen_actual

			render :json => { :success => false }		

		else 
			@persona_medicamento = FiPersonaMedicamentos.new
			@persona_medicamento.persona_id = params[:persona_id]
			@persona_medicamento.atencion_salud_id = params[:atencion_salud_id]
			@persona_medicamento.medicamento_id = params[:medicamento_id]
			@persona_medicamento.save!

			tipo = @persona_medicamento.medicamento.medicamento_tipo_id;

		  if tipo == 1 
		    @unidad = 'comprimidos'
		  else tipo == 2
		    @unidad = 'ml'
		  end 


			respond_to do |format|     
      	format.js   {}
      	format.json { render :json => { :success => true, :per_med => @persona_medicamento.id } }
      end	
			#render :json => { :success => true, :per_med => @persona_medicamento.id }	
		
		end  	
	end

	def eliminarMedicamento		
		@persona_medicamento = FiPersonaMedicamentos.find(params[:persona_medicamento_id])
  	@persona_medicamento.destroy 

  	render :json => { :success => true }	
	end

	def guardarMedicamento		
		@persona_medicamento = FiPersonaMedicamentos.find(params[:persona_medicamento_id])
  	@persona_medicamento.update( cantidad: params[:cantidad], periodicidad: params[:periodicidad], duracion: params[:duracion], total: params[:total] )
  	
  	render :json => { :success => true }	
	end

end
