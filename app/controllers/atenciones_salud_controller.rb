class AtencionesSaludController < ApplicationController

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

		@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",current_user.id).first
		@agendamientos= AgAgendamientos.where( "especialidad_prestador_profesional_id = ? AND fecha_comienzo BETWEEN ? AND ? ", @especialidad_prestador_profesional, Date.today, Date.tomorrow )
		@actualizaciones = AgAgendamientoLogEstados
			.joins(:agendamiento)
			.select("ag_agendamiento_log_estados.fecha,
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
	  @fecha_comienzo_atencion = @agendamiento.fecha_comienzo_real

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
	  	.where('fi_persona_diagnosticos_atenciones_salud.atencion_salud_id' => params[:id])
	  
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
	  					fpdas.en_tratamiento,
	  					fpdas.primer_diagnostico")
	  	.where('fi_persona_diagnosticos.persona_id = ? AND fpdas.atencion_salud_id != ? 
	  					AND fpdas.es_cronica = 0 AND ag_agendamientos.fecha_comienzo_real < ?',
	  					 @atencion_salud.persona.id,params[:id],@fecha_comienzo_atencion)

	  @antecedentes = FiPersonaDiagnosticos
	  	.joins(:persona_diagnosticos_atencion_salud)
	  	.select("fi_persona_diagnosticos_atenciones_salud.id,
	  					fi_persona_diagnosticos_atenciones_salud.fecha_inicio,
	  					fi_persona_diagnosticos_atenciones_salud.fecha_termino,
	  					fi_persona_diagnosticos.diagnostico_id,
	  					fi_persona_diagnosticos_atenciones_salud.estado_diagnostico_id,
	  					fi_persona_diagnosticos_atenciones_salud.comentario,
	  					fi_persona_diagnosticos_atenciones_salud.es_cronica,
	  					fi_persona_diagnosticos_atenciones_salud.en_tratamiento,
	  					fi_persona_diagnosticos_atenciones_salud.primer_diagnostico")
	  	.where('persona_id = ? AND fi_persona_diagnosticos_atenciones_salud.atencion_salud_id != ? 
	  					AND fi_persona_diagnosticos_atenciones_salud.es_cronica = 1', @atencion_salud.persona.id,params[:id])	

	  @diagnosticos = MedDiagnosticos.where('frecuente = ?',true)
	  @estados_diagnostico = MedDiagnosticoEstados.all
	  @prestadores = PrePrestadores.all
	  @especialidades = ProEspecialidades.all
	  @paises = TraPaises.all
	  
	  # Se debe mejorar las consultas para cargar examenes y procedimientos en base a grupos o subgrupos
	  @persona_examen = FiPersonaPrestaciones.where('atencion_salud_id = ? AND prestacion_id <= ?', params[:id],571)
	  @persona_procedimiento = FiPersonaPrestaciones.where('atencion_salud_id = ? AND prestacion_id >= ?', params[:id],572)
	  @persona_medicamento = FiPersonaMedicamentos.where('atencion_salud_id = ?', params[:id])

	  @persona_estatura = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],1).first
	  @persona_peso = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],2).first
	  @persona_presion = FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],3).first
	  @persona_imc= FiPersonaMetricas.where("atencion_salud_id = ? AND metrica_id = ?",params[:id],4).first

	  @estatura = @persona_estatura ? @persona_estatura.valor : ''
	  @peso = @persona_peso ? @persona_peso.valor : ''
	  @presion = @persona_presion ? @persona_presion.valor : ''
	  @imc = @persona_imc ? @persona_imc.valor : ''

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

  	redirect_to :action => "edit", :id =>params[:id]
	
	end

	def reabrirAtencion	
		@atencion_salud = FiAtencionesSalud.find(params[:id_atencion])
	  @agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
		@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Paciente siendo atendido").first
		@agendamiento.agendamiento_estado = @estadoAgendamiento
		@agendamiento.save	
  	redirect_to :action => "edit", :id =>params[:id_atencion]	
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
		@atencion_salud.update( motivo_consulta: params['atencion_salud']['motivo_consulta'], examen_fisico: params['atencion_salud']['examen_fisico'], indicaciones_generales: params['atencion_salud']['indicaciones_generales'] )

		if params[:finalizar] 
			@agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)	
			@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Paciente atendido").first
			@agendamiento.agendamiento_estado = @estadoAgendamiento
			@agendamiento.fecha_final_real = DateTime.current
			@agendamiento.save
		end

		redirect_to root_path

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
