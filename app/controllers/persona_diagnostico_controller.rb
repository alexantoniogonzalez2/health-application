class PersonaDiagnosticoController < ApplicationController

	 def cargarDiagnosticos		

		term = params[:q]
		words = term.split(' ')
		words.map! {|word| "nombre like '%"<<word<<"%'" }			
		sql_term = words.join(' AND ')

		if params[:diag_no_frec] == 'true'
			@diagnosticos = MedDiagnosticos.where("nodo_terminal = 1 AND ( ("<<sql_term<<") OR codigo_cie10 LIKE ? )", "%#{term}%")
		else
			@diagnosticos = MedDiagnosticos.where("nodo_terminal = 1 AND frecuente = ? AND ( ("<<sql_term<<") OR codigo_cie10 LIKE ?) ", true, "%#{term}%")
		end			
		
		diag = []  	
		@diagnosticos.each do |f|
			diag << f.formato_lista			
		end

		respond_to do |format|
			format.json { render json: diag}
		end
				
	end

	def agregarInfoEno

		fecha = ''
		confirmacion = ''
		vacunacion = ''
		pais = nil
		embarazo = ''
		sem_emb = ''
		tbc = ''

		@notificacion_eno = FiNotificacionesEno.where('persona_diagnostico_atencion_salud_id = ? and fecha_notificacion is null ',params[:pers_diag]).first

		if @notificacion_eno.nil? 			
			@notificacion_eno = FiNotificacionesEno.new
			@notificacion_eno.persona_diagnostico_atencion_salud_id = params[:pers_diag]
			#Si existe una notificación completa, se utilizará esa información
			@notificacion_eno_completa = FiNotificacionesEno.where('persona_diagnostico_atencion_salud_id = ? ',params[:id]).order('fecha_notificacion DESC').first
			if @notificacion_eno_completa
				@notificacion_eno.fecha_primeros_sintomas = @notificacion_eno_completa.fecha_primeros_sintomas
				@notificacion_eno.confirmacion_diagnostica = @notificacion_eno_completa.confirmacion_diagnostica
				@notificacion_eno.antecedentes_vacunacion = @notificacion_eno_completa.antecedentes_vacunacion
				@notificacion_eno.pais_contagio = @notificacion_eno_completa.pais_contagio
				@notificacion_eno.embarazo = @notificacion_eno_completa.embarazo
				@notificacion_eno.semanas_gestacion = @notificacion_eno_completa.semanas_gestacion 
				@notificacion_eno.tbc = @notificacion_eno_completa.tbc	
			end
		end	

		case params[:tipo]
			when 'fecha'
				@notificacion_eno.fecha_primeros_sintomas = params[:valor] 
			when 'confirmacion'
				@notificacion_eno.confirmacion_diagnostica = params[:valor]  
			when 'vacunacion'
				@notificacion_eno.antecedentes_vacunacion = params[:valor] 
			when 'pais'
				@pais = TraPaises.find(params[:valor])
				@notificacion_eno.pais_contagio = @pais 
			when 'embarazo'
				@notificacion_eno.embarazo = params[:valor]
			when 'sem_emb'
				@notificacion_eno.semanas_gestacion = params[:valor]
			when 'tbc'
				@notificacion_eno.tbc = params[:valor]						
		end

		@notificacion_eno.save

		respond_to do |format|
			format.json { render :json => { :success => true }	}
		end
				
	end

	def agregarInfoInterconsulta

		@persona = nil
		nombre = ''
		correo = ''
		celular = ''
		telefono = ''
		rut = ''

		case params[:tipo]
			when 'persona'				
				unless params[:valor].blank? 
					@persona = PerPersonas.find(params[:valor])
					nombre = @persona.showName('%n%p%m')
					correo = @persona.getCorreo
					celular = @persona.getCelular
					telefono = @persona.getTelefonoFijo
					rut = @persona.showRut
				end
			when 'prestador'
				@prestador = PrePrestadores.find(params[:valor])
			when 'especialidad'
				@especialidad = ProEspecialidades.find(params[:valor]) unless params[:valor].blank? 
				@especialidad = '' if params[:valor].blank? 
			when 'comentario'
			when 'proposito'
			when 'pres_des_tex'			

		end

		@interconsulta = FiInterconsultas.where('persona_diagnostico_atencion_salud_id = ? and fecha_solicitud is null ',params[:pers_diag]).first

		if @interconsulta
		else	#se guarda info persona temporalmente, sin fecha			
			@interconsulta = FiInterconsultas.new
			@interconsulta.persona_diagnostico_atencion_salud_id = params[:pers_diag]	
			#si existe una interconsulta completa, se utiliza esa informacíón
			@interconsulta_completa = FiInterconsultas.where('persona_diagnostico_atencion_salud_id = ? ',params[:pers_diag]).order('fecha_solicitud DESC').first
			if @interconsulta_completa
				@interconsulta.persona_conocimiento = @interconsulta_completa.persona_conocimiento 
				@interconsulta.proposito = @interconsulta_completa.proposito  
				@interconsulta.prestador_destino = @interconsulta_completa.prestador_destino
				@interconsulta.especialidad = @interconsulta_completa.especialidad
				@interconsulta.comentario = @interconsulta_completa.comentario
				@interconsulta.proposito_otro = @interconsulta_completa.proposito_otro
				@interconsulta.prestador_destino_texto = @interconsulta_completa.prestador_destino_texto
				@interconsulta.save			
			end
		end	

		case params[:tipo]
			when 'persona'
				@interconsulta.persona_conocimiento = @persona 
			when 'prestador'
				@interconsulta.prestador_destino = @prestador 
			when 'especialidad'
				@interconsulta.especialidad = params[:valor].blank? ? nil : @especialidad 
			when 'comentario'
				@interconsulta.comentario = params[:valor]
			when 'proposito'
				@interconsulta.proposito = params[:valor]	
			when 'pres_des_tex'
				@interconsulta.prestador_destino_texto = params[:valor]				
		end

		@interconsulta.save

		respond_to do |format|
			format.json { render :json => { :success => true, :nombre => nombre, :correo => correo, :celular => celular, :rut => rut, :telefono => telefono }	}
		end
				
	end

	def agregarPersonaNotificacion

		@persona = nil
		nombre = ''
		correo = ''
		celular = ''
		rut = ''
		telefono = ''

		unless params[:valor].blank? 
			@persona = PerPersonas.find(params[:valor])
			nombre = @persona.showName('%n%p%m')
			correo = @persona.getCorreo
			celular = @persona.getCelular
			telefono = @persona.getTelefonoFijo
			rut = @persona.showRut
		end			

		@notificacion_ges = FiNotificacionesGes.where('persona_diagnostico_atencion_salud_id = ? and fecha_notificacion is null ',params[:pers_diag]).first

		if @notificacion_ges
			@notificacion_ges.persona_conocimiento = @persona 
			params[:valor].blank? ? @notificacion_ges.destroy : @notificacion_ges.save
		else	#se agrega persona temporalmente, sin fecha			
			@notificacion_ges = FiNotificacionesGes.new
			@notificacion_ges.persona_diagnostico_atencion_salud_id = params[:pers_diag]
			@notificacion_ges.persona_conocimiento = @persona 
			@notificacion_ges.save
		end	

		respond_to do |format|
			format.json { render :json => { :success => true, :nombre => nombre, :correo => correo, :celular => celular, :rut => rut, :telefono => telefono }	}
		end
				
	end

	def agregarDiagnostico
		ActiveRecord::Base.transaction do
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
		  @agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
		  @prestadores = PrePrestadores.all
		  @especialidades = ProEspecialidades.all
		  @paises = TraPaises.all	
		  @primer_diagnostico = 0	

			persona_diagnostico_atencion_actual = FiPersonaDiagnosticos
																							.joins(:persona_diagnosticos_atencion_salud)
																							.where('fi_persona_diagnosticos_atenciones_salud.atencion_salud_id = ? AND diagnostico_id = ? ',
																							 params[:atencion_salud_id],
																							 params[:diagnostico_id]).first

			if persona_diagnostico_atencion_actual
				render :json => { :success => false }	
			else
				@persona_diagnostico = FiPersonaDiagnosticos.where('diagnostico_id = ? AND persona_id = ?',params[:diagnostico_id],params[:persona_id]).first
				if !@persona_diagnostico
					@persona_diagnostico = FiPersonaDiagnosticos.new
					@persona_diagnostico.persona_id = params[:persona_id]
					@persona_diagnostico.diagnostico_id = params[:diagnostico_id]
					@persona_diagnostico.fecha_inicio = DateTime.current
					@persona_diagnostico.estado_diagnostico_id = 1
					@persona_diagnostico.es_cronica = 0		
					@persona_diagnostico.save!
					@primer_diagnostico = 1				
				else
					FiPersonaDiagnosticosAtencionesSalud.where('persona_diagnostico_id = ?',@persona_diagnostico.id).update_all(:es_ultima_actualizacion => 0)
				end	
				@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.new
				@persona_diagnostico_atencion.persona_diagnostico_id = @persona_diagnostico.id
				@persona_diagnostico_atencion.atencion_salud_id = params[:atencion_salud_id]
				@persona_diagnostico_atencion.estado_diagnostico_id = @persona_diagnostico.estado_diagnostico.id
				@persona_diagnostico_atencion.fecha_inicio = @persona_diagnostico.fecha_inicio
				@persona_diagnostico_atencion.fecha_termino = @persona_diagnostico.fecha_termino
				@persona_diagnostico_atencion.es_cronica = @persona_diagnostico.es_cronica
				@persona_diagnostico_atencion.en_tratamiento = 0
				@persona_diagnostico_atencion.es_antecedente = 0
				@persona_diagnostico_atencion.es_ultima_actualizacion = 1
				@persona_diagnostico_atencion.primer_diagnostico = @primer_diagnostico
				@persona_diagnostico_atencion.save

				@estados_diagnostico = MedDiagnosticoEstados.all
				@persona_diagnostico = FiPersonaDiagnosticos
			  	.joins(:persona_diagnosticos_atencion_salud)
			  	.select("fi_persona_diagnosticos_atenciones_salud.id,
			  					fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
			  					fi_persona_diagnosticos_atenciones_salud.fecha_termino,
			  					fi_persona_diagnosticos.diagnostico_id,
			  					fi_persona_diagnosticos.persona_id,
			  					fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
			  					fi_persona_diagnosticos_atenciones_salud.comentario,
			  					fi_persona_diagnosticos_atenciones_salud.es_cronica,
			  					fi_persona_diagnosticos_atenciones_salud.en_tratamiento,
			  					fi_persona_diagnosticos_atenciones_salud.primer_diagnostico")
			  	.where('fi_persona_diagnosticos_atenciones_salud.atencion_salud_id = ? AND diagnostico_id = ? ' ,
			  	 params[:atencion_salud_id],
			  	 params[:diagnostico_id]).first

				respond_to do |format|     
	      	format.js { }
	      	format.json { render :json => { :success => true, :pers_diag => @persona_diagnostico.id } }
	      end		
			end
		end #transaction  	
	end

	def agregarDiagnosticoAntecedentes

		@ant_prof = false
		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first	
		else
			@ant_prof = true	
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
		end

		persona_diagnostico_antecedente = FiPersonaDiagnosticos.joins(:persona_diagnosticos_atencion_salud)
																													 .where('fi_persona_diagnosticos_atenciones_salud.es_antecedente = true AND diagnostico_id = ? AND persona_id = ?',params[:diagnostico_id],@persona.id).first

		if persona_diagnostico_antecedente
			render :json => { :success => false }	
		else 	

			@persona_diagnostico_temp = FiPersonaDiagnosticos.where('diagnostico_id = ? and persona_id = ?', params[:diagnostico_id], @persona.id).first

			unless @persona_diagnostico_temp	
				@persona_diagnostico_temp = FiPersonaDiagnosticos.new
				@persona_diagnostico_temp.persona = @persona
				@persona_diagnostico_temp.diagnostico_id = params[:diagnostico_id]
				@persona_diagnostico_temp.fecha_inicio = DateTime.current
				@persona_diagnostico_temp.estado_diagnostico_id = 1
				@persona_diagnostico_temp.es_cronica = 0	
				@persona_diagnostico_temp.save!
			end		

			@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.new
			@persona_diagnostico_atencion.persona_diagnostico = @persona_diagnostico_temp
			@persona_diagnostico_atencion.atencion_salud = @atencion_salud unless params[:atencion_salud_id] == 'persona'
			@persona_diagnostico_atencion.fecha_inicio = DateTime.current
			@persona_diagnostico_atencion.estado_diagnostico_id = 1
			@persona_diagnostico_atencion.es_cronica = 0
			@persona_diagnostico_atencion.es_antecedente = 1			
			@persona_diagnostico_atencion.save!

			@estados_diagnostico = MedDiagnosticoEstados.all
			
			@persona_diagnostico = FiPersonaDiagnosticosAtencionesSalud.joins('JOIN fi_persona_diagnosticos AS fpd ON fi_persona_diagnosticos_atenciones_salud.persona_diagnostico_id = fpd.id
																																				JOIN med_diagnosticos AS md ON fpd.diagnostico_id = md.id')
																																	.select('fi_persona_diagnosticos_atenciones_salud.id,
																																		       fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
																																		       fi_persona_diagnosticos_atenciones_salud.atencion_salud_id,
																																		       fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
																																		       fi_persona_diagnosticos_atenciones_salud.fecha_termino,
																																		       fi_persona_diagnosticos_atenciones_salud.es_cronica,
																																		       fi_persona_diagnosticos_atenciones_salud.es_antecedente,
																																		       fi_persona_diagnosticos_atenciones_salud.comentario,
																																		       fi_persona_diagnosticos_atenciones_salud.created_at,
																																		       md.nombre,
																																		       fpd.persona_id,
																																		       fpd.diagnostico_id,
																																		       md.codigo_cie10')
																																	.where('fi_persona_diagnosticos_atenciones_salud.id = ?',@persona_diagnostico_atencion.id).first

			@estados_diagnostico = MedDiagnosticoEstados.all

			respond_to do |format|     
      	format.js { }
      	format.json { render :json => { :success => true} }
      end		
		
		end  	
	end

	def eliminarDiagnostico	

		@ant_prof = false
		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first	
		else
			@ant_prof = true	
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
		end

  	@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.where(" id = ? ",params[:persona_diagnostico_atencion_salud_id]).first
  	@persona_diagnostico_id = @persona_diagnostico_atencion.persona_diagnostico.id

  	#Se borra eventual asociación con medicamentos
  	@persona_medicamentos_diagnosticos = FiPersonaMedicamentoDiagnosticos.where('persona_diagnostico_atencion_salud_id = ?', @persona_diagnostico_atencion.id )
  	@persona_medicamentos_diagnosticos.each do |p_m|
			p_m.destroy				
		end

		#Se borra eventual asociación con certificados
  	@certificado_diagnosticos = FiCertificadoDiagnosticos.where('persona_diagnostico_atencion_salud_id = ?', @persona_diagnostico_atencion.id )
  	@certificado_diagnosticos.each do |c_d|
			c_d.destroy	
		end

		#Se borra eventual asociación con prestaciones
  	@persona_prestacion_diagnosticos = FiPersonaPrestacionDiagnosticos.where('persona_diagnostico_atencion_salud_id = ?', @persona_diagnostico_atencion.id )
  	@persona_prestacion_diagnosticos.each do |p_p_d|
			p_p_d.destroy	
		end
  	
  	@era_antecedente = @persona_diagnostico_atencion.es_antecedente
  	@persona_diagnostico_atencion.destroy

  	#Si no hay otra, se elimina el diagnóstico
  	@persona_diagnostico_atencion_otro = FiPersonaDiagnosticosAtencionesSalud.where("persona_diagnostico_id = ?", @persona_diagnostico_id).order("updated_at DESC").first

  	if !@persona_diagnostico_atencion_otro 
  		@persona_diagnostico = FiPersonaDiagnosticos.find(@persona_diagnostico_id)
  		@persona_diagnostico.destroy 
  	else #Se actualiza diagnostico con información de última atención de salud 
  		@persona_diagnostico = FiPersonaDiagnosticos.find(@persona_diagnostico_id)
  		@persona_diagnostico.estado_diagnostico_id = @persona_diagnostico_atencion_otro.estado_diagnostico_id
  		@persona_diagnostico.es_cronica = @persona_diagnostico_atencion_otro.es_cronica
  		@persona_diagnostico.fecha_inicio = @persona_diagnostico_atencion_otro.fecha_inicio
  		@persona_diagnostico.fecha_termino = @persona_diagnostico_atencion_otro.fecha_termino
  		@persona_diagnostico.save
  	end	

  	if @era_antecedente
  		respond_to do |format|     
      	format.js { }
      end
  	else
  		respond_to do |format|
  			format.json { render :json => { :success => true } }  			
  		end		
  	end	
	end

	def guardarDiagnostico	

		@estado = MedDiagnosticoEstados.find(params[:estado_diagnostico])
		@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.where("id = ?",params[:persona_diagnostico_atencion_salud_id]).first	

		@ant_prof = false
		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first	
		else
			@ant_prof = true	
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
			@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
			if @agendamiento.estado.nombre == 'Atención reabierta'
				@reabrir_estado_diagnostico = FiReabrirEstadoDiagnostico.new
				@reabrir_estado_diagnostico.persona_diagnostico_atencion_salud = @persona_diagnostico_atencion
				@reabrir_estado_diagnostico.estado_diagnostico = @persona_diagnostico_atencion.estado_diagnostico
				@reabrir_estado_diagnostico.fecha_cambio = DateTime.current
				@reabrir_estado_diagnostico.save!
			end	
		end

		@persona_diagnostico_atencion.update( estado_diagnostico: @estado , comentario: params[:comentario], fecha_inicio: params[:fecha_inicio], fecha_termino: params[:fecha_termino], es_cronica: params[:enf_cro], en_tratamiento: params[:trat])	
		@persona_diagnostico_id = @persona_diagnostico_atencion.persona_diagnostico_id

		@persona_diagnostico = FiPersonaDiagnosticos.find(@persona_diagnostico_id)		
  	@persona_diagnostico.update( estado_diagnostico: @estado, fecha_inicio: params[:fecha_inicio], fecha_termino: params[:fecha_termino], es_cronica: params[:enf_cro] )

  	if @persona_diagnostico_atencion.es_antecedente
			@persona_diagnostico = FiPersonaDiagnosticosAtencionesSalud.joins('JOIN fi_persona_diagnosticos AS fpd ON fi_persona_diagnosticos_atenciones_salud.persona_diagnostico_id = fpd.id
																																			   JOIN med_diagnosticos AS md ON fpd.diagnostico_id = md.id')
																															   .select('fi_persona_diagnosticos_atenciones_salud.id,
																															   					fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
																															   					fi_persona_diagnosticos_atenciones_salud.atencion_salud_id,
																															   					fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
																															   					fi_persona_diagnosticos_atenciones_salud.fecha_termino,
																															   					fi_persona_diagnosticos_atenciones_salud.es_antecedente,
																															   					fi_persona_diagnosticos_atenciones_salud.es_cronica,
																															   					fi_persona_diagnosticos_atenciones_salud.comentario,
																															   					fi_persona_diagnosticos_atenciones_salud.created_at,
																															   					md.nombre,
																															   					fpd.persona_id')
																															   .where('fpd.id = ?',@persona_diagnostico_id).first
  		respond_to do |format|     
      	format.js { }
      end
  	else
  		respond_to do |format|
  			format.json { render :json => { :success => true, :pers_diag => @persona_diagnostico_id } }  			
  		end		
  	end	

	end

	def autoguardarComentario

		@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.where("id = ?",params[:persona_diagnostico_atencion_salud_id]).first	
		@persona_diagnostico_atencion.update( comentario: params[:comentario] )	

		render :json => { :success => true}	

	end

	def descargarNotificacionObligatoria

		@notificacion_eno_pre = FiNotificacionesEno.where('persona_diagnostico_atencion_salud_id = ? and fecha_notificacion is null ',params[:id]).first
		@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.where("id = ?",params[:id]).first

		@fecha = ''
		@confirmacion = ''
		@vacunacion = ''
		@pais = nil
		@embarazo = ''
		@sem_emb = ''
		@tbc = ''
		borrar = false

		if (!@notificacion_eno_pre)
			@notificacion_eno_pre = FiNotificacionesEno.where('persona_diagnostico_atencion_salud_id = ? ',params[:id]).order('fecha_notificacion DESC').first
		else
			borrar = true	
		end	

		if @notificacion_eno_pre
			@fecha = @notificacion_eno_pre.fecha_primeros_sintomas
			@confirmacion = @notificacion_eno_pre.confirmacion_diagnostica
			@vacunacion = @notificacion_eno_pre.antecedentes_vacunacion
			@pais = @notificacion_eno_pre.pais_contagio
			@embarazo = @notificacion_eno_pre.embarazo
			@sem_emb = @notificacion_eno_pre.semanas_gestacion
			@tbc = @notificacion_eno_pre.tbc
			if borrar
				@notificacion_eno_pre.destroy
			end	
		end	

		@notificacion_eno = FiNotificacionesEno.new
		@notificacion_eno.persona_diagnostico_atencion_salud_id = params[:id]
		@notificacion_eno.fecha_notificacion = DateTime.current
		@notificacion_eno.fecha_primeros_sintomas = @fecha
		@notificacion_eno.confirmacion_diagnostica = @confirmacion
		@notificacion_eno.antecedentes_vacunacion = @vacunacion
		@notificacion_eno.pais_contagio = @pais
		@notificacion_eno.embarazo = @embarazo
		@notificacion_eno.semanas_gestacion = @sem_emb
		@notificacion_eno.tbc = @tbc

		@notificacion_eno.save		

	  @agendamiento = AgAgendamientos.find(params[:ag])

		p_d = FiPersonaDiagnosticos
  	.joins(:persona_diagnosticos_atencion_salud)
  	.select("fi_persona_diagnosticos_atenciones_salud.id,
  					fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
  					fi_persona_diagnosticos_atenciones_salud.fecha_termino,
  					fi_persona_diagnosticos.diagnostico_id,
  					fi_persona_diagnosticos.persona_id,
  					fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
  					fi_persona_diagnosticos_atenciones_salud.comentario,
  					fi_persona_diagnosticos_atenciones_salud.es_cronica,
  					fi_persona_diagnosticos_atenciones_salud.en_tratamiento")
  	.where('fi_persona_diagnosticos_atenciones_salud.id' => params[:id]).first

	  @estados_diagnostico = MedDiagnosticoEstados.all

	  nombre = l DateTime.current, format: :timestamp
	  nombre.to_s << ' Notificación obligatoria ' << p_d.persona.showName('%n%p%m') << p_d.diagnostico.nombre 

		respond_to do |format|
			format.pdf do
          render :pdf => nombre,
                 :template => "persona_diagnostico/notificacion_obligatoria.pdf.erb", :locals => {:p_d => p_d, :e_d => @estados_diagnostico, :agendamiento => @agendamiento, :persona => @persona } ,
                 :disposition => 'attachment',
                 :encoding => "utf8"            
 					 end               
		end

	end	

	def descargarInterconsulta 

		@interconsulta_pre = FiInterconsultas.where('persona_diagnostico_atencion_salud_id = ? and fecha_solicitud is null ',params[:id]).first
		@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.where("id = ?",params[:id]).first

		@persona = nil
		@proposito = nil
		@prestador_destino = nil
		@especialidad = nil
		@comentario = nil
		@proposito_otro = nil
		@prestador_destino_texto = nil
		borrar = false

		if (!@interconsulta_pre)
			@interconsulta_pre = FiInterconsultas.where('persona_diagnostico_atencion_salud_id = ? ',params[:id]).order('fecha_solicitud DESC').first
		else
			borrar = true	
		end	

		if @interconsulta_pre
			@persona = @interconsulta_pre.persona_conocimiento
			@proposito = @interconsulta_pre.proposito
			@prestador_destino = @interconsulta_pre.prestador_destino
			@especialidad = @interconsulta_pre.especialidad
			@comentario = @interconsulta_pre.comentario
			@proposito_otro = @interconsulta_pre.proposito_otro
			@prestador_destino_texto = @interconsulta_pre.prestador_destino_texto 
			if borrar
				@interconsulta_pre.destroy
			end	

		end	

		@interconsulta = FiInterconsultas.new
		@interconsulta.persona_diagnostico_atencion_salud_id = params[:id]
		@interconsulta.persona_conocimiento = @persona 
		@interconsulta.proposito = @proposito  
		@interconsulta.fecha_solicitud = DateTime.current
		@interconsulta.prestador_destino = @prestador_destino
		@interconsulta.especialidad = @especialidad
		@interconsulta.comentario = @comentario
		@interconsulta.proposito_otro = @proposito_otro
		@interconsulta.prestador_destino_texto = @prestador_destino_texto
		@interconsulta.save
	
	  @agendamiento = AgAgendamientos.find(params[:ag])

		p_d = FiPersonaDiagnosticos
  	.joins(:persona_diagnosticos_atencion_salud)
  	.select("fi_persona_diagnosticos_atenciones_salud.id,
  					fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
  					fi_persona_diagnosticos_atenciones_salud.fecha_termino,
  					fi_persona_diagnosticos.diagnostico_id,
  					fi_persona_diagnosticos.persona_id,
  					fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
  					fi_persona_diagnosticos_atenciones_salud.comentario,
  					fi_persona_diagnosticos_atenciones_salud.es_cronica,
  					fi_persona_diagnosticos_atenciones_salud.en_tratamiento")
  	.where('fi_persona_diagnosticos_atenciones_salud.id' => params[:id]).first

  	@persona_prestacion = FiPersonaPrestacionDiagnosticos.where('persona_diagnostico_atencion_salud_id = ? AND para_interconsulta is true',params[:id])

	  @estados_diagnostico = MedDiagnosticoEstados.all

	  nombre = l DateTime.current, format: :timestamp
	  nombre.to_s << ' Interconsulta ' << p_d.persona.showName('%n%p%m') << p_d.diagnostico.nombre 

		respond_to do |format|
			format.pdf do
          render :pdf => nombre,
                 :template => "persona_diagnostico/interconsulta.pdf.erb", :locals => {:p_d => p_d, :e_d => @estados_diagnostico, :agendamiento => @agendamiento, :persona => @persona, :interconsulta => @interconsulta } ,
                 :disposition => 'attachment',
                 :encoding => "utf8"      
 					 end               
		end

	end	

	def descargarConstanciaGes 
	
		@notificacion_ges = FiNotificacionesGes.where('persona_diagnostico_atencion_salud_id = ? and fecha_notificacion is null ',params[:id]).first
		
		@persona = nil
		borrar = false

		if (!@notificacion_ges)
			@notificacion_ges = FiNotificacionesGes.where('persona_diagnostico_atencion_salud_id = ? ',params[:id]).order('fecha_notificacion DESC').first
		else
			borrar = true	
		end	

		if @notificacion_ges
			@persona = @notificacion_ges.persona_conocimiento
			if borrar
				@notificacion_ges.destroy
			end	
		end	

		@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.where("id = ?",params[:id]).first

		@confirmacion_diagnostica = nil
		if @persona_diagnostico_atencion.estado_diagnostico.nombre == "Confirmado" 
			@confirmacion_diagnostica = @persona_diagnostico_atencion.en_tratamiento ? "tratamiento" : "confirmacion"
		end

		@notificacion_ges = FiNotificacionesGes.new
		@notificacion_ges.persona_diagnostico_atencion_salud_id = params[:id]
		@notificacion_ges.persona_conocimiento = @persona 
		@notificacion_ges.confirmacion_diagnostica = @confirmacion_diagnostica   
		@notificacion_ges.fecha_notificacion = DateTime.current
		@notificacion_ges.save

	  @agendamiento = AgAgendamientos.find(params[:ag])

		p_d = FiPersonaDiagnosticos
  	.joins(:persona_diagnosticos_atencion_salud)
  	.select("fi_persona_diagnosticos_atenciones_salud.id,
  					fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
  					fi_persona_diagnosticos_atenciones_salud.fecha_termino,
  					fi_persona_diagnosticos.diagnostico_id,
  					fi_persona_diagnosticos.persona_id,
  					fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
  					fi_persona_diagnosticos_atenciones_salud.comentario,
  					fi_persona_diagnosticos_atenciones_salud.es_cronica,
  					fi_persona_diagnosticos_atenciones_salud.en_tratamiento")
  	.where('fi_persona_diagnosticos_atenciones_salud.id' => params[:id]).first

	  @estados_diagnostico = MedDiagnosticoEstados.all

	  nombre = l DateTime.current, format: :timestamp
	  nombre.to_s << ' Constancia GES' << p_d.persona.showName('%n%p%m') << p_d.diagnostico.nombre 

		respond_to do |format|
			format.pdf do
          render :pdf => nombre,
                 :template => "persona_diagnostico/constancia_ges.pdf.erb", :locals => {:p_d => p_d, :e_d => @estados_diagnostico, :agendamiento => @agendamiento, :persona => @persona } ,
                 :disposition => 'attachment',
                 :encoding => "utf8" ,
                 :page => 2         
 					 end               
		end

	end	

	def agregarPresInt
		@persona_prestacion = FiPersonaPrestacionDiagnosticos.where('persona_diagnostico_atencion_salud_id = ?',params[:p_d])
	  @p_d = 	params[:p_d]
	  @tipo = params[:tipo]
	  @tipo_diag = params[:tipo_diag]
	  
		respond_to do |format|     
    	format.js   {}
    	format.json { render :json => { :success => true } }
    end	
	end

end