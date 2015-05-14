class MedEnoDiagnostico < ActiveRecord::Base
	self.table_name = "med_eno_diagnostico"	
	belongs_to :diagnostico, :class_name => 'MedDiagnosticos'
	belongs_to :eno, :class_name => 'MedEno'

	private
  def app_params
    params.require(:list).permit(:id,:eno,:diagnostico,:tipo_vigilancia,:frecuencia_notificacion,:prioridad)
  end
end
