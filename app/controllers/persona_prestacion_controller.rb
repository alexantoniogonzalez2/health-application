class PersonaPrestacionController < ApplicationController
	
	def agregarPrestacion		

		persona_prestacion_actual = FiPersonaPrestaciones.where('atencion_salud_id = ? AND persona_id = ? AND prestacion_id = ? ', params[:atencion_salud_id], params[:persona_id], params[:prestacion_id]).first
		@prestadores = PrePrestadores.all
		
		if persona_prestacion_actual
			render :json => { :success => false }	
		else 
			
			@persona_prestacion = FiPersonaPrestaciones.new
			@persona_prestacion.persona_id = params[:persona_id]
			@persona_prestacion.atencion_salud_id = params[:atencion_salud_id]
			@persona_prestacion.prestacion_id = params[:prestacion_id]
			@persona_prestacion.save!

			if params[:tipo] == 'examen'
				respond_to do |format|     
	      	format.js   { render 'agregarExamen'}
	      	format.json { render :json => { :success => true } }
	      end	
	    else
	    	respond_to do |format|     
	      	format.js   { render 'agregarProcedimiento'}
	      	format.json { render :json => { :success => true } }
	      end    
	    end  

		end  	
	end

	def agregarPrestacionAntecedentes		

		@prestadores = PrePrestadores.all			
		@persona_prestacion = FiPersonaPrestaciones.new

		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first	
		else
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
			@persona_prestacion.atencion_salud = @atencion_salud
		end	

		@persona_prestacion.persona = @persona
		@persona_prestacion.prestacion_id = params[:prestacion_id]
		@persona_prestacion.es_antecedente = true
		@persona_prestacion.save!

		#no está considerado examenes como antecedentes
		if params[:tipo] == 'examen'
			respond_to do |format|     
      	format.js   { render 'agregarExamenAntecedentes'}
      	format.json { render :json => { :success => true } }
      end	
    else
    	respond_to do |format|     
      	format.js   { render 'agregarProcedimientoAntecedentes'}
      	format.json { render :json => { :success => true } }
      end    
    end  


	end

	def cargarPrestaciones		

		term = params[:q]
		words = term.split(' ')
		words.map! {|word| "med_prestaciones.nombre like '%"<<word<<"%'" }			
		sql_term = words.join(' AND ')		
		
		if params[:tipo] == 'examen'
			min  = 1
			max = 56
		else
			min = 57
			max = 250
		end		

		#se puede mejorar consulta para filtrar por grupos 3 y 4 en vez de filtrar por los subgrupos	
		@prestaciones = MedPrestaciones.joins(:subgrupo).where(sql_term<<" AND med_prestaciones_subgrupos.id BETWEEN ? and ? ",min,max)
		
		pres = []
		@prestaciones.each do |f|
			pres << f.formato_prestaciones			
		end

		respond_to do |format|
			format.json { render json: pres}
		end
				
	end

	def eliminarPrestacion		
		@persona_prestacion = FiPersonaPrestaciones.find(params[:persona_prestacion_id])
		FiPersonaPrestacionDiagnosticos.where(:persona_prestacion => @persona_prestacion.id).destroy_all
  	@persona_prestacion.destroy 
  	
  	render :json => { :success => true }	
	end

	def indexExamen
		min  = 1
		max = 56
		@acceso = true
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first		
		if params[:p_i] and params[:a_i] #Vista de profesional: si existe este parametro se verifica que el profesional coincida con la cuenta del usuario
			@agendamiento = AgAgendamientos.find(params[:a_i])
			@acceso = false if  @agendamiento.especialidad_prestador_profesional.profesional.id != @usuario.id
			@paciente = @agendamiento.persona 
		else
			@paciente = @usuario
		end				
		@persona_prestaciones = FiPersonaPrestaciones.joins(:prestacion).where('persona_id = ? AND subgrupo_id BETWEEN ? and ?',@paciente.id,min,max) if @acceso
		render 'index'					
	end

	def indexProc
		min = 57
		max = 250
		@acceso = true
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		if params[:p_i] and params[:a_i] #Vista de profesional: si existe este parametro se verifica que el profesional coincida con la cuenta del usuario
			@agendamiento = AgAgendamientos.find(params[:a_i])
			@acceso = false if  @agendamiento.especialidad_prestador_profesional.profesional.id != @usuario.id
			id_usuario = params[:p_i]
			@paciente = @agendamiento.persona
		else
			@paciente = @usuario	 
		end
		@persona_prestaciones = FiPersonaPrestaciones.joins(:prestacion).where('persona_id = ? AND subgrupo_id BETWEEN ? and ?',@paciente.id,min,max) if @acceso
		render 'index'					
	end

	def agregarInfoPrestacion
		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id]) if params[:atencion_salud_id] != 'persona'
		@persona_prestacion = FiPersonaPrestaciones.find(params[:p_p])
		case params[:param]
			when 'fecha'
				if params[:valor].length == 4  
					@persona_prestacion.fecha_prestacion = DateTime.new(params[:valor].to_i , 1, 1)
				else	
					@persona_prestacion.fecha_prestacion = params[:valor] 
				end	
			when 'prestador'
				@persona_prestacion.prestador_texto = params[:valor]  
		end
		@persona_prestacion.save!

  	if @persona_prestacion.es_antecedente
  		respond_to do |format|     
    		format.js   {}
    	end	  		
  	else  
  		render :json => { :success => true }	  		
  	end		

	end	

	def agregarDiagPres
		@tipo = params[:tipo]
		@p_p = FiPersonaPrestaciones.find(params[:id])
		@id = (params[:atencion_salud_id])

		@persona_diagnostico = FiPersonaDiagnosticos
	  	.joins(:persona_diagnosticos_atencion_salud)
	  	.select("fi_persona_diagnosticos_atenciones_salud.id,
	  					fi_persona_diagnosticos.diagnostico_id")
	  	.where('fi_persona_diagnosticos_atenciones_salud.atencion_salud_id = ? AND es_antecedente != 1 ',@id)	  

		respond_to do |format|     
    	format.js   {}
    	format.json { render :json => { :success => true } }
    end	
	end	

	def actualizarDiagPrestacion
		@persona_prestacion = FiPersonaPrestaciones.find(params[:p_p])
		@pdat = FiPersonaDiagnosticosAtencionesSalud.find(params[:p_d]) 
		@persona_prestacion_diagnostico = FiPersonaPrestacionDiagnosticos.where('persona_prestacion_id = ? AND persona_diagnostico_atencion_salud_id = ?',params[:p_p],params[:p_d]).first

		if params[:valor] == 'true'
			if !@persona_prestacion_diagnostico
				@persona_prestacion_diagnostico = FiPersonaPrestacionDiagnosticos.new
				@persona_prestacion_diagnostico.persona_prestacion = @persona_prestacion
				@persona_prestacion_diagnostico.persona_diagnostico_atencion_salud = @pdat
				@persona_prestacion_diagnostico.para_interconsulta = true
				@persona_prestacion_diagnostico.save!
			end	
		else
			if @persona_prestacion_diagnostico
				@persona_prestacion_diagnostico.destroy!
			end		
		end 	
		respond_to do |format|   
    	format.json { render :json => { :success => true } }
    end	

	end	

	def actualizarDiagPrestacionInt

		@persona_prestacion_diagnostico = FiPersonaPrestacionDiagnosticos.where('id = ? AND persona_diagnostico_atencion_salud_id = ?',params[:p_p],params[:p_d]).first
		@persona_prestacion_diagnostico.para_interconsulta = (params[:valor] == 'true') ? true : false
		@persona_prestacion_diagnostico.save!	

		respond_to do |format|   
    	format.json { render :json => { :success => true } }
    end	

	end	

end