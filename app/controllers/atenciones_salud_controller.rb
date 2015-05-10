class AtencionesSaludController < ApplicationController

	include ActionView::Helpers::NumberHelper	
	
	def new		
		@atencion_salud = FiAtencionesSalud.new
	end

	def create		
	
		@atencion_salud = FiAtencionesSalud.new(app_params)
				
	  if @atencion_salud.save
	  	redirect_to :action => "show", :id => @atencion_salud.id
	  else
	  	render 'new'
	  end		
	end

	def destroy
  	@atencion_salud = FiAtencionesSalud.find(params[:id])
  	@atencion_salud.destroy 
  	redirect_to atenciones_salud_index_path 
	end

	def show
  	@atencion_salud = FiAtencionesSalud.find(params[:id])
  end	

  def index
  	@atenciones_salud = FiAtencionesSalud.all
	end

	def edit

		@profesional = PerPersonas.where('user_id = ?',current_user.id).first	
		@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",@profesional.id).first
		@agendamientos = AgAgendamientos.where( "especialidad_prestador_profesional_id = ? AND fecha_comienzo BETWEEN ? AND ? ", @especialidad_prestador_profesional, Date.today, Date.tomorrow )
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

		#validar que tenga acceso a esta atención		
		@id = params[:id]
		@atencion_salud = FiAtencionesSalud.find(params[:id])
	  @agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @fecha_comienzo_atencion = @agendamiento.fecha_comienzo_real
	  @fecha_final_atencion = @agendamiento.fecha_final_real
	  @fecha_final_atencion = DateTime.tomorrow if @fecha_final_atencion.nil?

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
	  					fi_persona_diagnosticos_atenciones_salud.primer_diagnostico,
	  					fi_persona_diagnosticos_atenciones_salud.en_tratamiento")
	  	.where('fi_persona_diagnosticos_atenciones_salud.atencion_salud_id = ? AND fi_persona_diagnosticos_atenciones_salud.es_antecedente = 0',params[:id])
	  
	  @persona_diagnostico_anteriores = FiPersonaDiagnosticos
	  	.joins('JOIN fi_persona_diagnosticos_atenciones_salud as fpdas ON 
			 				fi_persona_diagnosticos.id = fpdas.persona_diagnostico_id
			 				JOIN fi_atenciones_salud
			 				ON fpdas.atencion_salud_id = fi_atenciones_salud.id
			 				JOIN ag_agendamientos 
			 				ON fi_atenciones_salud.agendamiento_id = ag_agendamientos.id ')
	  	.select("fpdas.id,
	  					fpdas.fecha_inicio,
	  					fpdas.fecha_termino,
	  					fi_persona_diagnosticos.diagnostico_id,
	  					fpdas.estado_diagnostico_id,
	  					fpdas.comentario,
	  					fpdas.es_cronica,
	  					fpdas.es_antecedente,
	  					fpdas.en_tratamiento,
	  					fpdas.primer_diagnostico")
	  	.where('fi_persona_diagnosticos.persona_id = ? AND fpdas.atencion_salud_id != ? 
	  					AND fpdas.es_cronica = 0 AND fpdas.es_antecedente = 0 AND ag_agendamientos.fecha_comienzo_real < ?', @atencion_salud.persona.id,params[:id],@fecha_comienzo_atencion)

	  @ant_med_at = FiPersonaDiagnosticos
	  	.joins(:persona_diagnosticos_atencion_salud)
	  	.select("fi_persona_diagnosticos_atenciones_salud.id,
	  					fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
	  					fi_persona_diagnosticos_atenciones_salud.fecha_termino,
	  					fi_persona_diagnosticos.diagnostico_id,
	  					fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
	  					fi_persona_diagnosticos_atenciones_salud.comentario,
	  					fi_persona_diagnosticos_atenciones_salud.es_cronica,
	  					fi_persona_diagnosticos_atenciones_salud.es_antecedente,	  					
	  					fi_persona_diagnosticos_atenciones_salud.atencion_salud_id,
	  					fi_persona_diagnosticos_atenciones_salud.en_tratamiento,
	  					fi_persona_diagnosticos_atenciones_salud.primer_diagnostico")
	  	.where('persona_id = ? AND (fi_persona_diagnosticos_atenciones_salud.created_at < ? )AND fi_persona_diagnosticos_atenciones_salud.es_cronica = 1 AND
	  				  fi_persona_diagnosticos_atenciones_salud.atencion_salud_id != ? AND fi_persona_diagnosticos_atenciones_salud.es_antecedente = 0', @atencion_salud.persona.id,@fecha_final_atencion,params[:id])	

	  @ant_med_us = FiPersonaDiagnosticosAtencionesSalud.joins('JOIN fi_persona_diagnosticos AS fpd ON fi_persona_diagnosticos_atenciones_salud.persona_diagnostico_id = fpd.id	JOIN med_diagnosticos AS md ON fpd.diagnostico_id = md.id')
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
														 fpd.persona_id,
														 fpd.diagnostico_id,
														 md.codigo_cie10')
										.where('persona_id = ? AND fi_persona_diagnosticos_atenciones_salud.created_at < ? AND fi_persona_diagnosticos_atenciones_salud.es_antecedente = 1 ', @atencion_salud.persona.id,@fecha_final_atencion)
	  						
	  @diagnosticos = MedDiagnosticos.where('frecuente = ?',true)
	  @estados_diagnostico = MedDiagnosticoEstados.all
	  @prestadores = PrePrestadores.all
	  @especialidades = ProEspecialidades.all
	  @paises = TraPaises.all
	  
	  # Se debe mejorar las consultas para cargar examenes y procedimientos en base a grupos o subgrupos
	  @persona_examen = FiPersonaPrestaciones.where('atencion_salud_id = ? AND prestacion_id <= ?', params[:id],571)
	  @persona_procedimiento = FiPersonaPrestaciones.where('atencion_salud_id = ? AND prestacion_id >= ?', params[:id],572)
	  @persona_medicamento = FiPersonaMedicamentos.where('atencion_salud_id = ? AND es_antecedente is null', params[:id])

	  @persona_estatura = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],1).first
	  @persona_peso = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],2).first
	  @persona_presion = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],3).first
	  @persona_imc= FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],4).first

	  @estatura = @persona_estatura ? @persona_estatura.valor : ''
	  @peso = @persona_peso ? @persona_peso.valor : ''
	  @presion = @persona_presion ? @persona_presion.valor : ''
	  @imc = @persona_imc ? @persona_imc.valor : ''

	  @array_medicamentos = []
	  @persona_medicamentos_ant = FiPersonaMedicamentos.where('persona_id = ? AND ( atencion_salud_id != ? OR es_antecedente is not null )',@persona.id,params[:id]).order('created_at')
	  @persona_medicamentos_ant.each do |p_m_a|
	  	@array_medicamentos.push(p_m_a.medicamento.nombre)
  	end
  	if @array_medicamentos.blank?
  		@texto_ant_med = 'Sin información'
  	else
  		@texto_ant_med = @array_medicamentos.join('|')	
  	end	

  	@array_procedimiento = []
	  @persona_procedimiento_ant = FiPersonaPrestaciones.where(' prestacion_id >= ? AND persona_id = ? AND ( atencion_salud_id != ? OR es_antecedente is not null )',572,@persona.id,params[:id]).order('created_at')
	  @persona_procedimiento_ant.each do |p_p_a|
	  	@array_procedimiento.push(p_p_a.prestacion.nombre)
  	end
  	if @array_procedimiento.blank?
  		@texto_ant_pro = 'Sin información'
  	else
  		@texto_ant_pro = @array_procedimiento.join('|')	
  	end

  	@array_alergias = []
	  @persona_alergias = FiPersonasAlergias.where('persona_id = ? ',@persona.id).order('created_at')
	  @persona_alergias.each do |p_a|
	  	@array_alergias.push(p_a.alergia.nombre)
  	end
  	if @array_alergias.blank?
  		@texto_alergias = 'Sin información'
  	else
  		@texto_alergias = @array_alergias.join('|')	
  	end

  	@array_vacunas = []
	  @persona_vacunas = FiPersonasVacunas.where('persona_id = ? ',@persona.id).order('created_at')
	  @persona_vacunas.each do |p_v|
	  	@array_vacunas.push(p_v.vacuna.nombre)
  	end
  	if @array_vacunas.blank?
  		@texto_vacunas = 'Sin información'
  	else
  		@texto_vacunas = @array_vacunas.join('|')	
  	end

		#Actividad física
		@persona_actividad_fisica = FiPersonaActividadFisica.where('persona_id = ?',@persona.id).first
  	if @persona_actividad_fisica.nil?
  		@persona_actividad_fisica = FiPersonaActividadFisica.new 
			@persona_actividad_fisica.persona = @persona
			@persona_actividad_fisica.nivel_actividad = "Sin información"
			@persona_actividad_fisica.save!
		end
		@segmento_actividad = @persona.getSegmentoActividadFisica
		@edad_act_fis = @persona.age()
		@edad_act_fis = "sin_info" if @edad_act_fis == "Sin información"

		#Hábitos de alcohol
		@ultimo_test = FiHabitosAlcohol
			.select('MAX(fecha_test_audit),audit_puntaje')
			.where('persona_id = ?', @persona.id ).first

		@texto_alcohol = 'Sin información'	
		if @ultimo_test
			case @ultimo_test.audit_puntaje				      
	    when 8..15
	      @texto_alcohol = 'Consumo de riesgo'
	    when 0..7
	      @texto_alcohol = 'Consumo de bajo riesgo'
	    when 16..40
	    	@texto_alcohol = 'Consumo perjudicial o dependencia'	 
	    end 
		end

		#Hábitos de tabaco
		@texto_tabaco = 'Sin información'
		@total_consumo = 0
		@consumo = FiHabitosTabaco.where('persona_id = ?', @persona.id )
		@consumo.each do |con|
  		@total_consumo += con.paquetes_agno
  	end	
  	@texto_tabaco = 'Paquetes-año: ' <<  number_to_human(@total_consumo, precision: 2, separator: ',') unless @consumo.first.nil?

  	#Antecedentes laborales
  	@texto_ocupaciones = 'Sin información'
  	@ocupaciones = OcuPersonasOcupaciones.where('persona_id = ?',@persona.id );
  	@array_ocupaciones = []
	  @ocupaciones.each do |ocu|
	  	@array_ocupaciones.push(ocu.ocupacion.nombre)
	  end	
 		@texto_ocupaciones = @array_ocupaciones.join('|') unless @array_ocupaciones.blank?

 		#Antecedentes familiares
 		@array_ant_fam = []
 		@decesos = @persona.getAntecedentesDecesos
  	@ant_enf_cro = @persona.getAntecedentesEnfermedadesCronicas
	  @decesos.each do |deceso|
	  	@array_ant_fam.push(deceso['diagnostico'])
  	end
  	@ant_enf_cro.each do |enfermedad|
	  	@array_ant_fam.push(enfermedad['datos'].diagnostico.nombre)
  	end
  	if @array_ant_fam.blank?
  		@texto_ant_fam = 'Sin información'
  	else
  		@texto_ant_fam = @array_ant_fam.join('|')	
  	end

  	 #Antecedentes ginecológicos
  	if @persona.genero == 'Femenino' 
	  	@texto_ant_gin = 'Sin información'
	  	@ant_gin = @persona.persona_antecedentes_ginecologicos
	  	if !@ant_gin.nil?
		  	if !@ant_gin.fecha_menopausia.nil?
		  		@texto_ant_gin = 'Menopausia' 
		  	elsif !@ant_gin.numero_gestaciones.nil? and @ant_gin.numero_gestaciones != 'null'
		  		@texto_ant_gin = 'G' << @ant_gin.numero_gestaciones.to_s << 'P' << @ant_gin.numero_partos.to_s << 'A' <<@ant_gin.numero_abortos.to_s
		  	end
		  end	
	  end	
  				

  	
	end

	def crearAtencion	

		@agendamiento =  AgAgendamientos.find(params[:id])
		@persona = @agendamiento.persona

		@atencion_salud = FiAtencionesSalud.new(:agendamiento_id => params[:id],:persona_id => @persona.id, :tipo_ficha_id => 1)				
	  @atencion_salud.save(:validate => false)

		@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Paciente siendo atendido").first
		@agendamiento.agendamiento_estado = @estadoAgendamiento
		@agendamiento.fecha_comienzo_real = DateTime.current
		@agendamiento.save

	 	redirect_to :action => "edit", :id => @atencion_salud.id
	
	end

	def editarAtencion		

  	redirect_to action: "edit", id: params[:id]
	
	end

	def reabrirAtencion	
		@atencion_salud = FiAtencionesSalud.find(params[:id_atencion])
	  @agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
		@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Paciente siendo atendido").first
		@agendamiento.agendamiento_estado = @estadoAgendamiento
		@agendamiento.save	
  	redirect_to action: "edit", id: params[:id_atencion]	
	end
		
	def guardarTexto

		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])

		case params[:tipo_texto]
		when 'motivo'
			@atencion_salud.update( motivo_consulta: params[:texto] )						
		when 'examen'
			@atencion_salud.update( examen_fisico: params[:texto] )					
		when 'indicaciones'
			@atencion_salud.update( indicaciones_generales: params[:texto] )	
		end

		render :json => { :success => true } 	  
	
	end

	def update
		@atencion_salud = FiAtencionesSalud.find(params[:id])
		@atencion_salud.update( motivo_consulta: params['motivo'], examen_fisico: params['examen'], indicaciones_generales: params['indicaciones'] )

		if params[:finalizar] == 'finalizar'
			@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)	
			@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Paciente atendido").first
			@agendamiento.agendamiento_estado = @estadoAgendamiento
			@agendamiento.fecha_final_real = DateTime.current
			@agendamiento.save
		end	

		render :json => { :success => true } 

	end

	def cargarAtenciones

		@profesional = PerPersonas.where('user_id = ?',current_user.id).first	
		@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",@profesional.id).first
		@fecha_inicial = params[:fecha_inicio].blank? ? DateTime.new(2015, 01, 01, 20, 0, 0) : params[:fecha_inicio]
		@fecha_final = params[:fecha_final].blank? ? DateTime.current : params[:fecha_final].to_time + 1.days

		@query = FiAtencionesSalud
			.select('fi_atenciones_salud.id, ag.fecha_comienzo, fi_atenciones_salud.persona_id')
			.joins('JOIN ag_agendamientos AS ag
						  ON fi_atenciones_salud.agendamiento_id = ag.id
						  JOIN pre_prestador_profesionales as ppp
						  ON ag.especialidad_prestador_profesional_id = ppp.id')
					.where('ppp.id = ? AND fecha_comienzo BETWEEN ? AND ?',@especialidad_prestador_profesional.id,@fecha_inicial,@fecha_final)

		if params[:paciente].blank?
			@atenciones_salud = @query
		else
			@atenciones_salud = @query.where('fi_atenciones_salud.persona_id = ?',params[:paciente])
		end	 			

		@atenciones = []

		@atenciones_salud.each do |at_sal|
			@atenciones << [at_sal.fecha_comienzo.strftime("%Y-%m-%d %H:%M"),at_sal.persona.showName('%n%p%m'),at_sal.persona.showRut,
			 link_to( 'Ver', atenciones_salud_path(at_sal)) ]
		end	

		render :json => @atenciones

	end 	

	private
	  def app_params
	    params.require(:atencion_salud).permit(:agendamiento,
	                  :certificados,
	                  :examen_fisico,
	                  :id,
	                  :indicaciones_generales,
	                  :interconsultas,
	                  :motivo_consulta,
	                  :persona,
	                  :persona_diagnosticos_atencion_salud,
	                  :persona_examenes,
	                  :persona_medicamentos,
	                  :persona_metricas,
	                  :tipo_ficha)
	  end	 



end
