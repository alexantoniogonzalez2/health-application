class MedMedicamentos < ActiveRecord::Base
	has_many :persona_medicamentos, :class_name => 'FiPersonaMedicamentos', :foreign_key => 'persona_id' 

  private
  def app_params
    params.require(:list).permit(:codigo, :descripcion, :id, :nombre, :persona_medicamentos, :principio_activo)
  end

end
