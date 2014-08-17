class MedEnfermedadesNotificacionObligatoria < ActiveRecord::Base

	belongs_to :diagnostico, :class_name => 'MedDiagnosticos'

	private
  def app_params
    params.require(:list).permit(:id,:nombre,:diagnostico,:tipo_vigilancia,:frecuencia_notificacion,:prioridad)
  end

end
