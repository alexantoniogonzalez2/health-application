class MedMedicamentos < ActiveRecord::Base

  has_many :vacunas_medicamentos, :class_name => 'MedVacunasMedicamentos'
	has_many :persona_medicamentos, :class_name => 'FiPersonaMedicamentos', :foreign_key => 'persona_id' 
	has_many :medicamento_componente, :class_name => 'MedMedicamentosComponentes', :foreign_key => 'medicamento_id'
	belongs_to :medicamento_tipo, :class_name => 'MedMedicamentosTipos'
	belongs_to :laboratorio, :class_name => 'MedLaboratorios'

	def formato_medicamentos
  {
    'id'        => id,
    'text'      => nombre,
    'tipo'		  => medicamento_tipo_id     
  }
  end 
  def getUnidad
    return :medicamento_tipo.unidad
  end  

  private
  def app_params
    params.require(:list).permit(:id,:nombre,:descripcion,:codigo_isp,:medicamento_tipo,:cantidad,:laboratorio,:persona_medicamentos,:medicamento_componente,:vacunas_medicamentos,:es_nombre_farmaco)
  end

end
