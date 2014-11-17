class MedPrestacionesSubgrupos < ActiveRecord::Base

	has_many :prestaciones, :class_name => 'MedPrestaciones', :foreign_key => 'subgrupo_id' 
	belongs_to :grupo, :class_name => 'MedPrestacionesGrupos'	

  private
  def app_params
    params.require(:list).permit( :id,   															
    														  :nombre,
    														  :descripcion,
    														  :prestaciones,
    														  :grupo)
  end

end
