class AtencionesSaludController < ApplicationController

	
	def new		
		@atencion_salud = FiAtencionesSalud.new
	end

	def create		
		#@atencion_salud = FiAtencionesSalud.new(:motivo_consulta => params[:atencion_salud][:motivo_consulta],
		#																				:indicaciones_generales => params[:atencion_salud][:indicaciones_generales], )

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
	  @examenes = MedExamenes.all
	end

	def update
	  @atencion_salud = FiAtencionesSalud.find(params[:id])
	 
	  if @atencion_salud.update_attributes(params[:atencion_salud])
	    redirect_to :action => "show", :id => @atencion_salud.id
	  else
	    render 'edit'
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
