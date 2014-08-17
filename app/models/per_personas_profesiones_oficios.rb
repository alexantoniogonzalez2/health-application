class PerPersonasProfesionesOficios < ActiveRecord::Base

	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :profesion_oficio, :class_name => 'TraProfesionesOficios'

	private
  def app_params
    params.require(:list).permit(:id,:fecha_inicio,:fecha_termino,:persona,:profesion_oficio)
  end
  
end
