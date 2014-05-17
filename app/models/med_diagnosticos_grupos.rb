class MedDiagnosticosGrupos < ActiveRecord::Base

	has_many :diagnosticos, :class_name => 'MedDiagnosticos', :foreign_key => 'grupo_id' 	

  private
  def app_params
    params.require(:list).permit(:codigo, :id, :nombre, :diagnosticos)
  end

end
