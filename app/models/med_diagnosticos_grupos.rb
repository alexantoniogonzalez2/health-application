class MedDiagnosticosGrupos < ActiveRecord::Base

	#belongs_to :bloque, :class_name => 'MedDiagnosticosBloques' 
	has_many :diagnosticos, :class_name => 'MedDiagnosticos', :foreign_key => 'grupo_id' 

  private
  def app_params
    params.require(:list).permit(:id,:nombre,:codigo,:diagnosticos)
  end

end
