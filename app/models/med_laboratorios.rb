class MedLaboratorios < ActiveRecord::Base

	has_many :medicamentos, :class_name => 'MedMedicamentos', :foreign_key => 'laboratorio_id'

	private
  def app_params
    params.require(:list).permit( :id, :nombre, :descripcion, :medicamentos )
  end
	
end
