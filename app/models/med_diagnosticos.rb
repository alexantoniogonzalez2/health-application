class MedDiagnosticos < ActiveRecord::Base

	has_many :persona_diagnosticos, :class_name => 'FiPersonaDiagnosticos', :foreign_key => 'diagnostico_id'
  has_many :problemas_salud_auge, :class_name => 'MedProblemasSaludAuge', :foreign_key => 'diagnostico_id'
  has_many :enfermedades_notificacion_obligatoria, :class_name => 'MedEnfermedadesNotificacionObligatoria', :foreign_key => 'diagnostico_id'
  belongs_to :grupo, :class_name => 'MedDiagnosticosGrupos'

  def formato_lista

    {'id' => id,'text' => codigo_cie10 + ' ' + nombre}

  end  

  def esAuge
    true
  end  

  private
  def app_params
    params.require(:list).permit(:codigo_cie10,:descripcion,:frecuente,:nodo_terminal,:grupo,:id,:nombre,:persona_diagnosticos,:problemas_salud_auge,:enfermedades_notificacion_obligatoria)
  end
							  
end
