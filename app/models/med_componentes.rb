class MedComponentes < ActiveRecord::Base

	has_many :medicamentos, :class_name => 'MedMedicamentos', :foreign_key => 'laboratorio_id'
	has_many :medicamento_componente, :class_name => 'MedMedicamentosComponentes', :foreign_key => 'componente_id'

	private
  def app_params
    params.require(:list).permit( :id, :nombre, :descripcion, :medicamentos, :medicamento_componente)
  end
	
end
