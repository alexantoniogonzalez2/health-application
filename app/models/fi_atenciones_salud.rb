class FiAtencionesSalud < ActiveRecord::Base

  self.table_name = "fi_atenciones_salud"
  
	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :ficha_tipo, :class_name => 'FiFichaTipos'
	belongs_to :agendamiento, :class_name => 'AgAgendamientos'
	has_many :persona_examenes, :class_name => 'FiPersonaExamenes', :foreign_key => 'atencion_salud_id'
	has_many :persona_medicamentos, :class_name => 'FiPersonaMedicamentos', :foreign_key => 'atencion_salud_id' 
	has_many :persona_diagnosticos_atencion_salud, :class_name => 'FiPersonaDiagnosticosAtencionesSalud', :foreign_key => 'atencion_salud_id' 
  has_many :certificados, :class_name => 'FiCertificados', :foreign_key => 'atencion_salud_id'
  has_many :interconsultas, :class_name => 'FiInterconsultas', :foreign_key => 'atencion_salud_id'
  has_many :persona_metricas, :class_name => 'FiPersonaMetricas', :foreign_key => 'atencion_salud_id'

  validates :motivo_consulta, presence: true, length: { minimum: 5 }

 	private
  def app_params
    params.require(:list).permit(:persona,
  								:ficha_tipo,
  								:agendamiento,
  								:persona_examenes,
  								:persona_medicamentos,
  								:persona_diagnosticos_atencion_salud,
  								:certificados,
  								:interconsultas,
  								:persona_metricas,
  								:motivo_consulta,
  								:indicaciones_generales,

  								)
  end

end
