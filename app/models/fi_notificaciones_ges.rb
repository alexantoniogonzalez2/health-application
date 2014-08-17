class FiNotificacionesGes < ActiveRecord::Base

	belongs_to :persona_diagnostico_atencion_salud, :class_name => 'FiPersonaDiagnosticosAtencioneSalud'
	belongs_to :persona_conocimiento, :class_name => 'PerPersonas'

  private
  def app_params
    params.require(:list).permit(:id,:persona_diagnostico_atencion_salud,:persona_conocimiento,:confirmacion_diagnostica,:fecha_notificacion)
  end

end
