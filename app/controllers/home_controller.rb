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
  		if (act.estado.id == 5)
  			llegadas << act.format
  		end
  	end	
									
		respond_to do |format|     
    	format.json { render :json => { :success => true, :respuesta => respuesta, :llegadas => llegadas} }
    end						

	end	

	def index		
		if user_signed_in?
			if esAdministrativo
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
					.where('ag.estado_id = 7 AND pbap.id is null AND ppp.prestador_id = ? ',getIdPrestador('administrativo'))
					.order('fecha_comienzo asc')

				@lista_profesionales_para_boleta = @atenciones_salud_para_boleta.map {|atencion| atencion.profesional_id }
				@profesionales_para_boleta = PerPersonas.where("id IN (?)",@lista_profesionales_para_boleta)
				@fecha_minima = @atenciones_salud_para_boleta.select('min(fecha_comienzo)').first
				
				@boletas = PreBoletas.joins(:especialidad_prestador_profesional)
														 .select('pre_boletas.*,profesional_id')
														 .where('pre_prestador_profesionales.prestador_id = ?',getIdPrestador('administrativo'))
				@lista_profesionales_con_boleta = @boletas.map {|boleta| boleta.profesional_id }
				@profesionales_con_boleta = PerPersonas.where("id IN (?)",@lista_profesionales_con_boleta)
				@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
				@acciones_masivas = AgAccionMasiva.where('responsable_id = ?',@usuario.id).limit(20)

				@presupuestos = FdPresupuestos.joins(:atencion_salud => :agendamiento )


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
					.where('ppp.id = ? AND ag.estado_id = 7 AND pbap.id is null',@especialidad_prestador_profesional.id)
					.order('fecha_comienzo asc')

				@boletas_profesional = PreBoletas.joins(:especialidad_prestador_profesional)
														 .select('pre_boletas.*,profesional_id')
														 .where('pre_prestador_profesionales.id = ?',@especialidad_prestador_profesional.id)	

  			render 'index_profesional'

		  else
				@acceso_especialista = false		
				@acceso = true
				@persona = PerPersonas.where('user_id = ?',current_user.id).first	

				#Inicio
				@horas_agendadas = AgAgendamientos.where("(persona_id = ? OR quien_pide_hora_id = ?) AND estado_id in (2,3,4,5,6,8,9) ",@persona.id,@persona.id)
				@atenciones_realizadas = FiAtencionesSalud
					.joins('JOIN ag_agendamientos AS ag ON fi_atenciones_salud.agendamiento_id = ag.id')
					.where('(fi_atenciones_salud.persona_id = ? OR ag.quien_pide_hora_id = ?) AND ag.estado_id in (7,10)',@persona.id,@persona.id)
	
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
				@persona_alergias_personales = FiPersonasAlergias.where('persona_id = ? ',@persona.id)
				@alergias_personales = @persona_alergias_personales.map { |persona_alergias_personal| persona_alergias_personal.alergia.id unless persona_alergias_personal.alergia.comun  } 
				@alergias = MedAlergias.where('comun is true or id IN (?)',@alergias_personales).order(nombre: :asc)
				#Alcohol
				@test_audit = FiHabitosAlcohol.where('persona_id = ?', @persona.id)
				@habito_alcohol_resumen = FiHabitosAlcoholResumen.where('persona_id = ?',@persona.id).first
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

				@persona_actividad_fisica_resumen = FiPersonaActividadFisicaResumen.where('persona_id = ?',@persona.id).first

				#Vacunas
				@personas_vacunas = FiPersonasVacunas.joins('JOIN fi_calendario_vacunas AS fcv ON fi_personas_vacunas.vacuna_id = fcv.vacuna_id AND (fi_personas_vacunas.numero_vacuna = fcv.numero_vacuna OR (fi_personas_vacunas.numero_vacuna is null and fcv.numero_vacuna is null  ))')
																						 .select('fi_personas_vacunas.id,fi_personas_vacunas.vacuna_id,fcv.edad,fi_personas_vacunas.fecha,fi_personas_vacunas.atencion_salud_id')	
																						 .where('persona_id = ?',@persona.id)
				@personas_vacunas_otras = FiPersonasVacunas.joins('JOIN med_vacunas AS mv ON fi_personas_vacunas.vacuna_id = mv.id')
																						 .select('fi_personas_vacunas.id,fi_personas_vacunas.vacuna_id,mv.tipo as edad,fi_personas_vacunas.fecha,fi_personas_vacunas.atencion_salud_id')	
																						 .where('persona_id = ? AND mv.tipo != ?',@persona.id,'pni')

				@grupo_etareo = @persona.getGrupoEtareo(DateTime.current)
				@agno = FiCalendarioVacunas.maximum('agno')	
				@array_grupo = []													
				case @grupo_etareo
		    when 'Recién nacido','Lactante'
		    	@partial_seguimiento = 'vacunas/lactante'
					@array_grupo = ["Recién nacido","2 meses","4 meses","6 meses","12 meses","18 meses"]
		    when 'Pediatria' 
		      @partial_seguimiento = 'vacunas/pediatria'
		      @array_grupo = ["1° básico","4° básico","8° básico"]
		    when 'Adolescente','Adulto' 
		    when 'Adulto mayor'
		    	@partial_seguimiento = 'vacunas/adulto_mayor'
					@array_grupo = ["Adulto de 65 años"]
		    end	

		    @calendario_vacunas_persona = FiCalendarioVacunas.where('edad in (?) AND agno = ? ',@array_grupo,@agno).order(id: :asc)

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

				@otras_vacunas = MedVacunas.where('tipo != ?','pni')	

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
