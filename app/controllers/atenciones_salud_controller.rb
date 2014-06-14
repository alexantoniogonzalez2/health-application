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

		@atencion_salud = FiAtencionesSalud.find(params[:id])
	  @agendamiento = AgAgendamientos.find(@atencion_salud.agendamiento_id)
	  @persona_diagnostico = FiPersonaDiagnosticos.joins(:persona_diagnosticos_atencion_salud).where('fi_persona_diagnosticos_atenciones_salud.atencion_salud_id' => params[:id])

	  @diagnosticos = MedDiagnosticos.where('frecuente = ?',true)
	  @estados_diagnostico = MedDiagnosticoEstados.all
	  
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

	def update
	  @atencion_salud = FiAtencionesSalud.find(params[:id])
	  
	  @atencion_salud.update_attributes(params[:atencion_salud].permit(:indicaciones_generales,:motivo_consulta,:examen_fisico))

	 	@agendamiento =  AgAgendamientos.find(@atencion_salud.agendamiento_id)	
		@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Paciente atendido").first
		@agendamiento.agendamiento_estado = @estadoAgendamiento
		@agendamiento.save

	  redirect_to root_path
	  
	end

	def crearAtencion	

		@agendamiento =  AgAgendamientos.find(params[:id])
		@persona = @agendamiento.persona

		@atencion_salud = FiAtencionesSalud.new(:agendamiento_id => params[:id],:persona_id => @persona.id, :tipo_ficha_id => 1)				
	  @atencion_salud.save(:validate => false)

		@estadoAgendamiento = AgAgendamientoEstados.where("nombre = ?","Paciente siendo atendido").first
		@agendamiento.agendamiento_estado = @estadoAgendamiento
		@agendamiento.save

	 	redirect_to :action => "edit", :id => @atencion_salud.id
	
	end

	def editarAtencion		

  	redirect_to :action => "edit", :id =>params[:id]
	
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
