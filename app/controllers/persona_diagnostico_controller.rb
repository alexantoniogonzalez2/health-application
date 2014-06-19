class PersonaDiagnosticoController < ApplicationController

	 def cargarDiagnosticos		

		diag = []
  	
		term = params[:q]

		if params[:diag_no_frec] == 'true'
			@diagnosticos = MedDiagnosticos.where("nombre LIKE ? ", "%#{term}%")
		else
			@diagnosticos = MedDiagnosticos.where("nombre LIKE ? AND frecuente = ? ", "%#{term}%",true)
		end			
		
		@diagnosticos.each do |f|
			diag << f.formato_lista			
		end

		respond_to do |format|
			format.json { render json: diag}
		end
				
	end

	def agregarDiagnostico		

		persona_diagnostico_atencion_actual = FiPersonaDiagnosticos.joins(:persona_diagnosticos_atencion_salud).where('fi_persona_diagnosticos_atenciones_salud.atencion_salud_id = ? AND diagnostico_id = ? ' , params[:atencion_salud_id], params[:diagnostico_id]).first

		if persona_diagnostico_atencion_actual

			render :json => { :success => false }		

		else 

			@persona_diagnostico = FiPersonaDiagnosticos.where('diagnostico_id = ? ',params[:diagnostico_id]).first

			if !@persona_diagnostico

				@persona_diagnostico = FiPersonaDiagnosticos.new
				@persona_diagnostico.persona_id = params[:persona_id]
				@persona_diagnostico.diagnostico_id = params[:diagnostico_id]
				@persona_diagnostico.fecha_inicio = DateTime.current
				@persona_diagnostico.estado_diagnostico_id = 1
				@persona_diagnostico.save!
				
			end	

			@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.new
			@persona_diagnostico_atencion.persona_diagnostico_id = @persona_diagnostico.id
			@persona_diagnostico_atencion.atencion_salud_id = params[:atencion_salud_id]
			@persona_diagnostico_atencion.estado_diagnostico_id = 1
			@persona_diagnostico_atencion.save

			@estados_diagnostico = MedDiagnosticoEstados.all

			respond_to do |format|     
      	format.js   {}
      	format.json { render :json => { :success => true, :pers_diag => @persona_diagnostico.id }	 }
      end		
		
		end  	
	end

	def eliminarDiagnostico		


  	@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.where(" persona_diagnostico_id = ? AND atencion_salud_id = ? ",params[:persona_diagnostico_id],params[:atencion_salud_id])
  	@persona_diagnostico_atencion.destroy_all 

  	#Si no hay otra, se elimina el diagnóstico
  	@persona_diagnostico_atencion_otro = FiPersonaDiagnosticosAtencionesSalud.where(" persona_diagnostico_id = ? ",params[:atencion_salud_id])

  	if @persona_diagnostico_atencion_otro 
  		@persona_diagnostico = FiPersonaDiagnosticos.find(params[:persona_diagnostico_id])
  		@persona_diagnostico.destroy 
  	end	

  	render :json => { :success => true }	
	end

	def guardarDiagnostico		
		@persona_diagnostico = FiPersonaDiagnosticos.find(params[:persona_diagnostico_id])
		@estado = MedDiagnosticoEstados.find(params[:estado_diagnostico])
  	@persona_diagnostico.update( estado_diagnostico: @estado, fecha_inicio: params[:fecha_inicio], fecha_termino: params[:fecha_termino] )

  	@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.where("persona_diagnostico_id = ?",params[:persona_diagnostico_id]).first	
		@persona_diagnostico_atencion.update( estado_diagnostico: @estado , comentario: params[:comentario])

  	render :json => { :success => true, :pers_diag => @persona_diagnostico.id }	
	end



end
