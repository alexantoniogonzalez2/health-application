class FiPersonaMedicamentos < ActiveRecord::Base

	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :medicamento, :class_name => 'MedMedicamentos'
	belongs_to :persona_diagnostico, :class_name => 'FiPersonaDiagnosticos'
	belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'

  private
  def app_params
    params.require(:list).permit(:id,
    														 :persona,
    														 :medicamento,
    														 :persona_diagnostico,
    														 :fecha_final,
    														 :fecha_inicio,    														 
    														 :atencion_salud,
    														 :cantidad,
    														 :periodicidad,
    														 :duracion,
    														 :total )
  end

end
