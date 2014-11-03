class MedPrestacionesSubgrupos < ActiveRecord::Base

	has_many :prestaciones, :class_name => 'MedPrestaciones', :foreign_key => 'subgrupo_id' 
	belongs_to :grupos, :class_name => 'MedPrestacionesGrupos'	

  private
  def app_params
    params.require(:list).permit( :id,   															
    														  :nombre,
    														  :descripcion,
    														  :prestaciones,
    														  :grupos)
  end

end
