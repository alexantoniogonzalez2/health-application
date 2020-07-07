class MedDiagnosticosBloques < ActiveRecord::Base

	belongs_to :capitulo, :class_name => 'MedDiagnosticosCapitulos'
	#has_many :grupos, :class_name => 'MedDiagnosticosGrupos', :foreign_key => 'bloque_id' 

  private
  def app_params
    params.require(:list).permit(:id,:nombre,:codigo,:capitulo)
  end
end
