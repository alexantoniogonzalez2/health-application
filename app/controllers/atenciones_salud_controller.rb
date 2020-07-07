 class AtencionesSaludController < ApplicationController

 	include ApplicationHelper
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
		permiso = false
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",@usuario.id).first
		@atencion_salud = FiAtencionesSalud.find(params[:id])
	  @agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona

	  permiso = true if @especialidad_prestador_profesional == @agendamiento.especialidad_prestador_profesional 
	  permiso = true if @usuario == @persona
		redirect_to :action => "sinPermiso" unless permiso		

		@fecha_comienzo_atencion = @agendamiento.fecha_comienzo_real
	  @fecha_final_atencion = @agendamiento.fecha_final_real
	  @fecha_final_atencion = DateTime.tomorrow if @fecha_final_atencion.nil?
		
		@id = params[:id]
		@hora_actual = DateTime.current		  
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
	  					fi_persona_diagnosticos.persona_id,
	  					fpdas.estado_diagnostico_id,
	  					fpdas.comentario,
	  					fpdas.es_cronica,
	  					fpdas.es_antecedente,
	  					fpdas.en_tratamiento,
	  					fpdas.primer_diagnostico")
	  	.where('fi_persona_diagnosticos.persona_id = ? AND fpdas.atencion_salud_id != ? 
	  					AND fpdas.es_cronica = false AND fpdas.es_antecedente = false AND ag_agendamientos.fecha_comienzo_real < ?
	  					AND fpdas.es_ultima_actualizacion = true', @atencion_salud.persona.id,params[:id],@fecha_comienzo_atencion)

	  @ant_med_at = FiPersonaDiagnosticos
	  	.joins(:persona_diagnosticos_atencion_salud)	  	
	  	.joins(:diagnostico)
	  	.select("fi_persona_diagnosticos_atenciones_salud.id,
	  					fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
	  					fi_persona_diagnosticos_atenciones_salud.fecha_termino,
	  					fi_persona_diagnosticos.diagnostico_id,
	  					fi_persona_diagnosticos.persona_id,
	  					fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
	  					fi_persona_diagnosticos_atenciones_salud.comentario,
	  					fi_persona_diagnosticos_atenciones_salud.es_cronica,
	  					fi_persona_diagnosticos_atenciones_salud.es_antecedente,	  					
	  					fi_persona_diagnosticos_atenciones_salud.atencion_salud_id,
	  					fi_persona_diagnosticos_atenciones_salud.en_tratamiento,
	  					fi_persona_diagnosticos_atenciones_salud.primer_diagnostico,
	  					med_diagnosticos.codigo_cie10,
	  					med_diagnosticos.nombre")
	  	.where('persona_id = ? AND (fi_persona_diagnosticos_atenciones_salud.created_at < ? ) AND
	  				  fi_persona_diagnosticos_atenciones_salud.atencion_salud_id = ? AND fi_persona_diagnosticos_atenciones_salud.es_antecedente = true', @atencion_salud.persona.id,@fecha_final_atencion,params[:id])	

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
										.where('persona_id = ? AND fi_persona_diagnosticos_atenciones_salud.created_at < ? AND fi_persona_diagnosticos_atenciones_salud.es_antecedente = true AND
														fi_persona_diagnosticos_atenciones_salud.atencion_salud_id is null', @atencion_salud.persona.id,@fecha_final_atencion)
										
	  # Se debe mejorar las consultas para cargar examenes y procedimientos en base a grupos o subgrupos
	  @persona_examen = FiPersonaPrestaciones.where('atencion_salud_id = ? AND prestacion_id <= ?', params[:id],571)
	  @persona_procedimiento = FiPersonaPrestaciones.where('atencion_salud_id = ? AND prestacion_id >= ? AND es_antecedente is null', params[:id],572)
	  @persona_medicamento = FiPersonaMedicamentos.where('atencion_salud_id = ? AND es_antecedente is null', params[:id])

	  @persona_estatura = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],1).first
	  @persona_peso = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],2).first
	  @persona_presion_am = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],3).first
	  @persona_imc = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],4).first
	  @persona_frec_car = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],5).first
	  @persona_frec_res = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],6).first
	  @persona_temp = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],7).first
	  @persona_sat= FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],8).first
	  @persona_presion_sis = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],9).first
	  @persona_presion_dias = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],10).first

	  @estatura = @persona_estatura ? @persona_estatura.valor : ''
	  @peso = @persona_peso ? @persona_peso.valor : ''
	  @presion_sis = @persona_presion_sis ? @persona_presion_sis.valor : ''
	  @presion_dias = @persona_presion_dias ? @persona_presion_dias.valor : ''
	  @presion_am = @persona_presion_am ? @persona_presion_am.valor : ''
	  @imc = @persona_imc ? @persona_imc.valor : ''
	  @frec_car = @persona_frec_car ? @persona_frec_car.valor : ''
	  @frec_res = @persona_frec_res ? @persona_frec_res.valor : ''
	  @temp = @persona_temp ? @persona_temp.valor : ''
	  @sat = @persona_sat ? @persona_sat.valor : '' 
	  @car_frec_car = @persona_frec_car ? @persona_frec_car.caracteristica : ''
	  @car_frec_res = @persona_frec_res ? @persona_frec_res.caracteristica : ''
	  @car_temp = @persona_temp ? @persona_temp.caracteristica : ''
	  @car_sat = @persona_sat ? @persona_sat.caracteristica : ''
	  @car_presion_sis = @persona_presion_sis ? @persona_presion_sis.caracteristica : ''
	  @car_presion_dias = @persona_presion_dias ? @persona_presion_dias.caracteristica : ''
	  @car_presion_am = @persona_presion_am ? @persona_presion_am.caracteristica : ''
 
	  @persona_medicamentos_ant = FiPersonaMedicamentos.where('persona_id = ? AND ( atencion_salud_id != ? OR es_antecedente is not null )',@persona.id,params[:id]).order('created_at')
  	@class_med = @persona_medicamentos_ant.blank? ? '' : 'active-ant'	
  	
	  @persona_procedimiento_ant = FiPersonaPrestaciones.where(' prestacion_id >= ? AND persona_id = ? AND ( atencion_salud_id != ? OR es_antecedente is not null )',572,@persona.id,params[:id]).order('created_at')
  	@class_ant_pro = @persona_procedimiento_ant.blank? ? '' : 'active-ant'		
  	
	  @persona_alergias = FiPersonasAlergias.where('persona_id = ? ',@persona.id).order('created_at')
  	@class_alergias = @persona_alergias.blank? ? '' : 'active-ant'

  	@persona_vacunas = FiPersonasVacunas.where('persona_id = ? ',@persona.id).order('created_at')
  	@class_vacunas = @persona_vacunas.blank? ? '' : 'active-ant'	

		#Actividad física
		@class_act_fis = 'active-ant'
		@persona_actividad_fisica = FiPersonaActividadFisica.where('persona_id = ?',@persona.id).first
  	if @persona_actividad_fisica.nil?
  		@persona_actividad_fisica = FiPersonaActividadFisica.new 
			@persona_actividad_fisica.persona = @persona
			@persona_actividad_fisica.nivel_actividad = "Sin información"
			@persona_actividad_fisica.save!
			@class_act_fis = ''
		else
			@class_act_fis = '' if @persona_actividad_fisica.nivel_actividad == "Sin información"
		end 	
		@segmento_actividad = @persona.getSegmentoActividadFisica
		@edad_act_fis = @persona.age()
		@edad_act_fis = "sin_info" if @edad_act_fis == "Sin información"

		#Hábitos de alcohol
		@ultimo_test = FiHabitosAlcohol.select('MAX(fecha_test_audit),audit_puntaje').where('persona_id = ?', @persona.id ).first
		@class_alcohol = @ultimo_test.audit_puntaje.nil? ? '' : 'active-ant'

		#Hábitos de tabaco
		@consumo = FiHabitosTabaco.where('persona_id = ?', @persona.id )
		@class_tabaco = @consumo.blank? ? '' : 'active-ant'	

  	#Antecedentes laborales
  	@ocupaciones = OcuPersonasOcupaciones.where('persona_id = ?',@persona.id );
		@class_ocupaciones = @ocupaciones.blank? ? '' : 'active-ant'	

 		#Antecedentes familiares
 		@decesos = @persona.getAntecedentesDecesos
  	@ant_enf_cro = @persona.getAntecedentesEnfermedadesCronicas
  	@class_ant_fam = ( @decesos.blank? and @ant_enf_cro.blank? ) ? '' : 'active-ant'	

  	#Antecedentes ginecológicos
  	if @persona.genero == 'Femenino' 
  		@class_gin = ''
	  	@ant_gin = @persona.persona_antecedentes_ginecologicos
	  	if !@ant_gin.nil?
		  	if !@ant_gin.fecha_menopausia.nil? or !@ant_gin.numero_gestaciones.nil? or @ant_gin.numero_gestaciones != 'null'
		  		@class_gin = 'active-ant'
		  	end
		  end	
	  end	

	  #Antecedentes sociales
		@class_sociales = ( @persona.nivel_escolaridad.nil? and @persona.numero_personas_familia.nil? ) ? '' : 'active-ant'

		#certificado
		@certificado = FiCertificados.where('atencion_salud_id = ?',@atencion_salud.id).first
		unless @certificado
			@certificado = FiCertificados.new
			@certificado.atencion_salud = @atencion_salud 
			@certificado.save!
		end	
			
	end

  def index
  	@atenciones_salud = FiAtencionesSalud.all
	end

	def edit
		permiso = false
		editar = false			
		@profesional = PerPersonas.where('user_id = ?',current_user.id).first	
		@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",@profesional.id).first		
		@atencion_salud = FiAtencionesSalud.find(params[:id])
	  @agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)	

	  if @agendamiento.estado.nombre == "Paciente siendo atendido" then editar = true else action = "sinEditar"	end	
	  if @especialidad_prestador_profesional == @agendamiento.especialidad_prestador_profesional then permiso = true else action = "sinPermiso" end					
		redirect_to :action => action unless permiso or editar


	  @fecha_comienzo_atencion = @agendamiento.fecha_comienzo_real
	  @fecha_final_atencion = @agendamiento.fecha_final_real
	  @fecha_final_atencion = DateTime.tomorrow if @fecha_final_atencion.nil?

	  @hora_actual = DateTime.current	
	  @id = params[:id]
	  @persona = @agendamiento.persona
	  
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

		case @atencion_salud.tipo_ficha_id
		when 1..2
			@tipo_ficha = 'salud'
		when 3
			@tipo_ficha = 'dental'
		end

		unless @tipo_ficha == 'dental'
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
	  end	
	  
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
	  					fi_persona_diagnosticos.persona_id,
	  					fpdas.estado_diagnostico_id,
	  					fpdas.comentario,
	  					fpdas.es_cronica,
	  					fpdas.es_antecedente,
	  					fpdas.en_tratamiento,
	  					fpdas.primer_diagnostico")
	  	.where('fi_persona_diagnosticos.persona_id = ? AND fpdas.atencion_salud_id != ? 
	  					AND fpdas.es_cronica = false AND fpdas.es_antecedente = false AND ag_agendamientos.fecha_comienzo_real < ?
	  					AND fpdas.es_ultima_actualizacion = true', @atencion_salud.persona.id,params[:id],@fecha_comienzo_atencion)

	  @ant_med_at = FiPersonaDiagnosticos
	  	.joins(:persona_diagnosticos_atencion_salud)
	  	.joins(:diagnostico)
	  	.select("med_diagnosticos.codigo_cie10,
	  					med_diagnosticos.nombre,
	  					fi_persona_diagnosticos_atenciones_salud.id,
	  					fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
	  					fi_persona_diagnosticos_atenciones_salud.fecha_termino,
	  					fi_persona_diagnosticos.diagnostico_id,
	  					fi_persona_diagnosticos.persona_id,
	  					fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
	  					fi_persona_diagnosticos_atenciones_salud.comentario,
	  					fi_persona_diagnosticos_atenciones_salud.es_cronica,
	  					fi_persona_diagnosticos_atenciones_salud.es_antecedente,	  					
	  					fi_persona_diagnosticos_atenciones_salud.atencion_salud_id,
	  					fi_persona_diagnosticos_atenciones_salud.en_tratamiento,
	  					fi_persona_diagnosticos_atenciones_salud.primer_diagnostico")
	  	.where('persona_id = ? AND (fi_persona_diagnosticos_atenciones_salud.created_at < ? ) AND
	  				  fi_persona_diagnosticos_atenciones_salud.atencion_salud_id = ? AND fi_persona_diagnosticos_atenciones_salud.es_antecedente = true', @atencion_salud.persona.id,@fecha_final_atencion,params[:id])	

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
										.where('persona_id = ? AND fi_persona_diagnosticos_atenciones_salud.created_at < ? AND fi_persona_diagnosticos_atenciones_salud.es_antecedente = true AND
														fi_persona_diagnosticos_atenciones_salud.atencion_salud_id is null', @atencion_salud.persona.id,@fecha_final_atencion)
	  						
	  @estados_diagnostico = MedDiagnosticoEstados.all
	  @prestadores = PrePrestadores.all
	  @especialidades = ProEspecialidades.all
	  @paises = TraPaises.all

	  unless @tipo_ficha == 'dental'	  
		  # Se debe mejorar las consultas para cargar examenes y procedimientos en base a grupos o subgrupos
		  @persona_examen = FiPersonaPrestaciones.where('atencion_salud_id = ? AND prestacion_id <= ?', params[:id],571)
		  @persona_procedimiento = FiPersonaPrestaciones.where('atencion_salud_id = ? AND prestacion_id >= ? AND es_antecedente is null', params[:id],572)
		  @persona_medicamento = FiPersonaMedicamentos.where('atencion_salud_id = ? AND es_antecedente is null', params[:id])
		end

	  @persona_estatura = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],1).first
	  @persona_peso = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],2).first
	  @persona_presion_am = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],3).first
	  @persona_imc= FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],4).first
	  @persona_frec_car = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],5).first
	  @persona_frec_res = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],6).first
	  @persona_temp = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],7).first
	  @persona_sat= FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],8).first
	  @persona_presion_sis = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],9).first
	  @persona_presion_dias = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],10).first

	  @estatura = @persona_estatura ? @persona_estatura.valor : ''
	  @peso = @persona_peso ? @persona_peso.valor : ''
	  @presion_am = @persona_presion_am ? @persona_presion_am.valor : ''
	  @presion_sis = @persona_presion_sis ? @persona_presion_sis.valor : ''
	  @presion_dias = @persona_presion_dias ? @persona_presion_dias.valor : ''
	  @imc = @persona_imc ? @persona_imc.valor : ''
	  @frec_car = @persona_frec_car ? @persona_frec_car.valor : ''
	  @frec_res = @persona_frec_res ? @persona_frec_res.valor : ''
	  @temp = @persona_temp ? @persona_temp.valor : ''
	  @sat = @persona_sat ? @persona_sat.valor : '' 
	  @car_frec_car = @persona_frec_car ? @persona_frec_car.caracteristica : ''
	  @car_frec_res = @persona_frec_res ? @persona_frec_res.caracteristica : ''
	  @car_temp = @persona_temp ? @persona_temp.caracteristica : ''
	  @car_sat = @persona_sat ? @persona_sat.caracteristica : ''
	  @car_presion_am = @persona_presion_am ? @persona_presion_am.caracteristica : ''
	  @car_presion_sis = @persona_presion_sis ? @persona_presion_sis.caracteristica : ''
	  @car_presion_dias = @persona_presion_dias ? @persona_presion_dias.caracteristica : ''
 
	  @persona_medicamentos_ant = FiPersonaMedicamentos.where('persona_id = ? AND ( atencion_salud_id != ? OR es_antecedente is not null )',@persona.id,params[:id]).order('created_at')
  	@class_med = @persona_medicamentos_ant.blank? ? '' : 'active-ant'	
  	
	  @persona_procedimiento_ant = FiPersonaPrestaciones.where(' prestacion_id >= ? AND persona_id = ? AND ( atencion_salud_id != ? OR es_antecedente is not null )',572,@persona.id,params[:id]).order('created_at')
  	@class_ant_pro = @persona_procedimiento_ant.blank? ? '' : 'active-ant'		
  	
	  @persona_alergias = FiPersonasAlergias.where('persona_id = ? ',@persona.id).order('created_at')
  	@class_alergias = @persona_alergias.blank? ? '' : 'active-ant'

  	@persona_vacunas = FiPersonasVacunas.where('persona_id = ? ',@persona.id).order('created_at')
  	@class_vacunas = @persona_vacunas.blank? ? '' : 'active-ant'	

		#Actividad física
		@class_act_fis = 'active-ant'
		@persona_actividad_fisica = FiPersonaActividadFisica.where('persona_id = ?',@persona.id).first
  	if @persona_actividad_fisica.nil?
  		@persona_actividad_fisica = FiPersonaActividadFisica.new 
			@persona_actividad_fisica.persona = @persona
			@persona_actividad_fisica.nivel_actividad = "Sin información"
			@persona_actividad_fisica.save!
			@class_act_fis = ''
		else
			@class_act_fis = '' if @persona_actividad_fisica.nivel_actividad == "Sin información"
		end 	
		@segmento_actividad = @persona.getSegmentoActividadFisica
		@edad_act_fis = @persona.age()
		@edad_act_fis = "sin_info" if @edad_act_fis == "Sin información"

		#Hábitos de alcohol
		@ultimo_test = FiHabitosAlcohol.select('fecha_test_audit,audit_puntaje').where('persona_id = ?', @persona.id ).order('fecha_test_audit DESC').first
		if @ultimo_test
			@class_alcohol = @ultimo_test.audit_puntaje.nil? ? '' : 'active-ant'
		end

		#Hábitos de tabaco
		@consumo = FiHabitosTabaco.where('persona_id = ?', @persona.id )
		@class_tabaco = @consumo.blank? ? '' : 'active-ant'	

  	#Antecedentes laborales
  	@ocupaciones = OcuPersonasOcupaciones.where('persona_id = ?',@persona.id );
		@class_ocupaciones = @ocupaciones.blank? ? '' : 'active-ant'	

 		#Antecedentes familiares
 		@decesos = @persona.getAntecedentesDecesos
  	@ant_enf_cro = @persona.getAntecedentesEnfermedadesCronicas
  	@class_ant_fam = ( @decesos.blank? and @ant_enf_cro.blank? ) ? '' : 'active-ant'	

  	#Antecedentes ginecológicos
  	if @persona.genero == 'Femenino' 
  		@class_gin = ''
	  	@ant_gin = @persona.persona_antecedentes_ginecologicos
	  	if !@ant_gin.nil?
		  	if !@ant_gin.fecha_menopausia.nil? or !@ant_gin.numero_gestaciones.nil? or @ant_gin.numero_gestaciones != 'null'
		  		@class_gin = 'active-ant'
		  	end
		  end	
	  end	

	  #Antecedentes sociales
		@class_sociales = ( @persona.nivel_escolaridad.nil? and @persona.numero_personas_familia.nil? ) ? '' : 'active-ant'

		#certificado
		@certificado = FiCertificados.where('atencion_salud_id = ?',@atencion_salud.id).first
		unless @certificado
			@certificado = FiCertificados.new
			@certificado.atencion_salud = @atencion_salud 
			@certificado.save!
		end

		if @tipo_ficha == 'dental'
			@endodoncia = FdEndodoncias.where('atencion_salud_id = ?',@atencion_salud.id).first
			unless @endodoncia
				@endodoncia =  FdEndodoncias.new
				@endodoncia.atencion_salud = @atencion_salud 
				@endodoncia.save!
			end
			@periodoncia = FdPeriodoncias.where('atencion_salud_id = ?',@atencion_salud.id).first
			unless @periodoncia
				@periodoncia =  FdPeriodoncias.new
				@periodoncia.atencion_salud = @atencion_salud 
				@periodoncia.save!
			end
			@presupuesto = FdPresupuestos.where('atencion_salud_id = ?',@atencion_salud.id).first
			unless @presupuesto
				@presupuesto =  FdPresupuestos.new
				@presupuesto.atencion_salud = @atencion_salud 
				@presupuesto.estado = "Propuesto"
				@presupuesto.valor = 0
				@presupuesto.descuento = 0
				@presupuesto.total = 0
				@presupuesto.pagado = 0
				@presupuesto.pendiente = 0
				@presupuesto.save!
			end
			render 'edit_dental'
		else
			render 'edit'
		end				
 	
	end

	def sinEditar
	end	
 
 	def sinPermiso
	end	

	def crearAtencion	

		@agendamiento =  AgAgendamientos.find(params[:id])
		tipo_ficha = @agendamiento.especialidad_prestador_profesional.especialidad.nombre == "Dental" ? 3 : 1			
		@persona = @agendamiento.persona

		@atencion_salud = FiAtencionesSalud.new(:agendamiento_id => params[:id],:persona_id => @persona.id, :tipo_ficha_id => tipo_ficha)				
	  @atencion_salud.save(:validate => false)

		@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Paciente siendo atendido").first
		@agendamiento.estado = @estadoAgendamiento
		@agendamiento.fecha_comienzo_real = DateTime.current
		@agendamiento.save

	 	redirect_to :action => "edit", :id => @atencion_salud.id
	
	end

	def editarAtencion	
  	redirect_to action: "edit", id: params[:id]	
	end

	def verAtencion	
  	redirect_to action: "show", id: params[:id_atencion]	
	end

	def reabrirAtencion	
		@atencion_salud = FiAtencionesSalud.find(params[:id_atencion])
	  @agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
		@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Atención reabierta").first
		@agendamiento.estado = @estadoAgendamiento
		@agendamiento.save	
  	redirect_to action: "show", id: params[:id_atencion]	
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
		when 'anamnesis'
			@atencion_salud.update( anamnesis: params[:texto] )		
		end

		render :json => { :success => true } 	  
	
	end

	def update
		@atencion_salud = FiAtencionesSalud.find(params[:id])
		@atencion_salud.update( motivo_consulta: params['motivo'], examen_fisico: params['examen'], indicaciones_generales: params['indicaciones'] )

		if params[:finalizar] == 'finalizar'
			@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)	
			estado_actual = @agendamiento.estado_id
			@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Paciente atendido").first
			@agendamiento.estado = @estadoAgendamiento
			@agendamiento.fecha_final_real = DateTime.current if estado_actual != 10 #Si fue reabierta no se guarda esa hora
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
			@atenciones << [at_sal.fecha_comienzo.strftime("%Y-%m-%d %H:%M"),at_sal.persona.showName('%n%p%m'),at_sal.persona.showRut,'<a href="'<<atenciones_salud_path(at_sal)<<'">Ver atención</a>' ]
		end	

		render :json => @atenciones

	end

	def cargarAtencionesParaPago

		@fecha_inicial = params[:fecha_inicio].blank? ? DateTime.new(2015, 01, 01, 20, 0, 0) : params[:fecha_inicio]
		@fecha_final = params[:fecha_final].blank? ? DateTime.current : params[:fecha_final].to_time + 1.days

  	@query = FiAtencionesSalud
  		.select('fi_atenciones_salud.id, ag.fecha_comienzo, fi_atenciones_salud.persona_id, fi_atenciones_salud.agendamiento_id, pap.id as atencion_pagada')
			.joins('JOIN ag_agendamientos AS ag
						  ON fi_atenciones_salud.agendamiento_id = ag.id
						  JOIN pre_prestador_profesionales as ppp
						  ON ag.especialidad_prestador_profesional_id = ppp.id
						  JOIN pre_atenciones_pagadas as pap
						  ON ag.id = pap.agendamiento_id
						  LEFT JOIN pre_boletas_atenciones_pagadas as pbap
						  ON pap.id = pbap.atencion_pagada_id')
			.where('ag.estado_id = 7 AND pbap.id is null AND ppp.prestador_id = ? AND fecha_comienzo BETWEEN ? AND ?',getIdPrestador('administrativo'),@fecha_inicial,@fecha_final)
			.order('fecha_comienzo asc')

		if params[:todos_profesionales] == '1'
			@atenciones_salud = @query
		else
			@atenciones_salud = @query.where('ppp.profesional_id IN (?)',params[:profesionales])
		end	 			

		@atenciones = []

		@atenciones_salud.each do |at_sal|
			@atenciones << [at_sal.atencion_pagada,
											at_sal.fecha_comienzo.strftime("%Y-%m-%d %H:%M"),
											at_sal.agendamiento.especialidad_prestador_profesional.profesional.showName('%n%p%m'),
											at_sal.agendamiento.especialidad_prestador_profesional.profesional.showRut,											
											at_sal.agendamiento.especialidad_prestador_profesional.especialidad.nombre,
											at_sal.persona.showName('%n%p%m'),
											at_sal.persona.showRut,
											number_to_currency(at_sal.agendamiento.atencion_pagada.monto_pago_profesional, unit: "$ ", separator: '.')]
		end	

		render :json => @atenciones

	end

	def descargarCertificado
		@certificado = FiCertificados.find(params[:id])
		@at_sal = @certificado.atencion_salud		
	  @agendamiento = AgAgendamientos.find(@at_sal .agendamiento_id)

		@persona_diagnostico = FiPersonaDiagnosticos
	  	.joins(:persona_diagnosticos_atencion_salud)
	  	.joins('LEFT JOIN fi_certificado_diagnosticos as fcd ON fcd.persona_diagnostico_atencion_salud_id = fi_persona_diagnosticos_atenciones_salud.id')
	  	.select("fi_persona_diagnosticos_atenciones_salud.id,
	  					fcd.certificado_id,
	  					fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
	  					fi_persona_diagnosticos_atenciones_salud.fecha_termino,
	  					fi_persona_diagnosticos.diagnostico_id,
	  					fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
	  					fi_persona_diagnosticos_atenciones_salud.comentario,
	  					fi_persona_diagnosticos_atenciones_salud.es_cronica,
	  					fi_persona_diagnosticos_atenciones_salud.primer_diagnostico,
	  					fi_persona_diagnosticos_atenciones_salud.en_tratamiento")
	  	.where('fi_persona_diagnosticos_atenciones_salud.atencion_salud_id = ? AND fcd.certificado_id = ?',@at_sal,@certificado.id)

		nombre = l DateTime.current, format: :timestamp
	  nombre.to_s << ' Certificado ' << @agendamiento.persona.showName('%n%p%m')

		respond_to do |format|
			format.pdf do
          render :pdf => nombre,
                 :template => "atenciones_salud/certificado.pdf.erb", :locals => {:persona_diagnostico => @persona_diagnostico, :certificado => @certificado } ,
                 :disposition => 'attachment',
                 :encoding => "utf8"            
 					end               
		end
	end 

	def descargarIndicaciones
		@atencion_salud = FiAtencionesSalud.find(params[:id])
		@persona_examen = FiPersonaPrestaciones.where('atencion_salud_id = ? AND prestacion_id <= ?', params[:id],571)
	  @persona_procedimiento = FiPersonaPrestaciones.where('atencion_salud_id = ? AND prestacion_id >= ? AND es_antecedente is null', params[:id],572)
		@agendamiento = AgAgendamientos.find(params[:ag])

		@persona_diagnostico = FiPersonaDiagnosticos
	  	.joins(:persona_diagnosticos_atencion_salud)
	  	.select("fi_persona_diagnosticos_atenciones_salud.id,
	  					fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
	  					fi_persona_diagnosticos_atenciones_salud.fecha_termino,
	  					fi_persona_diagnosticos.diagnostico_id,
	  					fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
	  					fi_persona_diagnosticos_atenciones_salud.comentario,
	  					fi_persona_diagnosticos_atenciones_salud.es_cronica,
	  					fi_persona_diagnosticos_atenciones_salud.primer_diagnostico,
	  					fi_persona_diagnosticos_atenciones_salud.en_tratamiento")
	  	.where('fi_persona_diagnosticos_atenciones_salud.atencion_salud_id = ? AND fi_persona_diagnosticos_atenciones_salud.es_antecedente = 0',@atencion_salud.id)


		nombre = l DateTime.current, format: :timestamp
	  nombre.to_s << ' Indicaciones ' << @agendamiento.persona.showName('%n%p%m')

		respond_to do |format|
			format.pdf do
          render :pdf => nombre,
                 :template => "atenciones_salud/indicaciones.pdf.erb",
                 :disposition => 'attachment',
                 :encoding => "utf8"               
 					 end               
		end
	end 

	def descargarReceta
		@atencion_salud = FiAtencionesSalud.find(params[:id])
		
		@agendamiento = AgAgendamientos.find(params[:ag])

		nombre = l DateTime.current, format: :timestamp
	  nombre.to_s << ' Receta ' << @agendamiento.persona.showName('%n%p%m')

	  @persona_medicamento = FiPersonaMedicamentos.where('atencion_salud_id = ? AND es_antecedente is null', params[:id])

		respond_to do |format|
			format.pdf do
          render :pdf => nombre,
                 :template => "atenciones_salud/receta.pdf.erb",
                 :disposition => 'attachment',
                 :encoding => "utf8"               
 					 end               
		end
	end 

	def agregarDiagCert
		@tipo = params[:tipo]
		@certificado = FiCertificados.find(params[:id])
		@id = @certificado.atencion_salud

		@persona_diagnostico = FiPersonaDiagnosticos
	  	.joins(:persona_diagnosticos_atencion_salud)
	  	.joins('LEFT JOIN fi_certificado_diagnosticos as fcd ON fcd.persona_diagnostico_atencion_salud_id = fi_persona_diagnosticos_atenciones_salud.id')
	  	.select("fi_persona_diagnosticos_atenciones_salud.id,
	  					fcd.certificado_id,
	  					fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
	  					fi_persona_diagnosticos_atenciones_salud.fecha_termino,
	  					fi_persona_diagnosticos.diagnostico_id,
	  					fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
	  					fi_persona_diagnosticos_atenciones_salud.comentario,
	  					fi_persona_diagnosticos_atenciones_salud.es_cronica,
	  					fi_persona_diagnosticos_atenciones_salud.primer_diagnostico,
	  					fi_persona_diagnosticos_atenciones_salud.en_tratamiento")
	  	.where('fi_persona_diagnosticos_atenciones_salud.atencion_salud_id = ? AND (fcd.certificado_id = ?  OR fcd.certificado_id is null) AND es_antecedente != 1',@id,@certificado.id)	  

		respond_to do |format|     
    	format.js   {}
    	format.json { render :json => { :success => true } }
    end	
	end	

	def agregarInfoCertificado
		@certificado = FiCertificados.find(params[:cert])
		case params[:param]
			when 'tipo_reposo'
				@certificado.tipo_reposo = params[:valor] 
			when 'dias_reposo'
				@certificado.dias_reposo = params[:valor]  
			when 'alta'
				@certificado.alta = params[:valor] 
			when 'control'
				@certificado.control = params[:valor] 
			when 'cert_prop_1'
				@certificado.para_trabajo = params[:valor]
			when 'cert_prop_2'
				@certificado.para_colegio = params[:valor]
			when 'cert_prop_3'
				@certificado.para_juzgado = params[:valor]	
			when 'cert_prop_4'
				@certificado.para_carabinero = params[:valor]		
			when 'cert_prop_5'
				@certificado.para_otros = params[:valor]				
		end

		@certificado.save!

		respond_to do |format|   
    	format.json { render :json => { :success => true } }
    end			
	end

	def actualizarDiagCertificado		
		@certificado = FiCertificados.find(params[:cert])
		@pdat = FiPersonaDiagnosticosAtencionesSalud.find(params[:p_d]) 
		@certificado_diagnostico = FiCertificadoDiagnosticos.where('certificado_id = ? AND persona_diagnostico_atencion_salud_id = ?',params[:cert],params[:p_d]).first

		if params[:valor] == 'true'
			if !@certificado_diagnostico
				@certificado_diagnostico = FiCertificadoDiagnosticos.new
				@certificado_diagnostico.certificado = @certificado
				@certificado_diagnostico.persona_diagnostico_atencion_salud = @pdat
				@certificado_diagnostico.save!
			end	
		else
			if @certificado_diagnostico
				@certificado_diagnostico.destroy!
			end		
		end 	
		respond_to do |format|   
    	format.json { render :json => { :success => true } }
    end	

	end	

	def loadOdontogram
		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @usuario = PerPersonas.where('user_id = ?',current_user.id).first	
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 

	  #validacion de seguridad
	  @tooths = @persona.getOdontograma(params[:tipo])	
		render :json => @tooths
	end	

	def loadDiagnosis
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 
	  #validacion de seguridad

	  @endodoncia = FdEndodoncias.where('atencion_salud_id = ?',@atencion_salud.id).first
		@diagnosis = @endodoncia.getDiagnosis
		render :json => @diagnosis
	end	

	def loadEndodontic
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 
	  #validacion de seguridad

	  @endodoncia = FdEndodoncias.where('atencion_salud_id = ?',@atencion_salud.id).first
	  image = @endodoncia.pieza_dental.nil? ? '' : ActionController::Base.helpers.asset_path('dental/od_'<<@endodoncia.pieza_dental.tipo_diente.primer_digito.to_s<<'/'<<@endodoncia.pieza_dental.tipo_diente.nomenclatura<<'.jpg')
		
		if @endodoncia.pieza_dental.nil?
			texto_pieza_dental = "is null"
		else
			@pieza_dental = FdPiezasDentales.find(@endodoncia.pieza_dental.id)
			texto_pieza_dental = "= " + @pieza_dental.id.to_s
		end
		@diagnostico = FdDiagnosticos.joins(:tipo_diagnostico).where("pieza_dental_id "+texto_pieza_dental+" AND atencion_salud_id = ? AND tipo = 'endodoncia'",@atencion_salud.id).first
		diag_id = @diagnostico.tipo_diagnostico_id if @diagnostico

		render :json => {
        name: @endodoncia.pieza_dental.try(:tipo_diente).try(:nomenclatura),
        descripcion: @endodoncia.pieza_dental.try(:tipo_diente).try(:descripcion),
        image: image,
        comienzo_dolor: @endodoncia.comienzo_dolor,
        dolor: @endodoncia.dolor,
        intensidad: @endodoncia.intensidad,
        es_pulsatil: @endodoncia.es_pulsatil,
        cede_con_analgesicos: @endodoncia.cede_con_analgesicos,
        duele_al_acostarse: @endodoncia.duele_al_acostarse,
        es_posible_senalar: @endodoncia.es_posible_senalar,
        se_genera_con_calor: @endodoncia.se_genera_con_calor,
        se_genera_con_frio: @endodoncia.se_genera_con_frio,
        se_genera_con_dulce: @endodoncia.se_genera_con_dulce,
        se_genera_al_masticar: @endodoncia.se_genera_al_masticar,
        informacion_adicional: @endodoncia.informacion_adicional,
        examen_extraoral: @endodoncia.examen_extraoral,
        examen_intraoral: @endodoncia.examen_intraoral,
        examen_radiologico: @endodoncia.examen_radiologico,
        comentario: @endodoncia.comentario,
        diag: diag_id
      };
	end

	#Endodoncia
	def saveEndodontic
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:at_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 
	  @prestador = @agendamiento.especialidad_prestador_profesional.prestador 
	  @presupuesto = FdPresupuestos.where('atencion_salud_id = ?',params[:at_salud_id]).first
	  @endodoncia = FdEndodoncias.where('atencion_salud_id = ?',@atencion_salud.id).first
	  #validacion de seguridad

	  if params[:param] == "diagnostico"

			if @endodoncia.pieza_dental.nil?
				texto_pieza_dental = "is null"
			else
				@pieza_dental = FdPiezasDentales.find(@endodoncia.pieza_dental.id)
				texto_pieza_dental = "= " + @pieza_dental.id.to_s
			end

	  	if params[:value] == 0
	  		@diag_prev = FdDiagnosticos.joins("LEFT JOIN fd_tipos_diagnosticos as fdtp ON fd_diagnosticos.tipo_diagnostico_id = fdtp.id ").where("pieza_dental_id "+texto_pieza_dental+" AND atencion_salud_id = ? AND tipo = 'endodoncia'",@atencion_salud.id).first
	  		if @diag_prev
	  			@diag = FdDiagnosticos.find(@diag_prev.id)
	  			@glos_prev = FdGlosas.joins(:glosas_diagnosticos).where("diagnostico_id = ? ",@diag_prev.id).first
	  			@glos_prev.destroy! if @glos_prev
	  			@diag.destroy!
	  		end
	  	else
			  @precio = FdPrecios.joins('JOIN fd_tratamientos_tipos_diagnosticos as fdttd ON fdttd.tratamiento_id = fd_precios.tratamiento_id')
			  										.where('activo = 1 AND tipo_diagnostico_id = ? AND prestador_id = ? ',params[:value],@prestador.id).order(fecha_termino: :desc).first

				if @precio
			  	@tratamiento = FdTratamientos.find(@precio.tratamiento_id)
			  else
			  	@precio = FdPrecios.find(1)
			  	@tratamiento = FdTratamientos.find(1)
			  end	

			  @diagnostico = FdDiagnosticos.joins("LEFT JOIN fd_tipos_diagnosticos as fdtp ON fd_diagnosticos.tipo_diagnostico_id = fdtp.id ").where("pieza_dental_id "+texto_pieza_dental+" AND atencion_salud_id = ? AND tipo = 'endodoncia'",@atencion_salud.id).first
			  if @diagnostico
			  	@diagnostico.tipo_diagnostico_id = params[:value]
			  	@diagnostico.save!
			  	@glosa = FdGlosas.joins(:glosas_diagnosticos).where('diagnostico_id = ? AND presupuesto_id = ?', @diagnostico.id, @presupuesto.id).first
			  	if @glosa
			  		@glosa.precio = @precio
			  		@glosa.total = @precio.valor
			  		@glosa_diag = FdGlosasDiagnosticos.where("glosa_id = ? ", @glosa.id).first
		  			@glosa_diag.diagnostico = @diagnostico
		  			@glosa_diag.save!
			  	else
			  		@new_glosa = FdGlosas.create! :precio => @precio, :descuento => 0.0, :total => @precio.valor, :presupuesto => @presupuesto, :estado => "activo", :tratamiento => @tratamiento
			  		@new_glosa_diag = FdGlosasDiagnosticos.create! :diagnostico => @diagnostico, :glosa => @new_glosa
			  	end
			  else 
			  	@new_diag = FdDiagnosticos.create! :pieza_dental_id => @endodoncia.pieza_dental_id, :tipo_diagnostico_id => params[:value], :fecha => DateTime.current, :responsable => @usuario, :atencion_salud => @atencion_salud  
			  	@new_glosa = FdGlosas.create! :precio => @precio, :descuento => 0.0, :total => @precio.valor, :presupuesto => @presupuesto, :estado => "activo", :tratamiento => @tratamiento
			  	@new_glosa_diag = FdGlosasDiagnosticos.create! :diagnostico => @new_diag, :glosa => @new_glosa 
			  end

			end

	  else
	  	@endodoncia[params[:param]] = params[:value]
	  end
	  @endodoncia.save!

		render :json => { :success => true } 
	end

	#Endodoncia
	def saveDiagnosis
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:at_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 

	  #validacion de seguridad
	  @tipo_diente = FdTiposDientes.where('nomenclatura = ?', params[:param]).first
	  @pieza_dental = FdPiezasDentales.where('persona_id = ? AND tipo_diente_id = ?', @persona.id, @tipo_diente.id).first 
	  @endodoncia = FdEndodoncias.where('atencion_salud_id = ?',@atencion_salud.id).first
	  @test_diagnostico = FdTestDiagnostico.where('endodoncia_id = ? AND pieza_dental_id = ?',@endodoncia.id,@pieza_dental.id).first
	  @test_diagnostico.observacion = params[:value]
	  @test_diagnostico.save!
		render :json => { :success => true } 
	end

	#Endodoncia
	def addTest
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:at_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 

	  #validacion de seguridad
	  @tipo_diente = FdTiposDientes.where('nomenclatura = ?', params[:id]).first
	  @pieza_dental = FdPiezasDentales.where('persona_id = ? AND tipo_diente_id = ?', @persona.id, @tipo_diente.id).first if @tipo_diente
	  @tipo_diente_new = FdTiposDientes.where('nomenclatura = ?', params[:new_id]).first
	  @pieza_dental_new = FdPiezasDentales.where('persona_id = ? AND tipo_diente_id = ?', @persona.id, @tipo_diente_new.id).first
	  @endodoncia = FdEndodoncias.where('atencion_salud_id = ?',@atencion_salud.id).first

	  @test_diagnostico = FdTestDiagnostico.where('endodoncia_id = ? AND pieza_dental_id = ?',@endodoncia.id,@pieza_dental.id).first if @pieza_dental
	  unless @test_diagnostico
	  	@test_diagnostico = FdTestDiagnostico.new
	  	@test_diagnostico.endodoncia = @endodoncia
	  end
	  @test_diagnostico.pieza_dental = @pieza_dental_new
	  @test_diagnostico.save!

		render :json => { :success => true } 
	end

	#Endodoncia
	def deleteTest
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:at_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 

	  #validacion de seguridad
	  @tipo_diente = FdTiposDientes.where('nomenclatura = ?', params[:param]).first
	  @pieza_dental = FdPiezasDentales.where('persona_id = ? AND tipo_diente_id = ?', @persona.id, @tipo_diente.id).first 
	  @endodoncia = FdEndodoncias.where('atencion_salud_id = ?',@atencion_salud.id).first
	  @test_diagnostico = FdTestDiagnostico.where('endodoncia_id = ? AND pieza_dental_id = ?',@endodoncia.id,@pieza_dental.id).first
	  @test_diagnostico.destroy

		render :json => { :success => true } 
	end

	def selectTooth
		#validacion de seguridad pendiente

		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:at_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 
	  @prestador = @agendamiento.especialidad_prestador_profesional.prestador 
	  @presupuesto = FdPresupuestos.where('atencion_salud_id = ?',params[:at_salud_id]).first
	  @tipo_diente = FdTiposDientes.where('nomenclatura = ?', params[:param]).first
	  @pieza_dental = FdPiezasDentales.where('persona_id = ? AND tipo_diente_id = ?', @persona.id, @tipo_diente.id).first
		@endodoncia = FdEndodoncias.where('atencion_salud_id = ?',@atencion_salud.id).first
		@precio = FdPrecios.joins('JOIN fd_tratamientos_tipos_diagnosticos as fdttd ON fdttd.tratamiento_id = fd_precios.tratamiento_id')
		  										.where('activo = 1 AND tipo_diagnostico_id = ? AND prestador_id = ? ',params[:diagnostico],@prestador.id).order(fecha_termino: :desc).first
	  
	  if @precio
	  	@tratamiento = FdTratamientos.find(@precio.tratamiento_id)
	  else
	  	@precio = FdPrecios.find(1)
	  	@tratamiento = FdTratamientos.find(1)
	  end	
	 
	 	# Pieza dental null está pendiente de programación
  	if @endodoncia.pieza_dental.nil?
			texto_pieza_dental = "is null"
		else
			texto_pieza_dental = "= " + @endodoncia.pieza_dental_id.to_s
		end

		@endodoncia.pieza_dental = @pieza_dental
		@endodoncia.save!

		unless params[:diagnostico] == "undefined"
			#Se revisa si había un diagnostico para la pieza dental anterior, incluso si no había seleccionada
		  @diagnostico = FdDiagnosticos.joins("LEFT JOIN fd_tipos_diagnosticos as fdtp ON fd_diagnosticos.tipo_diagnostico_id = fdtp.id ").where("pieza_dental_id "+texto_pieza_dental+" AND atencion_salud_id = ? AND tipo = 'endodoncia'",@atencion_salud.id).first
		  if @diagnostico
		  	@diagnostico.pieza_dental = @pieza_dental
		  	@diagnostico.save!
		  else 
		  	@new_diag = FdDiagnosticos.create! :pieza_dental_id => @endodoncia.pieza_dental, :tipo_diagnostico_id => params[:diagnostico], :fecha => DateTime.current, :responsable => @usuario, :atencion_salud => @atencion_salud  
		  	@new_glosa = FdGlosas.create! :precio => @precio, :tratamiento => @tratamiento, :descuento => 0.0, :total => @precio.valor, :presupuesto => @presupuesto, :estado => "activo"
		  	@new_glosa_diag = FdGlosasDiagnosticos.create! :diagnostico => @new_diag, :glosa => @new_glosa 
		  end		
		end

		render :json => { :success => true } 
	end

	def setTest
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:at_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 

	  #validacion de seguridad
	  @tipo_diente = FdTiposDientes.where('nomenclatura = ?', params[:id]).first
	  @pieza_dental = FdPiezasDentales.where('persona_id = ? AND tipo_diente_id = ?', @persona.id, @tipo_diente.id).first 
	  @endodoncia = FdEndodoncias.where('atencion_salud_id = ?',@atencion_salud.id).first
	  @test_diagnostico = FdTestDiagnostico.where('endodoncia_id = ? AND pieza_dental_id = ?',@endodoncia.id,@pieza_dental.id).first
	  @test_diagnostico[params[:tipo]] = params[:valor]
	  @test_diagnostico.save!
		render :json => { :success => true } 
	end


	def saveDentalCharacteristic
		#validacion de seguridad pendiente

		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 
	  @prestador = @agendamiento.especialidad_prestador_profesional.prestador
	  @presupuesto = FdPresupuestos.where('atencion_salud_id = ?',params[:atencion_salud_id]).first	  
	  #esto se puede re-escribir
	  caracteristicas = {'normal' => 8, 'ausente' => 9, 'endodoncia' => 10, 'extraccion' => 11, 'implante' => 12}
	  caracteristica_id = caracteristicas[params[:tipo_carac]]
	  @precio = FdPrecios.joins('JOIN fd_tratamientos_tipos_diagnosticos as fdttd ON fdttd.tratamiento_id = fd_precios.tratamiento_id')
	  										.where('activo = 1 AND tipo_diagnostico_id = ? AND prestador_id = ? ',caracteristica_id,@prestador.id).order(fecha_termino: :desc).first
	  
	  if @precio
	  	@tratamiento = FdTratamientos.find(@precio.tratamiento_id)
	  else
	  	@precio = FdPrecios.find(1)
	  	@tratamiento = FdTratamientos.find(1)
	  end	
	 
	  @tipo_diente = FdTiposDientes.where('nomenclatura = ?', params[:tooth]).first
	  @pieza_dental = FdPiezasDentales.where('persona_id = ? AND tipo_diente_id = ?', @persona.id, @tipo_diente.id).first

	  @diagnostico = FdDiagnosticos.joins(:tipo_diagnostico).where("pieza_dental_id = ? AND atencion_salud_id = ? AND zona is null AND tipo = 'odontograma'",@pieza_dental.id,@atencion_salud.id).first
	  if @diagnostico
	  	#se revisa si hay una glosa relacionada con Pieza ausente o extracción para esa pieza dental
	  	@glosa = FdGlosas.joins('JOIN fd_glosas_diagnosticos as fgd ON fgd.glosa_id = fd_glosas.id JOIN fd_diagnosticos AS fd ON fd.id = fgd.diagnostico_id')
	  										.where('tipo_diagnostico_id IN (9,11) AND presupuesto_id = ? AND pieza_dental_id = ? ', @presupuesto.id, @pieza_dental.id).first
	  	@diagnostico.tipo_diagnostico_id = caracteristica_id
	  	@diagnostico.save!

	  	if caracteristica_id == 8 #si el estado pasa a ser Normal, se elimina el diagnostico
	  		@diagnostico.destroy! #por dependencia, tambien se elimina diagnostico_glosa
	  		if @glosa #si la glosa existe pero no tiene más referencias en fd_glosas_diagnosticos, se elimina
	  			@glosas = FdGlosasDiagnosticos.where('glosa_id = ? ', @glosa.id) 
	  			@glosa.destroy if @glosas.blank?
	  		end
	  	elsif caracteristica_id == 9 ||  caracteristica_id == 11 #si se está diagnosticando pieza ausente o extracción, se agrega una glosa si no existe
	  		unless @glosa
	  			@new_glosa = FdGlosas.create! :precio => @precio, :tratamiento => @tratamiento, :descuento => 0.0, :total => @precio.valor, :presupuesto => @presupuesto, :estado => "activo" 
	  			@glosa = @new_glosa
	  		end
	  		@gd = FdGlosasDiagnosticos.where('glosa_id = ? AND diagnostico_id = ?', @glosa.id,@diagnostico.id).first
	  		FdGlosasDiagnosticos.create! :diagnostico => @diagnostico, :glosa => @glosa unless @gd
		  else  #si no, se elimina la relación glosa_diagnostico
		  	if @glosa
		  		@gd = FdGlosasDiagnosticos.where('glosa_id = ? AND diagnostico_id = ?', @glosa.id,@diagnostico.id)
		  		@gd.destroy_all if @gd
		  		#se elimina la glosa si no quedan más referencias
		  		@glosas = FdGlosasDiagnosticos.where('glosa_id = ? ', @glosa.id) 
	  			@glosa.destroy if @glosas.blank?
		  	end
		  end 

	  else #se agrega diagnóstico
	  	unless caracteristica_id == 8 #para normal no se agrega nada
	  		@new_diag = FdDiagnosticos.create! :pieza_dental => @pieza_dental, :tipo_diagnostico_id => caracteristica_id, :fecha => DateTime.current, :responsable => @usuario, :atencion_salud => @atencion_salud  
		  	
		  	if caracteristica_id == 9 ||  caracteristica_id == 11 #solo se agregan glosas para pieza ausente o extracción
		  		#se busca glosas relacionada con estos diagnosticos para esa pieza dental
			  	@glosa = FdGlosas.joins('JOIN fd_glosas_diagnosticos as fgd ON fgd.glosa_id = fd_glosas.id JOIN fd_diagnosticos AS fd ON fd.id = fgd.diagnostico_id')
									.where('tipo_diagnostico_id in (9,11) AND presupuesto_id = ? AND pieza_dental_id = ? ', @presupuesto.id, @pieza_dental.id).first
			  	unless @glosa #si no existe, se agrega. Puede existir por caries en otra zona de la pieza
						@new_glosa = FdGlosas.create! :precio => @precio, :tratamiento => @tratamiento, :descuento => 0.0, :total => @precio.valor, :presupuesto => @presupuesto, :estado => "activo"
						@glosa = @new_glosa
					end  
			  	@new_glosa_diag = FdGlosasDiagnosticos.create! :diagnostico => @new_diag, :glosa => @glosa
			  end	
		  end
	  end

		render :json => { :success => true } 
	end 

	def saveDentalDiagnosis
		#validacion de seguridad pendiente 
		
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 
	  @prestador = @agendamiento.especialidad_prestador_profesional.prestador 
	  @presupuesto = FdPresupuestos.where('atencion_salud_id = ?',params[:atencion_salud_id]).first
	  @precio = FdPrecios.joins('JOIN fd_tratamientos_tipos_diagnosticos as fdttd ON fdttd.tratamiento_id = fd_precios.tratamiento_id')
	  										.where('activo = 1 AND tipo_diagnostico_id = ? AND prestador_id = ? ',params[:diagnostico],@prestador.id).order(fecha_termino: :desc).first
		
		if @precio
	  	@tratamiento = FdTratamientos.find(@precio.tratamiento_id)
	  else
	  	@precio = FdPrecios.find(1)
	  	@tratamiento = FdTratamientos.find(1)
	  end	

	  @tipo_diente = FdTiposDientes.where('nomenclatura = ?', params[:tooth]).first
	  @pieza_dental = FdPiezasDentales.where('persona_id = ? AND tipo_diente_id = ?', @persona.id, @tipo_diente.id).first

	  @diagnostico = FdDiagnosticos.joins(:tipo_diagnostico).where("pieza_dental_id = ? AND zona = ? AND atencion_salud_id = ? AND tipo = 'odontograma'",@pieza_dental.id,params[:tipo_cara][5..-1],@atencion_salud.id).first
	  if @diagnostico
	  	#se revisa si hay una glosa relacionada con caries para esa pieza dental
	  	@glosa = FdGlosas.joins('JOIN fd_glosas_diagnosticos as fgd ON fgd.glosa_id = fd_glosas.id JOIN fd_diagnosticos AS fd ON fd.id = fgd.diagnostico_id')
	  										.where('tipo_diagnostico_id = 2 AND presupuesto_id = ? AND pieza_dental_id = ? ', @presupuesto.id, @pieza_dental.id).first
	  	@diagnostico.tipo_diagnostico_id = params[:diagnostico]
	  	@diagnostico.save!

	  	if params[:diagnostico] == 1 #si el estado pasa a ser Sano, se elimina el diagnostico
	  		@diagnostico.destroy! #por dependencia, tambien se elimina diagnostico_glosa
	  		if @glosa #si la glosa existe pero no tiene más referencias en fd_glosas_diagnosticos, se elimina
	  			@glosas = FdGlosasDiagnosticos.where('glosa_id = ? ', @glosa.id) 
	  			@glosa.destroy if @glosas.blank?
	  		end
	  	elsif params[:diagnostico] == 2 #si se está diagnosticando una carie, se agrega una glosa si no existe
	  		unless @glosa
	  			@new_glosa = FdGlosas.create! :precio => @precio, :tratamiento => @tratamiento, :descuento => 0.0, :total => @precio.valor, :presupuesto => @presupuesto, :estado => "activo" 
	  			@glosa = @new_glosa
	  		end
	  		@gd = FdGlosasDiagnosticos.where('glosa_id = ? AND diagnostico_id = ?', @glosa.id,@diagnostico.id).first
	  		FdGlosasDiagnosticos.create! :diagnostico => @diagnostico, :glosa => @glosa unless @gd
		  else  #si no es una carie, se elimina la relación glosa_diagnostico
		  	if @glosa
		  		@gd = FdGlosasDiagnosticos.where('glosa_id = ? AND diagnostico_id = ?', @glosa.id,@diagnostico.id)
		  		@gd.destroy_all if @gd
		  		#se elimina la glosa si no quedan más referencias
		  		@glosas = FdGlosasDiagnosticos.where('glosa_id = ? ', @glosa.id) 
	  			@glosa.destroy if @glosas.blank?
		  	end
		  end 

	  else #se agrega diagnostico
	  	unless params[:diagnostico] == 1 #para sano no se agrega nada
		  	@new_diag = FdDiagnosticos.create! :pieza_dental => @pieza_dental, :tipo_diagnostico_id => params[:diagnostico], :zona => params[:tipo_cara][5..-1], :fecha => DateTime.current, :responsable => @usuario, :atencion_salud => @atencion_salud  
		  	
		  	if params[:diagnostico] == 2 #solo se agregan glosas para caries
		  		#se busca glosas relacionada con caries para esa pieza dental
			  	@glosa = FdGlosas.joins('JOIN fd_glosas_diagnosticos as fgd ON fgd.glosa_id = fd_glosas.id JOIN fd_diagnosticos AS fd ON fd.id = fgd.diagnostico_id')
									.where('tipo_diagnostico_id = 2 AND presupuesto_id = ? AND pieza_dental_id = ? ', @presupuesto.id, @pieza_dental.id).first
			  	unless @glosa #si no existe, se agrega. Puede existir por caries en otra zona de la pieza
						@new_glosa = FdGlosas.create! :precio => @precio, :tratamiento => @tratamiento, :descuento => 0.0, :total => @precio.valor, :presupuesto => @presupuesto, :estado => "activo"
						@glosa = @new_glosa
					end  
			  	@new_glosa_diag = FdGlosasDiagnosticos.create! :diagnostico => @new_diag, :glosa => @glosa
			  end	
		  end
	  end

		render :json => { :success => true } 
	end 

	def loadIndice
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 

	  #validacion de seguridad
	  @periodoncia = FdPeriodoncias.where('atencion_salud_id = ?',@atencion_salud.id).first
		@indice = @persona.getIndice(params[:tipo],@periodoncia.id)
		render :json => @indice
		
	end

	def saveIndice
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:at_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 

	  #validacion de seguridad
	  @tipo_diente = FdTiposDientes.where('nomenclatura = ?', params[:tooth]).first
	  @pieza_dental = FdPiezasDentales.where('persona_id = ? AND tipo_diente_id = ?', @persona.id, @tipo_diente.id).first
	  @periodoncia = FdPeriodoncias.where('atencion_salud_id = ?',@atencion_salud.id).first

	  @periodonciaindice = FdPeriodonciaIndices.where('pieza_dental_id = ? AND periodoncia_id = ? and indice = ?',@pieza_dental,@periodoncia,params[:tipo]).first

	  @periodonciaindice[params[:cara]] = params[:valor]
	  @periodonciaindice.save!
	
		render :json => { :success => true } 

	end

	def loadPeriodontic
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 

	  @diagnostico = FdDiagnosticos.joins(:tipo_diagnostico).where("atencion_salud_id = ? AND tipo = 'periodoncia'",@atencion_salud.id).first
		diag_id = @diagnostico.tipo_diagnostico_id if @diagnostico

	  #validacion de seguridad
	  @periodoncia = FdPeriodoncias.where('atencion_salud_id = ?',@atencion_salud.id).first
	  render :json => {
        id: @periodoncia.id,
        atencion_salud_id: @atencion_salud.id,
        comentario: @periodoncia.comentario,
        diagnostico: diag_id
      };
		
	end

	def loadTratamiento
		#validacion de seguridad pendiente
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 
	  @presupuesto = FdPresupuestos.where('atencion_salud_id = ?',params[:atencion_salud_id]).first

	  @pres_ant = FdPresupuestos.joins(:atencion_salud => :agendamiento).where("ag_agendamientos.persona_id = ? AND fd_presupuestos.estado IN ('En proceso','Propuesto')", @persona.id).first
	  if @pres_ant
	  	@presupuesto = @pres_ant
	  end

	  @glosas = FdGlosas.select("DISTINCT fd_glosas.id,ftp.nomenclatura,fd_glosas.total,fd_glosas.descuento,ftd.id as tipo_diag_id, ftd.nombre,ftd.tipo,ft.id as 'id_tr',ft.descripcion,fd_glosas.estado").
	  									joins(:glosas_diagnosticos, :precio ,'INNER JOIN fd_diagnosticos AS fd ON fd_glosas_diagnosticos.diagnostico_id = fd.id','LEFT JOIN fd_piezas_dentales AS fpd ON fpd.id = fd.pieza_dental_id',
	  												'LEFT JOIN fd_tipos_dientes AS ftp ON ftp.id = fpd.tipo_diente_id','INNER JOIN fd_tipos_diagnosticos AS ftd ON ftd.id = fd.tipo_diagnostico_id ',
	  												'LEFT JOIN fd_tratamientos as ft ON ft.id = fd_glosas.tratamiento_id').where("presupuesto_id = ? ",@presupuesto.id)

		render :json => @glosas
		
	end

	def savePeriodontic
		#validacion de seguridad pendiente
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:at_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 
	  @prestador = @agendamiento.especialidad_prestador_profesional.prestador 
	  @presupuesto = FdPresupuestos.where('atencion_salud_id = ?',params[:at_salud_id]).first


	  @periodoncia = FdPeriodoncias.where('atencion_salud_id = ?',@atencion_salud.id).first
	  if params[:param] == "diagnostico"
	  	if params[:value] == 0
	  		@diag_prev = FdDiagnosticos.joins("LEFT JOIN fd_tipos_diagnosticos as fdtp ON fd_diagnosticos.tipo_diagnostico_id = fdtp.id ").where("atencion_salud_id = ? AND tipo = 'periodoncia'",@atencion_salud.id).first
	  		if @diag_prev
	  			@diag = FdDiagnosticos.find(@diag_prev.id)
	  			@glos_prev = FdGlosas.joins(:glosas_diagnosticos).where("diagnostico_id = ? ",@diag_prev.id).first
	  			@glos_prev.destroy! if @glos_prev
	  			@diag.destroy!
	  		end
	  	else
			  @precio = FdPrecios.joins('JOIN fd_tratamientos_tipos_diagnosticos as fdttd ON fdttd.tratamiento_id = fd_precios.tratamiento_id')
			  										.where('activo = 1 AND tipo_diagnostico_id = ? AND prestador_id = ? ',params[:value],@prestador.id).order(fecha_termino: :desc).first

				if @precio
			  	@tratamiento = FdTratamientos.find(@precio.tratamiento_id)
			  else
			  	@precio = FdPrecios.find(1)
			  	@tratamiento = FdTratamientos.find(1)
			  end	

			  @diagnostico = FdDiagnosticos.joins("LEFT JOIN fd_tipos_diagnosticos as fdtp ON fd_diagnosticos.tipo_diagnostico_id = fdtp.id ").where("atencion_salud_id = ? AND tipo = 'periodoncia'",@atencion_salud.id).first
			  if @diagnostico
			  	@diagnostico.tipo_diagnostico_id = params[:value]
			  	@diagnostico.save!
			  	@glosa = FdGlosas.joins(:glosas_diagnosticos).where('diagnostico_id = ? AND presupuesto_id = ?', @diagnostico.id, @presupuesto.id).first
			  	if @glosa
			  		@glosa.precio = @precio
			  		@glosa.total = @precio.valor
			  		@glosa_diag = FdGlosasDiagnosticos.where("glosa_id = ? ", @glosa.id).first
		  			@glosa_diag.diagnostico = @diagnostico
		  			@glosa_diag.save!
			  	else
			  		@new_glosa = FdGlosas.create! :precio => @precio, :descuento => 0.0, :total => @precio.valor, :presupuesto => @presupuesto, :estado => "activo", :tratamiento => @tratamiento
			  		@new_glosa_diag = FdGlosasDiagnosticos.create! :diagnostico => @diagnostico, :glosa => @new_glosa
			  	end
			  else 
			  	@new_diag = FdDiagnosticos.create! :tipo_diagnostico_id => params[:value], :fecha => DateTime.current, :responsable => @usuario, :atencion_salud => @atencion_salud  
			  	@new_glosa = FdGlosas.create! :precio => @precio, :descuento => 0.0, :total => @precio.valor, :presupuesto => @presupuesto, :estado => "activo", :tratamiento => @tratamiento
			  	@new_glosa_diag = FdGlosasDiagnosticos.create! :diagnostico => @new_diag, :glosa => @new_glosa 
			  end

			end

	  else
	  	@periodoncia[params[:param]] = params[:value]
	  end
	  @periodoncia.save!
	
	  render :json => { :success => true } 
	end

	def deleteGlosa
		#validacion de seguridad pendiente
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:at_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 
	  @prestador = @agendamiento.especialidad_prestador_profesional.prestador 
	  @presupuesto = FdPresupuestos.where('atencion_salud_id = ?',params[:at_salud_id]).first

  	if params[:tipo] != 'odontograma'
			texto_pieza_dental = "is null"
		else
			@tipo_diente = FdTiposDientes.where('nomenclatura = ?', params[:tooth]).first
	  	@pieza_dental = FdPiezasDentales.where('persona_id = ? AND tipo_diente_id = ?', @persona.id, @tipo_diente.id).first
			texto_pieza_dental = "= " + pieza_dental.id.to_s
		end

	  @presupuestos = FdPresupuestos.joins(:atencion_salud => :agendamiento).where("ag_agendamientos.persona_id = ? AND fd_presupuestos.estado IN ('En proceso','Propuesto')", @persona.id)
	  @id_presupuestos = @presupuestos.map { |pres| pres.id } 

	 	@glosa = FdGlosas.joins('JOIN fd_glosas_diagnosticos as fgd ON fgd.glosa_id = fd_glosas.id JOIN fd_diagnosticos AS fd ON fd.id = fgd.diagnostico_id JOIN fd_tipos_diagnosticos as ftd ON ftd.id = fd.tipo_diagnostico_id')
	  										.where('presupuesto_id IN (?) AND pieza_dental_id ' + texto_pieza_dental + ' AND tipo = ? ', @id_presupuestos, params[:tipo]).first
	  @glosa.estado = "eliminado"
	  @glosa.save!

	  render :json => { :success => true } 

	end

	def reintegrarGlosa
		#validacion de seguridad pendiente
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:at_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 
	  @prestador = @agendamiento.especialidad_prestador_profesional.prestador 
	  @presupuesto = FdPresupuestos.where('atencion_salud_id = ?',params[:at_salud_id]).first

	  if params[:tipo] != 'odontograma'
			texto_pieza_dental = "is null"
		else
			@tipo_diente = FdTiposDientes.where('nomenclatura = ?', params[:tooth]).first
	  	@pieza_dental = FdPiezasDentales.where('persona_id = ? AND tipo_diente_id = ?', @persona.id, @tipo_diente.id).first
			texto_pieza_dental = "= " + pieza_dental.id.to_s
		end

	  @presupuestos = FdPresupuestos.joins(:atencion_salud => :agendamiento).where("ag_agendamientos.persona_id = ? AND fd_presupuestos.estado IN ('En proceso','Propuesto')", @persona.id)
	  @id_presupuestos = @presupuestos.map { |pres| pres.id } 

	 	@glosa = FdGlosas.joins('JOIN fd_glosas_diagnosticos as fgd ON fgd.glosa_id = fd_glosas.id JOIN fd_diagnosticos AS fd ON fd.id = fgd.diagnostico_id JOIN fd_tipos_diagnosticos as ftd ON ftd.id = fd.tipo_diagnostico_id')
	  										.where('presupuesto_id IN (?) AND pieza_dental_id ' + texto_pieza_dental + ' AND tipo = ? ', @id_presupuestos, params[:tipo] ).first
	  @glosa.estado = "activo"
	  @glosa.save!

	  render :json => { :success => true } 

	end

	def loadGlosaTratamiento
		#validacion de seguridad pendiente
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 
	  @prestador = @agendamiento.especialidad_prestador_profesional.prestador
	  @presupuesto = FdPresupuestos.where('atencion_salud_id = ?',params[:atencion_salud_id]).first

	  @presupuestos = FdPresupuestos.joins(:atencion_salud => :agendamiento).where("ag_agendamientos.persona_id = ? AND fd_presupuestos.estado IN ('En proceso','Propuesto')", @persona.id)

	  @atenciones = @presupuestos.map { |pres| pres.atencion_salud.id } 

	  @glosa_tratamiento = FdTratamientosTiposDiagnosticos.select('DISTINCT fd_tratamientos_tipos_diagnosticos.id, fd.tipo_diagnostico_id, fd_tratamientos.descripcion, fd_tratamientos.id as tr_id,valor').joins(:tratamiento,:tipo_diagnostico)
	  											.joins("JOIN fd_diagnosticos as fd ON fd.tipo_diagnostico_id = fd_tratamientos_tipos_diagnosticos.tipo_diagnostico_id JOIN fd_precios as fp ON fp.tratamiento_id = fd_tratamientos.id ")
	  											.where("atencion_salud_id IN (?) AND activo = 1 AND prestador_id = ? ", @atenciones, @prestador.id )

		render :json => @glosa_tratamiento 
		
	end

	def updateTreatment
		#validacion de seguridad pendiente
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
		@atencion_salud = FiAtencionesSalud.find(params[:at_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @profesional = @agendamiento.especialidad_prestador_profesional.profesional 
	  @prestador = @agendamiento.especialidad_prestador_profesional.prestador 
	  @presupuesto = FdPresupuestos.where('atencion_salud_id = ?',params[:at_salud_id]).first

	  @precio = FdPrecios.joins('JOIN fd_tratamientos_tipos_diagnosticos as fdttd ON fdttd.tratamiento_id = fd_precios.tratamiento_id')
	  										.where('activo = 1 AND fdttd.tratamiento_id = ? AND prestador_id = ? ', params[:treatment], @prestador.id ).order(fecha_termino: :desc).first

	  #Debiera estar el tratamiento pk lo está eligiendo,podría no estar el precio, se debería reprogramar la consulta aquí y en las otras funciones											
	  @tratamiento = FdTratamientos.find(params[:treatment])
	  @glosa = FdGlosas.find(params[:glosa_id])

	  @glosa.tratamiento = @tratamiento
	  @glosa.precio = @precio
	  @glosa.total = @precio.valor
	  @glosa.save!

		render :json => { :success => true } 
	end 

	def loadPresupuesto
		#validacion de seguridad pendiente
		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @presupuesto = FdPresupuestos.where('atencion_salud_id = ?',params[:atencion_salud_id]).first
	  @pres_ant = FdPresupuestos.joins(:atencion_salud => :agendamiento).where("ag_agendamientos.persona_id = ? AND fd_presupuestos.estado IN ('En proceso','Propuesto')", @persona.id).first
	  if @pres_ant
	  	@presupuesto = @pres_ant
	  end
	  render :json => @presupuesto 
	end

	def loadCuotas
		#validacion de seguridad pendiente
		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona
	  @presupuesto = FdPresupuestos.where('atencion_salud_id = ?',params[:atencion_salud_id]).first
	  @pres_ant = FdPresupuestos.joins(:atencion_salud => :agendamiento).where("ag_agendamientos.persona_id = ? AND fd_presupuestos.estado IN ('En proceso','Propuesto')", @persona.id).first
	  if @pres_ant
	  	@presupuesto = @pres_ant
	  end

	  @cuotas = FdPagos.where('presupuesto_id = ?',@presupuesto.id)
	  render :json => @cuotas
	end

	def savePresupuesto
		#validacion de seguridad pendiente
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
	  @presupuesto = FdPresupuestos.where('atencion_salud_id = ?',params[:atencion_salud_id]).first
	  @atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona

	  @pres_ant = FdPresupuestos.joins(:atencion_salud => :agendamiento).where("ag_agendamientos.persona_id = ? AND fd_presupuestos.estado IN ('En proceso','Propuesto')", @persona.id).first
	  if @pres_ant
	  	@presupuesto = @pres_ant
	  end

	  @presupuesto.valor = params[:valor]
	  @presupuesto.descuento = params[:descuento]
	  @presupuesto.total = params[:total]
	  @presupuesto.save!
	  numero_cuotas = @presupuesto.numero_cuotas
  
  	monto_cuota = params[:total]/numero_cuotas
  	@cuotas = FdPagos.where('presupuesto_id = ? ',  @presupuesto.id)

	  if @cuotas
	  	@cuotas.destroy_all
	  end
  	for i in 1..numero_cuotas
 			FdPagos.create! :monto => @presupuesto.total/numero_cuotas.to_f , :presupuesto => @presupuesto, :numero => i
		end


	  render :json => { :success => true } 
	end

	def saveCuotas
		#validacion de seguridad pendiente
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
	  @presupuesto = FdPresupuestos.where('atencion_salud_id = ?',params[:atencion_salud_id]).first
	  @atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona

	  @pres_ant = FdPresupuestos.joins(:atencion_salud => :agendamiento).where("ag_agendamientos.persona_id = ? AND fd_presupuestos.estado IN ('En proceso','Propuesto')", @persona.id).first
	  if @pres_ant
	  	@presupuesto = @pres_ant
	  end

	  @presupuesto.iguales = params[:iguales]
	  @presupuesto.numero_cuotas = params[:cuotas]
	  @presupuesto.save!

	  @cuotas = FdPagos.where('presupuesto_id = ?',  @presupuesto.id)

	  if params[:cuotas] != 'null' 
		  if @cuotas
		  	@cuotas.destroy_all
		  end
	  	for i in 1..params[:cuotas]
	 			FdPagos.create! :monto => @presupuesto.total/params[:cuotas].to_f , :presupuesto => @presupuesto, :numero => i
			end
		end

	  render :json => { :success => true } 
	end

	def actualizarPago
		#validacion de seguridad pendiente
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first	
	  @presupuesto = FdPresupuestos.where('atencion_salud_id = ?',params[:atencion_salud_id]).first
	  @atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
		@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona = @agendamiento.persona

	  @pres_ant = FdPresupuestos.joins(:atencion_salud => :agendamiento).where("ag_agendamientos.persona_id = ? AND fd_presupuestos.estado IN ('En proceso','Propuesto')", @persona.id).first
	  if @pres_ant
	  	@presupuesto = @pres_ant
	  end

	  @pago = FdPagos.where('numero = ? AND presupuesto_id = ?',params[:numero_pago],@presupuesto.id).first
	  @pago.monto = params[:monto]
	  @pago.save!

	  render :json => { :success => true } 
	end

	def update_dental
		@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])

		if params[:finalizar] == 'finalizar'
			@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)	
			estado_actual = @agendamiento.estado_id
			@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Paciente atendido").first
			@agendamiento.estado = @estadoAgendamiento
			@agendamiento.fecha_final_real = DateTime.current if estado_actual != 10 #Si fue reabierta no se guarda esa hora
			@agendamiento.save
		end	

		render :json => { :success => true } 
	end

	def imprimirPresupuesto

		@presupuesto = FdPresupuestos.find(params[:presupuesto_id])
		@atencion_salud = FiAtencionesSalud.find(@presupuesto.atencion_salud_id)
		@cuotas = FdPagos.where('presupuesto_id = ?', @presupuesto.id)


		nombre = l DateTime.current, format: :timestamp
	  nombre.to_s << ' Presupuesto Dental ' << @atencion_salud.agendamiento.persona.showName('%n%p%m')

		respond_to do |format|
			format.pdf do
          render :pdf => nombre,
                 :template => "atenciones_salud/dental/presupuesto.pdf.erb", :locals => {:presupuesto => @presupuesto, :cuotas => @cuotas },
                 :disposition => 'attachment',
                 :encoding => "utf8"               
 					 end               
		end
		
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