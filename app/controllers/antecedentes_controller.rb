class AntecedentesController < ApplicationController
	def index
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
	end
	def edit
		@acceso_especialista = true
		@acceso = true
		@agendamiento = AgAgendamientos.find(params[:id])
		@acceso = false if  @agendamiento.especialidad_prestador_profesional.profesional.id != current_user.id
		@paciente = @agendamiento.persona 
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
	end	
	def editarAlergia
		@paciente = PerPersonas.find(current_user.id)
		case params[:estado]
		when 'true'			
			@alergia = MedAlergias.find(params[:alergia])
			@persona_alergia = FiPersonasAlergias.new
			@persona_alergia.persona = @paciente
			@persona_alergia.alergia = @alergia
			@persona_alergia.save!
		when 'false'	
			@persona_alergia = FiPersonasAlergias.where('persona_id = ? and alergia_id = ?',@paciente.id,params[:alergia]).first
			@persona_alergia.destroy
		end	
			
		respond_to do |format|
			format.json { render :json => { :success => true } }
		end	
	end
	def guardarAntecedentesSociales
		@persona = PerPersonas.find(current_user.id)
		@persona.numero_personas_familia = params[:grupo_familiar]
		@persona.nivel_escolaridad = params[:nivel_escolaridad]
		@persona.save!

		respond_to do |format|
			format.json { render :json => { :success => true } }
		end		
	end

	def guardarActividadFisica
		@persona_actividad_fisica = FiPersonaActividadFisica.where('persona_id = ?',current_user.id).first	
		@persona_actividad_fisica = FiPersonaActividadFisica.new unless @persona_actividad_fisica
		@persona = PerPersonas.find(current_user.id)
		@persona_actividad_fisica.persona = @persona
		case params[:pregunta]
		when '1' then @persona_actividad_fisica.P1 = params[:valor]
		when '2' then @persona_actividad_fisica.P2 = params[:valor]
		when '3' then @persona_actividad_fisica.P3 = params[:valor]
		when '4' then @persona_actividad_fisica.P4 = params[:valor]
		when '5' then @persona_actividad_fisica.P5 = params[:valor]
		when '6' then @persona_actividad_fisica.P6 = params[:valor]
		when '7' then @persona_actividad_fisica.P7 = params[:valor]
		when '8' then @persona_actividad_fisica.P8 = params[:valor]
		when '9' then @persona_actividad_fisica.P9 = params[:valor]
		when '10' then @persona_actividad_fisica.P10 = params[:valor]
		when '11' then @persona_actividad_fisica.P11 = params[:valor]
		when '12' then @persona_actividad_fisica.P12 = params[:valor]
		when '13' then @persona_actividad_fisica.P13 = params[:valor]
		when '14' then @persona_actividad_fisica.P14 = params[:valor]    
		when '15' then @persona_actividad_fisica.P15	= params[:valor]		
		end
		@persona_actividad_fisica.save!

		respond_to do |format|
			format.json { render :json => { :success => true } }
		end		
	end	

end
