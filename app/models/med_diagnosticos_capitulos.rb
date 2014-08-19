class MedDiagnosticosCapitulos < ActiveRecord::Base

	has_many :bloques, :class_name => 'MedDiagnosticosBloques', :foreign_key => 'capitulo_id'
	has_many :agendamientos_control,	:class_name => 'AgAgendamientos', :foreign_key => 'capitulo_cie10_control_id'
 
  private
  def app_params
    params.require(:list).permit(:id,:nombre,:codigo,:descripcion,:bloques,:agendamientos_control)
  end 

end
