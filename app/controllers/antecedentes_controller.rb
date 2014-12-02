class AntecedentesController < ApplicationController
	def index		
		@acceso = true
		@paciente = PerPersonas.find(current_user.id)		
		id_usuario = current_user.id
		if params[:p_i] and params[:a_i] #Vista de profesional: si existe este parametro se verifica que el profesional coincida con la cuenta del usuario
			@agendamiento = AgAgendamientos.find(params[:a_i])
			@acceso_ant_med = false if  @agendamiento.especialidad_prestador_profesional.profesional.id != current_user.id
			id_usuario = params[:p_i]
			@paciente = @agendamiento.persona 
		end
		#Antecedentes médicos		
		@persona_diagnosticos = FiPersonaDiagnosticosAtencionesSalud.joins('JOIN fi_persona_diagnosticos AS fpd ON fi_persona_diagnosticos_atenciones_salud.persona_diagnostico_id = fpd.id
																																				JOIN med_diagnosticos AS md ON fpd.diagnostico_id = md.id')
																																.select('fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,fi_persona_diagnosticos_atenciones_salud.atencion_salud_id,fi_persona_diagnosticos_atenciones_salud.fecha_inicio,fi_persona_diagnosticos_atenciones_salud.fecha_termino,md.nombre')
																																.where('fpd.persona_id = ?',id_usuario) if @acceso
		#Antecedentes quirúrgicos													
		min = 57
		max = 250	
		@persona_prestaciones = FiPersonaPrestaciones.joins(:prestacion).where('persona_id = ? AND subgrupo_id BETWEEN ? and ?',id_usuario,min,max) if @acceso
		#Medicamentos	
		@persona_medicamentos = FiPersonaMedicamentos.where('persona_id = ? ',id_usuario) if @acceso
		#Alergias
		@alergias = MedAlergias.joins('LEFT JOIN fi_personas_alergias as fpa ON med_alergias.id = fpa.alergia_id')
													 .select('med_alergias.id, med_alergias.nombre, fpa.persona_id')
													 .where('persona_id = ? or persona_id is null',current_user.id)
		#Alcohol
		@test_audit = FiHabitosAlcohol.where('persona_id = ?', current_user.id)
		#Tabaco
		@total_consumo = 0
		@consumo = FiHabitosTabaco.where('persona_id = ?', current_user.id)
		@consumo.each do |con|
  		@total_consumo += con.paquetes_agno
  	end	
  	#ocupaciones
  	@ocupaciones = OcuPersonasOcupaciones.where('persona_id = ?',current_user.id);
  	#antecedentes familiares
  	@decesos = @paciente.getAntecedentesDecesos(id_usuario)
  	@ant_enf_cro = @paciente.getAntecedentesEnfermedadesCronicas(id_usuario)
  	#Actividad física
  	@habitos_actividad_fisica = PerPersonas.all
  	@alert_actividad_fisica = 'warning'
  	@texto_actividad_fisica = 'texto_actividad_fisica'
	end
	def editarAlergia
		persona_id = current_user.id
		case params[:estado]
		when 'true'
			@persona = PerPersonas.find(persona_id)
			@alergia = MedAlergias.find(params[:alergia])
			@persona_alergia = FiPersonasAlergias.new
			@persona_alergia.persona = @persona
			@persona_alergia.alergia = @alergia
			@persona_alergia.save!
		when 'false'	
			@persona_alergia = FiPersonasAlergias.where('persona_id = ? and alergia_id = ?',persona_id,params[:alergia]).first
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
