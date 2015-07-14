class MedPrestaciones < ActiveRecord::Base

	has_many :persona_prestaciones, :class_name => 'FiPersonaPrestaciones', :foreign_key => 'prestacion_id' 
	belongs_to :subgrupo, :class_name => 'MedPrestacionesSubgrupos'
  has_many :atenciones_pagadas, :class_name => 'PreAtencionesPagadas', :foreign_key => 'prestacion_id'
  has_many :especialidades, :class_name => 'ProEspecialidades', :foreign_key => 'prestacion_id'
	

  def formato_prestaciones

  {
    'id'        => id,
    'text'      => nombre      
  }

  end 

  private
  def app_params
    params.require(:list).permit( :id, 
    															:codigo_fonasa,
    														  :nombre,
    														  :descripcion,
    														  :persona_prestaciones,
    														  :subgrupo,
                                  :atenciones_pagadas,
                                  :especialidades)
  end

end
