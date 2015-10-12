class MedMedicamentosTipos < ActiveRecord::Base

	has_many :medicamentos, :class_name => 'MedMedicamentos', :foreign_key => 'medicamento_tipo_id'
	belongs_to :medicamento_metatipo, :class_name => 'MedMedicamentosMetatipos'

	private
  def app_params
    params.require(:list).permit( :id, :nombre, :unidad, :medicamentos, :medicamento_metatipo )
  end

end
