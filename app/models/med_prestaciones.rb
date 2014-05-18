class MedPrestaciones < ActiveRecord::Base

	has_many :persona_prestaciones, :class_name => 'FiPersonaPrestaciones', :foreign_key => 'prestacion_id' 
	belongs_to :subgrupo, :class_name => 'MedPrestacionesSubgrupos'
	

  def formato_prestaciones

  {
    'id'        => id,
    'text'      => codigo_fonasa + ' ' + nombre      
  }

  end 

  private
  def app_params
    params.require(:list).permit( :id, 
    															:codigo_fonasa,
    														  :subgrupo_id,
    														  :nombre,
    														  :descripcion,
    														  :persona_prestaciones,
    														  :subgrupo)
  end

end
