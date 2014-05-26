class MedMedicamentosMetatipos < ActiveRecord::Base

	has_many :medicamentos_tipos, :class_name => 'MedMedicamentosTipos', :foreign_key => 'medicamento_metatipo_id'

	private
  def app_params
    params.require(:list).permit( :id, :nombre, :medicamentos_tipos )
  end

end
