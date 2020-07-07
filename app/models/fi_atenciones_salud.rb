class FiAtencionesSalud < ActiveRecord::Base

  self.table_name = "fi_atenciones_salud"
  
	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :ficha_tipo, :class_name => 'FiFichaTipos', optional: true
	belongs_to :agendamiento, :class_name => 'AgAgendamientos'
	has_many :persona_examenes, :class_name => 'FiPersonaExamenes', :foreign_key => 'atencion_salud_id'
	has_many :persona_medicamentos, :class_name => 'FiPersonaMedicamentos', :foreign_key => 'atencion_salud_id' 
	has_many :persona_diagnosticos_atencion_salud, :class_name => 'FiPersonaDiagnosticosAtencionesSalud', :foreign_key => 'atencion_salud_id' 
  has_many :certificados, :class_name => 'FiCertificados', :foreign_key => 'atencion_salud_id'
  has_many :interconsultas, :class_name => 'FiInterconsultas', :foreign_key => 'atencion_salud_id'
  has_many :persona_metricas, :class_name => 'FiPersonaMetricas', :foreign_key => 'atencion_salud_id'
  has_many :persona_vacunas, :class_name => 'FiPersonaVacunas', :foreign_key => 'atencion_salud_id'
  has_many :diagnosticos_dentales, :class_name => 'FdDiagnosticos', :foreign_key => 'atencion_salud_id' 
  has_many :endodoncia, :class_name => 'FdEndodoncias', :foreign_key => 'atencion_salud_id' 
  has_many :periodoncias, :class_name => 'FdPeriodoncias', :foreign_key => 'atencion_salud_id'  
  has_many :presupuestos_dentales, :class_name => 'FdPresupuestos', :foreign_key => 'atencion_salud_id'  
 
 	private
  def app_params
    params.require(:list).permit(:persona,:ficha_tipo,:agendamiento,:persona_examenes,:persona_medicamentos,:persona_diagnosticos_atencion_salud,:certificados,:interconsultas,:persona_metricas,
      :motivo_consulta,:examen_fisico,:persona_vacunas,:indicaciones_generales,:anamnesis,:diagnosticos_dentales,:endodoncia,:periodoncias)
  end

end
