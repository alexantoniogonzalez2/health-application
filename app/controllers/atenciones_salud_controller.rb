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
	  					fi_persona_diagnosticos.persona_id,
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
	  					fi_persona_diagnosticos.persona_id,
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
	  @persona_frec_car = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],5).first
	  @persona_frec_res = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],6).first
	  @persona_temp = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],7).first
	  @persona_sat= FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],8).first

	  @estatura = @persona_estatura ? @persona_estatura.valor : ''
	  @peso = @persona_peso ? @persona_peso.valor : ''
	  @presion = @persona_presion ? @persona_presion.valor : ''
	  @imc = @persona_imc ? @persona_imc.valor : ''
	  @frec_car = @persona_frec_car ? @persona_frec_car.valor : ''
	  @frec_res = @persona_frec_res ? @persona_frec_res.valor : ''
	  @temp = @persona_temp ? @persona_temp.valor : ''
	  @sat = @persona_sat ? @persona_sat.valor : '' 
	  @car_frec_car = @persona_frec_car ? @persona_frec_car.caracteristica : ''
	  @car_frec_res = @persona_frec_res ? @persona_frec_res.caracteristica : ''
	  @car_temp = @persona_temp ? @persona_temp.caracteristica : ''
	  @car_sat = @persona_sat ? @persona_sat.caracteristica : ''
	  @car_presion = @persona_presion ? @persona_presion.caracteristica : ''
 
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
	  	.where('fi_persona_diagnosticos_atenciones_salud.atencion_salud_id = ? AND fcd.certificado_id = ? ',@at_sal,@certificado.id)

		nombre = l DateTime.current, format: :timestamp
	  nombre.to_s << ' Certificado ' << @agendamiento.persona.showRut 

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
	  @persona_procedimiento = FiPersonaPrestaciones.where('atencion_salud_id = ? AND prestacion_id >= ?', params[:id],572)
		@agendamiento = AgAgendamientos.find(params[:ag])

		nombre = l DateTime.current, format: :timestamp
	  nombre.to_s << ' Indicaciones ' << @agendamiento.persona.showRut

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
	  nombre.to_s << ' Receta ' << @agendamiento.persona.showRut

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
	  	.where('fi_persona_diagnosticos_atenciones_salud.atencion_salud_id = ? AND (fcd.certificado_id = ?  OR fcd.certificado_id is null)',@id,@certificado.id)	  

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
