class TraProfesionesOficios < ActiveRecord::Base

	has_many :personas_profesiones_oficios, :class_name => 'PerPersonasProfesionesOficios', :foreign_key => 'profesion_oficio_id'

	private
  def app_params
    params.require(:list).permit(:id, :nombre)
  end
  
end
