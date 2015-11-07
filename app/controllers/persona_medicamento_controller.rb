class PersonaMedicamentoController < ApplicationController

	def cargarMedicamentos		

		term = params[:q]
		words = term.split(' ')
		words.map! {|word| "nombre like '%"<<word<<"%'" }			
		sql_term = words.join(' AND ')

		@medicamentos = MedMedicamentos.where(sql_term).where("es_nombre_farmaco = '1'")
		
		med =[]	
		@medicamentos.each do |f|
			med << f.formato_medicamentos			
		end

		respond_to do |format|
			format.json { render json: med}
		end
				
	end

	def agregarMedicamento		

		persona_examen_actual = FiPersonaMedicamentos.where('atencion_salud_id = ? AND persona_id = ? AND medicamento_id = ? AND es_antecedente is null ', params[:atencion_salud_id], params[:persona_id], params[:medicamento_id]).first

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
      	format.json { render :json => { :success => true } }
      end	

		end  	
	end

	def agregarMedicamentoAntecedentes
		
		@persona_medicamento = FiPersonaMedicamentos.new

		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first	
		else 
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
			@persona_medicamento.atencion_salud = @atencion_salud
		end	
				
		@persona_medicamento.persona = @persona
		@persona_medicamento.medicamento_id = params[:medicamento_id]
		@persona_medicamento.es_antecedente = true
		@persona_medicamento.save!

		tipo = @persona_medicamento.medicamento.medicamento_tipo_id;

	  if tipo == 1 
	    @unidad = 'comprimidos'
	  else tipo == 2
	    @unidad = 'ml'
	  end

		respond_to do |format|     
    	format.js   {}
    	format.json { render :json => { :success => true } }
    end	
		 	
	end

	def eliminarMedicamento		
		@persona_medicamento = FiPersonaMedicamentos.find(params[:persona_medicamento_id])
  	@persona_medicamento.destroy 

  	render :json => { :success => true }	
	end

	def guardarMedicamento		
		@persona_medicamento = FiPersonaMedicamentos.find(params[:persona_medicamento_id])
		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id]) if params[:atencion_salud_id] != 'persona'
		if params[:duracion] != ''
			@fecha_inicio = DateTime.current
			@fecha_final = DateTime.current + params[:duracion].to_i.days
			@persona_medicamento.update( cantidad: params[:cantidad], periodicidad: params[:periodicidad], duracion: params[:duracion], 
																	 total: params[:total], fecha_inicio: @fecha_inicio, fecha_final: @fecha_final, indicacion: params[:indicacion], via_administracion: params[:via_administracion])
		else	
  		@persona_medicamento.update( cantidad: params[:cantidad], periodicidad: params[:periodicidad], duracion: params[:duracion],
  																 total: params[:total], indicacion: params[:indicacion], via_administracion: params[:via_administracion] )
  	end	

  	if @persona_medicamento.es_antecedente
  		respond_to do |format|     
    		format.js   {}
    	end	  		
  	else  
  		render :json => { :success => true }	  		
  	end	
	end

	def agregarDiagMed
		@tipo = params[:tipo]
		@med = params[:med]
		@persona_medicamento = FiPersonaMedicamentos.find(params[:med])

		@persona_diagnostico = FiPersonaDiagnosticos
	  	.joins(:persona_diagnosticos_atencion_salud)
	  	.select("fi_persona_diagnosticos_atenciones_salud.id,
	  					fi_persona_diagnosticos.diagnostico_id")
	  	.where('fi_persona_diagnosticos_atenciones_salud.atencion_salud_id = ? AND es_antecedente != 1',params[:id])	  

		respond_to do |format|     
    	format.js   {}
    	format.json { render :json => { :success => true } }
    end	
		
	end

	def actualizarDiagMed
		@persona_medicamento = FiPersonaMedicamentos.find(params[:med])
		@persona_diagnostico_atencion_salud = FiPersonaDiagnosticosAtencionesSalud.find(params[:p_d])
		@persona_medicamento_diagnostico = FiPersonaMedicamentoDiagnosticos.where('persona_medicamento_id = ? AND persona_diagnostico_atencion_salud_id = ?',params[:med],params[:p_d]).first

		if params[:valor] == 'true'
			if !@persona_medicamento_diagnostico
				@persona_medicamento_diagnostico = FiPersonaMedicamentoDiagnosticos.new
				@persona_medicamento_diagnostico.persona_medicamento = @persona_medicamento
				@persona_medicamento_diagnostico.persona_diagnostico_atencion_salud = @persona_diagnostico_atencion_salud
				@persona_medicamento_diagnostico.save!
			end	
		else
			if @persona_medicamento_diagnostico
				@persona_medicamento_diagnostico.destroy!
			end		
		end 	
		respond_to do |format|   
    	format.json { render :json => { :success => true } }
    end	
	end

end
