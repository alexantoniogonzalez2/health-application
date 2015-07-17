class HomeController < ApplicationController

	include ApplicationHelper

	def actualizarAtenciones

		@profesional = PerPersonas.where('user_id = ?',current_user.id).first	
		@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",@profesional.id).first
		@agendamientos= AgAgendamientos.where( "especialidad_prestador_profesional_id = ? AND fecha_comienzo BETWEEN ? AND ? ", @especialidad_prestador_profesional, Date.today, Date.tomorrow )
		@actualizaciones = AgAgendamientoLogEstados
			.joins(:agendamiento)
			.select("ag_agendamientos.fecha_comienzo,
							 ag_agendamiento_log_estados.fecha,
							 ag_agendamiento_log_estados.agendamiento_estado_id,
							 ag_agendamiento_log_estados.responsable_id,
							 ag_agendamientos.persona_id")
			.where( "fecha > ? AND ag_agendamientos.especialidad_prestador_profesional_id = ? AND ag_agendamientos.fecha_comienzo BETWEEN ? AND ? ",
				 Date.today,@especialidad_prestador_profesional,Date.today, Date.tomorrow )
			.order(fecha: :desc)

		@hora_actual = DateTime.current	

		respond_to do |format|     
    	format.js   {}
    	format.json { render :json => { :success => true, :agendamientos => @agendamientos, :actualizaciones => @actualizaciones, :hora_actual => @hora_actual }	 }
    end
	end	

	def revisarActualizaciones

		llegadas = []
		lapso_tiempo = DateTime.current - 30.seconds
		@profesional = PerPersonas.where('user_id = ?',current_user.id).first	
		especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",@profesional.id).first
		#agendamientos= AgAgendamientos.where( "especialidad_prestdor_profesional_id = ? AND fecha_comienzo BETWEEN ? AND ? ", @especialidad_prestador_profesional, Date.today, Date.tomorrow )

		actualizaciones = AgAgendamientos
			.joins(:agendamiento_log_estados)
			.where( "fecha > ? AND especialidad_prestador_profesional_id = ? AND fecha_comienzo BETWEEN ? AND ? ",
				lapso_tiempo, especialidad_prestador_profesional,Date.today, Date.tomorrow )

	 	respuesta = false
  	actualizaciones.each do |act|
  		respuesta = true
  		if (act.agendamiento_estado.id == 5)
  			llegadas << act.format
  		end
  	end	
									
		respond_to do |format|     
    	format.json { render :json => { :success => true, :respuesta => respuesta, :llegadas => llegadas} }
    end						

	end	

	def index

		
		if user_signed_in?
			if tieneRol('Generar agendamientos') or tieneRol('Confirmar agendamientos') or tieneRol('Recibir pacientes') or tieneRol('Bloquear horas') or tieneRol('Generar estadísticas') or tieneRol('Tomar horas')
				@profesionales = PerPersonas.where("id IN (SELECT profesional_id FROM pre_prestador_profesionales WHERE prestador_id = ? )",getIdPrestador('administrativo'))	
		  	@especialidades= ProEspecialidades.where("id IN (SELECT especialidad_id FROM pre_prestador_profesionales WHERE prestador_id= ? )",getIdPrestador('administrativo'))	
		  	@atenciones_salud_para_boleta = FiAtencionesSalud
					.joins('JOIN ag_agendamientos AS ag
								  ON fi_atenciones_salud.agendamiento_id = ag.id
								  JOIN pre_prestador_profesionales as ppp
								  ON ag.especialidad_prestador_profesional_id = ppp.id
								  JOIN pre_atenciones_pagadas as pap
								  ON ag.id = pap.agendamiento_id
								  LEFT JOIN pre_boletas_atenciones_pagadas as pbap
								  ON pap.id = pbap.atencion_pagada_id')
					.select('fi_atenciones_salud.*,profesional_id,fecha_comienzo,pap.id as atencion_pagada')
					.where('ag.agendamiento_estado_id = 7 AND pbap.id is null AND ppp.prestador_id = ? ',getIdPrestador('administrativo'))
					.order('fecha_comienzo asc')

				@lista_profesionales_para_boleta = @atenciones_salud_para_boleta.map {|atencion| atencion.profesional_id }
				@profesionales_para_boleta = PerPersonas.where("id IN (?)",@lista_profesionales_para_boleta)

				@fecha_minima = @atenciones_salud_para_boleta.select('min(fecha_comienzo)').first


				render 'index_agendamiento'
		  elsif esProfesionalSalud 
		  	@profesional = PerPersonas.where('user_id = ?',current_user.id).first	
		  	@hora_actual = DateTime.current
				@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",@profesional.id).first
				@agendamientos= AgAgendamientos.where( "especialidad_prestador_profesional_id = ? AND fecha_comienzo BETWEEN ? AND ? ", @especialidad_prestador_profesional, Date.today, Date.tomorrow )
  			@actualizaciones = AgAgendamientoLogEstados
					.joins(:agendamiento)
					.select("ag_agendamientos.fecha_comienzo,
									 ag_agendamiento_log_estados.fecha,
									 ag_agendamiento_log_estados.agendamiento_estado_id,
									 ag_agendamiento_log_estados.responsable_id,
									 ag_agendamientos.persona_id")
					.where( "fecha > ? AND ag_agendamientos.especialidad_prestador_profesional_id = ? AND ag_agendamientos.fecha_comienzo BETWEEN ? AND ? ",
						 Date.today,@especialidad_prestador_profesional,Date.today, Date.tomorrow )
					.order(fecha: :desc)

				@pacientes_profesional = @profesional.misPacientes(@especialidad_prestador_profesional.id)

				@atenciones_salud = FiAtencionesSalud
					.joins('JOIN ag_agendamientos AS ag
								  ON fi_atenciones_salud.agendamiento_id = ag.id
								  JOIN pre_prestador_profesionales as ppp
								  ON ag.especialidad_prestador_profesional_id = ppp.id')
					.where('ppp.id = ?',@especialidad_prestador_profesional.id)
					.order('fecha_comienzo asc')
					.limit(100)

				@atenciones_salud_para_pago = FiAtencionesSalud
					.joins('JOIN ag_agendamientos AS ag
								  ON fi_atenciones_salud.agendamiento_id = ag.id
								  JOIN pre_prestador_profesionales as ppp
								  ON ag.especialidad_prestador_profesional_id = ppp.id
								  JOIN pre_atenciones_pagadas as pap
								  ON ag.id = pap.agendamiento_id
								  LEFT JOIN pre_boletas_atenciones_pagadas as pbap
								  ON pap.id = pbap.atencion_pagada_id')
					.where('ppp.id = ? AND ag.agendamiento_estado_id = 7 AND pbap.id is null',@especialidad_prestador_profesional.id)
					.order('fecha_comienzo asc')

				#@atenciones_salud = @query.where('fecha_comienzo > ?', 1.week.ago)
				#@atenciones_salud = @query.where('fecha_comienzo > ?', 1.week.ago) if @atenciones_salud.blank?					
  			render 'index_profesional'

		  else
				@acceso_especialista = false		
				@acceso = true
				@persona = PerPersonas.where('user_id = ?',current_user.id).first		
				#Antecedentes médicos		
				@persona_diagnosticos = FiPersonaDiagnosticosAtencionesSalud.joins('JOIN fi_persona_diagnosticos AS fpd ON fi_persona_diagnosticos_atenciones_salud.persona_diagnostico_id = fpd.id
																																						JOIN med_diagnosticos AS md ON fpd.diagnostico_id = md.id')
																																		.select('fi_persona_diagnosticos_atenciones_salud.id,
																																						 fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
																																						 fi_persona_diagnosticos_atenciones_salud.atencion_salud_id,
																																						 fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
																																						 fi_persona_diagnosticos_atenciones_salud.fecha_termino,
																																						 fi_persona_diagnosticos_atenciones_salud.comentario,
																																						 fi_persona_diagnosticos_atenciones_salud.created_at,
																																						 fi_persona_diagnosticos_atenciones_salud.es_antecedente,																																						 
																																						 fi_persona_diagnosticos_atenciones_salud.es_cronica,	
																																						 md.nombre,																																					 
																																						 fpd.persona_id')
																																		.where('fpd.persona_id = ?',@persona.id) if @acceso
				@estados_diagnostico = MedDiagnosticoEstados.all																														
				#Antecedentes quirúrgicos													
				min = 57
				max = 250	
				@persona_prestaciones = FiPersonaPrestaciones.joins(:prestacion).where('persona_id = ? AND subgrupo_id BETWEEN ? and ?',@persona.id,min,max) if @acceso
				#Medicamentos	
				@persona_medicamentos = FiPersonaMedicamentos.where('persona_id = ? ',@persona.id) if @acceso
				#Alergias
				@alergias = MedAlergias.joins('LEFT JOIN fi_personas_alergias as fpa ON med_alergias.id = fpa.alergia_id')
															 .select('med_alergias.id, med_alergias.nombre, fpa.persona_id')
															 .where('persona_id = ? or ( persona_id is null AND med_alergias.comun is true )',@persona.id)
															 .order('med_alergias.nombre ASC')
				#Alcohol
				@test_audit = FiHabitosAlcohol.where('persona_id = ?', @persona.id)
				#Tabaco
				@total_consumo = 0
				@consumo = FiHabitosTabaco.where('persona_id = ?', @persona.id)
				@consumo.each do |con|
		  		@total_consumo += con.paquetes_agno
		  	end	
		  	#ocupaciones
		  	@ocupaciones = OcuPersonasOcupaciones.where('persona_id = ?',@persona.id);
		  	#antecedentes familiares
		  	@decesos = @persona.getAntecedentesDecesos
		  	@ant_enf_cro = @persona.getAntecedentesEnfermedadesCronicas
		  	#Actividad física
		  	@persona_actividad_fisica = FiPersonaActividadFisica.where('persona_id = ?',@persona.id).first
		  	if @persona_actividad_fisica.nil?
		  		@persona_actividad_fisica = FiPersonaActividadFisica.new 
					@persona = PerPersonas.find(@persona.id)
					@persona_actividad_fisica.persona = @persona
					@persona_actividad_fisica.nivel_actividad = "Sin información"
					@persona_actividad_fisica.save!
				end
				@segmento_actividad = @persona.getSegmentoActividadFisica
				@edad_act_fis = @persona.age()
				@edad_act_fis = "sin_info" if @edad_act_fis == "Sin información"

				#Vacunas
				@personas_vacunas = FiPersonasVacunas.joins('JOIN fi_calendario_vacunas AS fcv ON fi_personas_vacunas.vacuna_id = fcv.vacuna_id AND (fi_personas_vacunas.numero_vacuna = fcv.numero_vacuna OR (fi_personas_vacunas.numero_vacuna is null and fcv.numero_vacuna is null  ))')
																						 .select('fi_personas_vacunas.id,fi_personas_vacunas.vacuna_id,fcv.edad,fi_personas_vacunas.fecha,fi_personas_vacunas.atencion_salud_id')	
																						 .where('persona_id = ?',@persona.id)
				@personas_vacunas_otras = FiPersonasVacunas.joins('JOIN med_vacunas AS mv ON fi_personas_vacunas.vacuna_id = mv.id')
																						 .select('fi_personas_vacunas.id,fi_personas_vacunas.vacuna_id,mv.tipo as edad,fi_personas_vacunas.fecha,fi_personas_vacunas.atencion_salud_id')	
																						 .where('persona_id = ? AND mv.tipo != ?',@persona.id,'pni')

				@grupo_etareo = @persona.getGrupoEtareo(DateTime.current)
				@agno = FiCalendarioVacunas.maximum('agno')												
				case @grupo_etareo
		    when 'Recién nacido','Lactante'
		    	@partial_seguimiento = 'vacunas/lactante'
    			@calendario_vacunas_persona = FiCalendarioVacunas.joins('LEFT JOIN fi_personas_vacunas AS fpv ON fi_calendario_vacunas.vacuna_id = fpv.vacuna_id AND (fi_calendario_vacunas.numero_vacuna = fpv.numero_vacuna OR (fi_calendario_vacunas.numero_vacuna is null and fpv.numero_vacuna is null  ))')
																.select('fi_calendario_vacunas.id,fi_calendario_vacunas.vacuna_id,fi_calendario_vacunas.edad,fpv.persona_id,fpv.fecha')
																.where('edad in ("Recién nacido","2 meses","4 meses","6 meses","12 meses","18 meses") AND agno = ? AND (persona_id = ? OR persona_id is null)',@agno,@persona.id)
																.order('fi_calendario_vacunas.id ASC')
		    when 'Pediatria' 
		      @partial_seguimiento = 'vacunas/pediatria'
      		@calendario_vacunas_persona = FiCalendarioVacunas.joins('LEFT JOIN fi_personas_vacunas AS fpv ON fi_calendario_vacunas.vacuna_id = fpv.vacuna_id AND (fi_calendario_vacunas.numero_vacuna = fpv.numero_vacuna OR (fi_calendario_vacunas.numero_vacuna is null and fpv.numero_vacuna is null  ))')
														.select('fi_calendario_vacunas.id,fi_calendario_vacunas.vacuna_id,fi_calendario_vacunas.edad,fpv.persona_id,fpv.fecha')
														.where('edad in ("1° básico","4° básico","8° básico") AND agno = ? AND (persona_id = ? OR persona_id is null)',@agno,@persona.id)
														.order('fi_calendario_vacunas.id ASC')
		    when 'Adolescente','Adulto' 
		    when 'Adulto mayor'
		    	@partial_seguimiento = 'vacunas/adulto_mayor'
    			@calendario_vacunas_persona = FiCalendarioVacunas.joins('LEFT JOIN fi_personas_vacunas AS fpv ON fi_calendario_vacunas.vacuna_id = fpv.vacuna_id AND (fi_calendario_vacunas.numero_vacuna = fpv.numero_vacuna OR (fi_calendario_vacunas.numero_vacuna is null and fpv.numero_vacuna is null  ))')
												.select('fi_calendario_vacunas.id,fi_calendario_vacunas.vacuna_id,fi_calendario_vacunas.edad,fpv.persona_id,fpv.fecha')
												.where('edad in ("Adulto de 65 años") AND agno = ? AND (persona_id = ? OR persona_id is null)',@agno,@persona.id)
												.order('fi_calendario_vacunas.id ASC')
		    end	
				@calendarios = {}

				#Calendario - Vacunas														 		
				@agnos = FiCalendarioVacunas.select('DISTINCT agno as agno')		
				@agnos.each do |agno|
					@calendarios[agno.agno] = {} 
					@calendario_vacunas = FiCalendarioVacunas.where('agno = ?',agno.agno)
					contador = -1
					@calendario_vacunas.each do |calendario_vacuna|
						contador = contador + 1
						@calendarios[agno.agno][contador] = {}
						@calendarios[agno.agno][contador]['id'] = calendario_vacuna.id				
						@calendarios[agno.agno][contador]['nombre'] = calendario_vacuna.vacuna.nombre
						@calendarios[agno.agno][contador]['edad'] = calendario_vacuna.edad
						@calendarios[agno.agno][contador]['numero_vacuna'] = calendario_vacuna.numero_vacuna
						@calendarios[agno.agno][contador]['protege_contra'] = calendario_vacuna.vacuna.protege_contra
					end	
				end

				@otras_vacunas = MedVacunas.joins('LEFT JOIN fi_personas_vacunas as fpv ON fpv.vacuna_id = med_vacunas.id')
																		.select('fpv.persona_id, med_vacunas.id,med_vacunas.nombre,med_vacunas.tipo')
																		.where('tipo != ? AND (persona_id = ? OR persona_id is null)','pni',@persona.id)	

				#Buscador hora															 
				@profesionales=PerPersonas.where("id in (select profesional_id from pre_prestador_profesionales)").order('nombre,apellido_paterno,apellido_materno')
				@especialidades=ProEspecialidades.where("id in (select especialidad_id from pre_prestador_profesionales)").order('nombre')
				@prestadores=PrePrestadores.where("id in (select prestador_id from pre_prestador_profesionales)").order('nombre')	
		  	@familiares = @persona.getCercanos

		  	render 'index_persona' 
		  end 	
		else
			render 'index', :layout => false
		end 	
		
	end

	def enviarCorreoContacto
		AppMailer.contact_email(params[:nombre],params[:correo],params[:telefono],params[:mensaje]).deliver_now
		respond_to do |format|
			format.html { render 'app_mailer/contact_email'}
			format.json { render :json => { :success => true } }	
		end	
	end
end
