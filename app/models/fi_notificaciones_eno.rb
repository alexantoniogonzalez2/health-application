class FiNotificacionesEno < ActiveRecord::Base

	self.table_name = "fi_notificaciones_eno"
	belongs_to :persona_diagnostico_atencion_salud, :class_name => 'FiPersonaDiagnosticosAtencioneSalud'
	belongs_to :pais_contagio, :class_name => 'TraPaises'

  private
  def app_params
    params.require(:list).permit(:id,:persona_diagnostico_atencion_salud,:fecha_notificacion,:fecha_primeros_sintomas,:confirmacion_diagnostica,:antecedentes_vacunacion,:pais_contagio,:embarazo,:semanas_gestacion,:tbc)
  end

end
