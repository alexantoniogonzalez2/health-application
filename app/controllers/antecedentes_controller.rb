class AntecedentesController < ApplicationController
	
	def index
		@acceso_especialista = false		
		@acceso = true
		@paciente = PerPersonas.where('user_id = ?',current_user.id).first #se debería quitar esta variable
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
																																.where('fpd.persona_id = ?',@paciente.id) if @acceso
		@estados_diagnostico = MedDiagnosticoEstados.all
																																
		#Antecedentes quirúrgicos													
		min = 57
		max = 250	
		@persona_prestaciones = FiPersonaPrestaciones.joins(:prestacion).where('persona_id = ? AND subgrupo_id BETWEEN ? and ?',@paciente.id,min,max) if @acceso
		#Medicamentos	
		@persona_medicamentos = FiPersonaMedicamentos.where('persona_id = ? ',@paciente.id) if @acceso
		#Alergias
		@persona_alergias_personales = FiPersonasAlergias.where('persona_id = ? ',@persona.id)
		@alergias_personales = @persona_alergias_personales.map { |persona_alergias_personal| persona_alergias_personal.alergia.id unless persona_alergias_personal.alergia.comun } 
		@alergias = MedAlergias.where('comun is true or id IN (?)',@alergias_personales).order(nombre: :asc)
		#Alcohol
		@test_audit = FiHabitosAlcohol.where('persona_id = ?', @paciente.id)
		@habito_alcohol_resumen = FiHabitosAlcoholResumen.where('persona_id = ?',@paciente.id).first
		#Tabaco
		@total_consumo = 0
		@consumo = FiHabitosTabaco.where('persona_id = ?', @paciente.id)
		@consumo.each do |con|
  		@total_consumo += con.paquetes_agno
  	end	
  	#ocupaciones
  	@ocupaciones = OcuPersonasOcupaciones.where('persona_id = ?',@paciente.id);
  	#antecedentes familiares
  	@decesos = @paciente.getAntecedentesDecesos
  	@ant_enf_cro = @paciente.getAntecedentesEnfermedadesCronicas
  	#Actividad física
  	@persona_actividad_fisica = FiPersonaActividadFisica.where('persona_id = ?',@paciente.id).first
  	if @persona_actividad_fisica.nil?
  		@persona_actividad_fisica = FiPersonaActividadFisica.new 
			@persona = PerPersonas.find(@paciente.id)
			@persona_actividad_fisica.persona = @persona			
			@persona_actividad_fisica.nivel_actividad = "Sin información"
			@persona_actividad_fisica.save!
		end
		@segmento_actividad = @paciente.getSegmentoActividadFisica
		@edad_act_fis = @paciente.age()
		@edad_act_fis = "sin_info" if @edad_act_fis == "Sin información"

		@persona_actividad_fisica_resumen = FiPersonaActividadFisicaResumen.where('persona_id = ?',@paciente.id).first

		#Vacunas
		@personas_vacunas = FiPersonasVacunas.joins('JOIN fi_calendario_vacunas AS fcv ON fi_personas_vacunas.vacuna_id = fcv.vacuna_id AND (fi_personas_vacunas.numero_vacuna = fcv.numero_vacuna OR (fi_personas_vacunas.numero_vacuna is null and fcv.numero_vacuna is null  ))')
																				 .select('fi_personas_vacunas.id,fi_personas_vacunas.vacuna_id,fcv.edad,fi_personas_vacunas.fecha,fi_personas_vacunas.atencion_salud_id')	
																				 .where('persona_id = ?',@paciente.id)
		@personas_vacunas_otras = FiPersonasVacunas.joins('JOIN med_vacunas AS mv ON fi_personas_vacunas.vacuna_id = mv.id')
																						 .select('fi_personas_vacunas.id,fi_personas_vacunas.vacuna_id,mv.tipo as edad,fi_personas_vacunas.fecha,fi_personas_vacunas.atencion_salud_id')	
																						 .where('persona_id = ? AND mv.tipo != ?',@paciente.id,'pni')
		@grupo_etareo = @paciente.getGrupoEtareo(DateTime.current)
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
  	@familiares = @paciente.getCercanos	

	end

	def editarAlergia
		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first 
		else 
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
		end	

		case params[:estado]
		when 'true'			
			@alergia = MedAlergias.find(params[:alergia])
			@persona_alergia = FiPersonasAlergias.new
			@persona_alergia.persona = @persona
			@persona_alergia.alergia = @alergia
			@persona_alergia.save!
		when 'false'	
			@persona_alergia = FiPersonasAlergias.where('persona_id = ? and alergia_id = ?',@persona.id,params[:alergia]).first
			@persona_alergia.destroy
		end	
			
		respond_to do |format|
			format.json { render :json => { :success => true } }
		end	
	end

	def guardarAntecedentesSociales
		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first 
		else 
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
		end
		@persona.numero_personas_familia = params[:grupo_familiar]
		@persona.nivel_escolaridad = params[:nivel_escolaridad]
		@persona.save!

		respond_to do |format|
			format.json { render :json => { :success => true } }
		end		
	end

	def guardarActividadFisica
		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first 
		else 
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
		end
		@persona_actividad_fisica = FiPersonaActividadFisica.where('persona_id = ?',@persona.id).first	
		@persona_actividad_fisica = FiPersonaActividadFisica.new unless @persona_actividad_fisica
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
		when 'nivel_actividad' then @persona_actividad_fisica.nivel_actividad	= params[:valor]		
		end
		@persona_actividad_fisica.save!

		respond_to do |format|
			format.json { render :json => { :success => true } }
		end		
	end

	def guardarActividadFisicaResumen
		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first 
		else 
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
		end
		@persona_actividad_fisica_resumen = FiPersonaActividadFisicaResumen.where('persona_id = ?',@persona.id).first	
		@persona_actividad_fisica_resumen = FiPersonaActividadFisicaResumen.new unless @persona_actividad_fisica_resumen
		@persona_actividad_fisica_resumen.persona = @persona

		case params[:campo]
		when 'fre' then @persona_actividad_fisica_resumen.frecuencia = params[:valor]
		when 'tie' then @persona_actividad_fisica_resumen.tiempo = params[:valor]
		when 'int' then @persona_actividad_fisica_resumen.intensidad = params[:valor]	
		end
		@persona_actividad_fisica_resumen.save!

		respond_to do |format|
			format.json { render :json => { :success => true } }
		end	

	end	

	def cargarAntecedentes

		@ant = params[:ant]
		@tipo = params[:tipo]
		@acceso = false
		@atencion_salud = FiAtencionesSalud.find(params[:at_sal])
		@agendamiento = @atencion_salud.agendamiento
		@persona = PerPersonas.find(params[:persona_id])
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first
		if @atencion_salud.agendamiento.especialidad_prestador_profesional.profesional.id == @usuario.id or @usuario == @atencion_salud.persona 
			@acceso = true 
		end	

		case params[:ant]
		when 'med'
			@persona_medicamentos = FiPersonaMedicamentos.where('persona_id = ? AND ( atencion_salud_id != ? OR es_antecedente is not null )',@persona.id, params[:at_sal]).order('created_at')
			@partial = 'antecedentes/medicamentos'			
		when 'ale'
			@persona_alergias_personales = FiPersonasAlergias.where('persona_id = ? ',@persona.id)
			@alergias_personales = @persona_alergias_personales.map { |persona_alergias_personal| persona_alergias_personal.alergia.id unless persona_alergias_personal.alergia.comun } 
			@alergias = MedAlergias.where('comun is true OR id IN (?)',@alergias_personales).order(nombre: :asc)
			@partial = 'antecedentes/alergias'
		when 'vac'				
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
  			@array_grupo = [ "Recién nacido","2 meses","4 meses","6 meses","12 meses","18 meses" ]
	    when 'Pediatria' 
	      @partial_seguimiento = 'vacunas/pediatria'
    		@array_grupo = [ "1° básico","4° básico","8° básico" ]
	    when 'Adolescente','Adulto' 
	    when 'Adulto mayor'
	    	@partial_seguimiento = 'vacunas/adulto_mayor'
  			@array_grupo = [ "Adulto de 65 años" ]
	    end	

  		@calendario_vacunas_persona = FiCalendarioVacunas.where('edad in (?) AND agno = ? ',@array_grupo,@agno).order(id: :asc)			

			#Calendario - Vacunas														 		
			@agnos = FiCalendarioVacunas.select('DISTINCT agno as agno')		
			@calendarios = {}
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
			@partial = 'vacunas/index'
		when 'ant_qui'
			@prestadores = PrePrestadores.all		
			@persona_prestaciones = FiPersonaPrestaciones.where('persona_id = ? AND ( atencion_salud_id != ? OR es_antecedente is not null )',@persona.id, params[:at_sal]).order('created_at')
			@partial = 'antecedentes/antecedentes_quirurgicos'
		when 'act_fis'
			#Actividad física
	  	@persona_actividad_fisica = FiPersonaActividadFisica.where('persona_id = ?',@persona.id).first
	  	if @persona_actividad_fisica.nil?
	  		@persona_actividad_fisica = FiPersonaActividadFisica.new 
				@persona_actividad_fisica.persona = @persona
				@persona_actividad_fisica.save!
			end
			@segmento_actividad = @persona.getSegmentoActividadFisica
			@edad_act_fis = @persona.age()
			@edad_act_fis = "sin_info" if @edad_act_fis == "Sin información"
			@partial = 'antecedentes/actividad_fisica'
			@persona_actividad_fisica_resumen = FiPersonaActividadFisicaResumen.where('persona_id = ?',@persona.id).first
		when 'hab_alc'
			@test_audit = FiHabitosAlcohol.where('persona_id = ?', @persona.id )
			@habito_alcohol_resumen = FiHabitosAlcoholResumen.where('persona_id = ?',@persona.id).first
			@partial = 'habitos_alcohol/index'
		when 'hab_tab'
  		@total_consumo = 0
			@consumo = FiHabitosTabaco.where('persona_id = ?', @persona.id )
			@consumo.each do |con|
	  		@total_consumo += con.paquetes_agno
	  	end		
			@partial = 'habitos_tabaco/index'
		when 'ant_gin'
			@partial = 'antecedentes/antecedentes_ginecologicos'
		when 'ant_fam'
			@decesos = @persona.getAntecedentesDecesos
  		@ant_enf_cro = @persona.getAntecedentesEnfermedadesCronicas
  		@estados_diagnostico = MedDiagnosticoEstados.all
			@partial = 'antecedentes/antecedentes_familiares'
		when 'ant_soc'
			@partial = 'antecedentes/antecedentes_sociales'
		when 'ant_lab'
			@ocupaciones = OcuPersonasOcupaciones.where('persona_id = ?',@persona.id );
			@partial = 'ocupaciones/index'	
		end

		respond_to do |format|     
    	format.js   {}
    end	

	end	

	def agregarAlergia
		@alergia = MedAlergias.where('nombre = ? AND comun is false', params[:alergia]).first
		if @alergia
		else 
			@alergia = MedAlergias.new
			@alergia.comun = false
			@alergia.nombre = params[:alergia]
			@alergia.save!
		end

		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first
		else 
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
		end

		@persona_alergia = FiPersonasAlergias.where('persona_id = ? AND alergia_id = ?',@persona.id,@alergia.id).first

		if @persona_alergia
			respond_to do |format|
				format.json { render :json => { :success => true } }
			end
		else
			@persona_alergia = FiPersonasAlergias.new
			@persona_alergia.alergia = @alergia
			@persona_alergia.persona = @persona
			@persona_alergia.save!

			respond_to do |format|     
	    	format.js   {}
	    end
	  end  	

	end	

	def guardarAntecedenteFamiliarMuerte
		@deceso = Hash.new
		habia_antecedente = false

		@persona_antecedente = PerPersonas.find(params[:persona_ant])
		habia_antecedente = true unless @persona_antecedente.diagnostico_muerte.nil? 
		@persona_antecedente.diagnostico_muerte = MedDiagnosticos.find(params[:diag]) unless params[:diag] == ''
		@persona_antecedente.fecha_muerte = params[:fecha] unless params[:fecha] == ''	
		@persona_antecedente.save!
		@deceso = { 
	    'id' => params[:persona_ant],
	    'persona' => @persona_antecedente.showName('%n%p%m'),
	    'parentesco' => params[:parentesco],
	    'diagnostico' => @persona_antecedente.diagnostico_muerte.nombre,
	    'fecha_deceso' => @persona_antecedente.fecha_muerte.try(:strftime,'%Y-%m-%d')
    } 

    if params[:tipo] == 'guardar' or habia_antecedente
	    respond_to do |format|
	    	format.js   { }
				format.json { render :json => { :success => true }	}
			end
		else
			respond_to do |format|
				format.js   { render 'agregarAntecedenteFamiliarMuerte' }
				format.json { render :json => { :success => true }	}
			end	
		end
	end	

	def guardarAntecedenteFamiliarCronica
		@id_pre = params[:id_pre]
		@enfermedad = Hash.new
		@ant_prof = false		
		@estados_diagnostico = MedDiagnosticoEstados.all

		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first 
		else 
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
			@ant_prof = true
		end

		if params[:tipo] == 'guardar'
				@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.find(params[:id_pre])
				@persona_diagnostico_atencion.atencion_salud = @atencion_salud unless params[:atencion_salud_id] == 'persona'
				@persona_diagnostico_atencion.fecha_inicio = params[:fecha_ini] unless params[:fecha_ini].blank?
				@persona_diagnostico_atencion.fecha_termino = params[:fecha_fin] unless params[:fecha_fin].blank?
				@persona_diagnostico_atencion.estado_diagnostico_id = params[:e_d] unless params[:e_d].blank?
				@persona_diagnostico_atencion.es_cronica = params[:enf_cro] unless params[:enf_cro].blank?
				@persona_diagnostico_atencion.comentario = params[:comentario] unless params[:comentario].blank?
				@persona_diagnostico_atencion.save!
		
		else
			@persona_ant = PerPersonas.find(params[:persona_ant])		
			persona_diagnostico_antecedente = FiPersonaDiagnosticos.joins(:persona_diagnosticos_atencion_salud)
																														 .where('fi_persona_diagnosticos_atenciones_salud.es_antecedente = true AND diagnostico_id = ? AND persona_id = ?',params[:diag],@persona_ant.id).first

			habia_antecedente = false
			if persona_diagnostico_antecedente
				habia_antecedente = true				
			else 
				@persona_diagnostico_temp = FiPersonaDiagnosticos.where('diagnostico_id = ? and persona_id = ?', params[:diag], @persona_ant.id).first
				unless @persona_diagnostico_temp	
					@persona_diagnostico_temp = FiPersonaDiagnosticos.new
					@persona_diagnostico_temp.persona = @persona_ant
					@persona_diagnostico_temp.diagnostico_id = params[:diag]
					@persona_diagnostico_temp.fecha_inicio = params[:fecha_ini].blank? ? DateTime.current : params[:fecha_ini]
					@persona_diagnostico_temp.fecha_termino = params[:fecha_fin] unless params[:fecha_fin].blank?
					@persona_diagnostico_temp.estado_diagnostico_id = params[:e_d].blank? ? 1 : params[:e_d]
					@persona_diagnostico_temp.es_cronica = params[:enf_cro]	
					@persona_diagnostico_temp.save!
				end		
				@persona_diagnostico_atencion = FiPersonaDiagnosticosAtencionesSalud.new
				@persona_diagnostico_atencion.persona_diagnostico = @persona_diagnostico_temp
				@persona_diagnostico_atencion.atencion_salud = @atencion_salud unless params[:atencion_salud_id] == 'persona'
				@persona_diagnostico_atencion.fecha_inicio = params[:fecha_ini].blank? ? DateTime.current : params[:fecha_ini]
				@persona_diagnostico_atencion.fecha_termino = params[:fecha_fin] unless params[:fecha_fin].blank?
				@persona_diagnostico_atencion.estado_diagnostico_id = params[:e_d].blank? ? 1 : params[:e_d]
				@persona_diagnostico_atencion.es_cronica = params[:enf_cro]
				@persona_diagnostico_atencion.comentario = params[:comentario]
				@persona_diagnostico_atencion.es_antecedente = 1			
				@persona_diagnostico_atencion.save!
			end	
		end  

		unless params[:tipo] != 'guardar' and habia_antecedente
			datos = FiPersonaDiagnosticos
		    .joins(:persona_diagnosticos_atencion_salud)
		    .select("fi_persona_diagnosticos_atenciones_salud.id,
		            fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
		            fi_persona_diagnosticos_atenciones_salud.fecha_termino,
		            fi_persona_diagnosticos.diagnostico_id,
		            fi_persona_diagnosticos.persona_id,
		            fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
		            fi_persona_diagnosticos_atenciones_salud.comentario,
		            fi_persona_diagnosticos_atenciones_salud.es_cronica,
		            fi_persona_diagnosticos_atenciones_salud.es_antecedente,              
		            fi_persona_diagnosticos_atenciones_salud.atencion_salud_id")
		    .where('fi_persona_diagnosticos_atenciones_salud.id = ? AND (fi_persona_diagnosticos_atenciones_salud.es_cronica = 1 OR fi_persona_diagnosticos_atenciones_salud.es_antecedente = true)', @persona_diagnostico_atencion.id).first 
		    @enfermedad = { 'datos' => datos , 'parentesco' =>  params[:parentesco] } 
		end     

    if params[:tipo] == 'guardar'
	    respond_to do |format|
	    	format.js   { }
				format.json { render :json => { :success => true }	}
			end
		else
			unless habia_antecedente
				respond_to do |format|
					format.js   { render 'agregarAntecedenteFamiliarCronica' }
					format.json { render :json => { :success => true }	}
				end	
			else	
				render :json => { :success => false }	
			end	
		end

	end

	def guardarAntecedentesGinecologicos
		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first 
		else 
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
		end

		if @persona.persona_antecedentes_ginecologicos.nil?
			@antecedentes_ginecologicos = FiPersonaAntecedentesGinecologicos.new
			@antecedentes_ginecologicos.persona = @persona
			@antecedentes_ginecologicos.numero_gestaciones = 0
			@antecedentes_ginecologicos.numero_partos = 0
			@antecedentes_ginecologicos.numero_abortos = 0
			@antecedentes_ginecologicos.save!
		else
			@antecedentes_ginecologicos = @persona.persona_antecedentes_ginecologicos
		end		

		case params[:id]
		when 'menq' then @antecedentes_ginecologicos.fecha_menarquia = DateTime.new(params[:value].to_i , 1, 1)
		when 'menp' then @antecedentes_ginecologicos.fecha_menopausia = params[:value]
		when 'dur-men' then @antecedentes_ginecologicos.duracion_menstruacion = params[:value]
		when 'fre-pro' then @antecedentes_ginecologicos.frecuencia_promedio = params[:value] 
		when 'PAP' then @antecedentes_ginecologicos.fecha_ultimo_PAP = params[:value]
		when 'mam' then @antecedentes_ginecologicos.fecha_ultima_mamografia = params[:value]
		when 'num-ges' then @antecedentes_ginecologicos.numero_gestaciones = params[:value]
		when 'num-par' then @antecedentes_ginecologicos.numero_partos = params[:value]
		when 'num-abo' then @antecedentes_ginecologicos.numero_abortos = params[:value]			
		end

		@antecedentes_ginecologicos.save!

		respond_to do |format|
			format.json { render :json => { :success => true } }
		end	
		
	end

end
