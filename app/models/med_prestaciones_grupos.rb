class MedPrestacionesGrupos < ActiveRecord::Base

	has_many :subgrupos, :class_name => 'MedPrestacionesSubgrupos', :foreign_key => 'grupo_id' 	

  private
  def app_params
    params.require(:list).permit( :id,     															
    														  :nombre,
    														  :descripcion,
    														  :subgrupos)
  end

end
