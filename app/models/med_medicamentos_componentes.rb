class MedMedicamentosComponentes < ActiveRecord::Base

	belongs_to :medicamento, :class_name => 'PerPersonas'
	belongs_to :componente, :class_name => 'MedDiagnosticos'

	private
  def app_params
    params.require(:list).permit( :id, :medicamento, :componente, :relacion )
  end

end
