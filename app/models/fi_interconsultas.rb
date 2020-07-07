class FiInterconsultas < ActiveRecord::Base

  belongs_to :prestador_destino, :class_name => 'PrePrestadores'
	belongs_to :persona_diagnostico_atencion_salud, :class_name => 'FiPersonaDiagnosticosAtencionesSalud'
  belongs_to :especialidad, :class_name => 'ProEspecialidades' 
  belongs_to :persona_conocimiento, :class_name => 'PerPersonas'

  private
  def app_params
    params.require(:list).permit(:id,:persona_diagnostico_atencion_salud,:fecha_solicitud,:prestador_destino,:prestador_destino_texto,:especialidad,:persona_conocimiento,:proposito,:proposito_otro,:comentario)
  end
								
end
