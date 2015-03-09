class HomeController < ApplicationController

	include ApplicationHelper

	def actualizarAtenciones

		@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",current_user.id).first
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
		especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",current_user.id).first
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
			if tieneRol('Generar agendamientos')
				render 'index_agendamiento'
		  elsif esProfesionalSalud 
		  	@hora_actual = DateTime.current
				@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",current_user.id).first
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

				@atenciones_salud = FiAtencionesSalud
					.joins('JOIN ag_agendamientos AS ag
								  ON fi_atenciones_salud.agendamiento_id = ag.id
								  JOIN pre_prestador_profesionales as ppp
								  ON ag.especialidad_prestador_profesional_id = ppp.id')
					.where('ppp.profesional_id = ?',current_user.id)
					
  			render 'index_profesional'
		  else
				@acceso_especialista = false		
				@acceso = true
				@paciente = PerPersonas.where('user_id = ?',current_user.id).first		
				#Antecedentes médicos		
				@persona_diagnosticos = FiPersonaDiagnosticosAtencionesSalud.joins('JOIN fi_persona_diagnosticos AS fpd ON fi_persona_diagnosticos_atenciones_salud.persona_diagnostico_id = fpd.id
																																						JOIN med_diagnosticos AS md ON fpd.diagnostico_id = md.id')
																																		.select('fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,fi_persona_diagnosticos_atenciones_salud.atencion_salud_id,fi_persona_diagnosticos_atenciones_salud.fecha_inicio,fi_persona_diagnosticos_atenciones_salud.fecha_termino,md.nombre')
																																		.where('fpd.persona_id = ?',@paciente.id) if @acceso
				#Antecedentes quirúrgicos													
				min = 57
				max = 250	
				@persona_prestaciones = FiPersonaPrestaciones.joins(:prestacion).where('persona_id = ? AND subgrupo_id BETWEEN ? and ?',@paciente.id,min,max) if @acceso
				#Medicamentos	
				@persona_medicamentos = FiPersonaMedicamentos.where('persona_id = ? ',@paciente.id) if @acceso
				#Alergias
				@alergias = MedAlergias.joins('LEFT JOIN fi_personas_alergias as fpa ON med_alergias.id = fpa.alergia_id')
															 .select('med_alergias.id, med_alergias.nombre, fpa.persona_id')
															 .where('persona_id = ? or persona_id is null',@paciente.id)
				#Alcohol
				@test_audit = FiHabitosAlcohol.where('persona_id = ?', @paciente.id)
				#Tabaco
				@total_consumo = 0
				@consumo = FiHabitosTabaco.where('persona_id = ?', @paciente.id)
				@consumo.each do |con|
		  		@total_consumo += con.paquetes_agno
		  	end	
		  	#ocupaciones
		  	@ocupaciones = OcuPersonasOcupaciones.where('persona_id = ?',@paciente.id);
		  	#antecedentes familiares
		  	@decesos = @paciente.getAntecedentesDecesos(@paciente.id)
		  	@ant_enf_cro = @paciente.getAntecedentesEnfermedadesCronicas(@paciente.id)
		  	#Actividad física
		  	@persona_actividad_fisica = FiPersonaActividadFisica.where('persona_id = ?',@paciente.id).first
		  	if @persona_actividad_fisica.nil?
		  		@persona_actividad_fisica = FiPersonaActividadFisica.new 
					@persona = PerPersonas.find(@paciente.id)
					@persona_actividad_fisica.persona = @persona
					@persona_actividad_fisica.save!
				end
				@segmento_actividad = @paciente.getSegmentoActividadFisica
				@edad_act_fis = @paciente.age()
				@edad_act_fis = "sin_info" if @edad_act_fis == "Sin información"
				#Vacunas
				@personas_vacunas = FiPersonasVacunas.joins('JOIN fi_calendario_vacunas AS fcv ON fi_personas_vacunas.vacuna_id = fcv.vacuna_id AND (fi_personas_vacunas.numero_vacuna = fcv.numero_vacuna OR (fi_personas_vacunas.numero_vacuna is null and fcv.numero_vacuna is null  ))')
																						 .select('fi_personas_vacunas.id,fi_personas_vacunas.vacuna_id,fcv.edad,fi_personas_vacunas.fecha,fi_personas_vacunas.atencion_salud_id')	
																						 .where('persona_id = ?',@paciente.id)	

				@profesionales=PerPersonas.where("id in (select profesional_id from pre_prestador_profesionales)").order('nombre,apellido_paterno,apellido_materno')
				@especialidades=ProEspecialidades.where("id in (select especialidad_id from pre_prestador_profesionales)").order('nombre')
				@prestadores=PrePrestadores.where("id in (select prestador_id from pre_prestador_profesionales)").order('nombre')	
		  	
		  	render 'index_persona'
		  end 	
		else
			render 'index', :layout => false
		end 	
		
	end
end
