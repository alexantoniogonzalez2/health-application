class FiPersonaDiagnosticosAtencionesSalud < ActiveRecord::Base

  self.table_name = "fi_persona_diagnosticos_atenciones_salud"
  
	belongs_to :persona_diagnostico, :class_name => 'FiPersonaDiagnosticos'
	belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'
	belongs_to :estado_diagnostico, :class_name => 'MedDiagnosticoEstados'
  has_many :notificaciones_ges, :class_name => 'FiNotificacionesGes', :foreign_key => 'person_diagnostico_atencion_salud_id'
  has_many :notificaciones_eno, :class_name => 'FiNotificacionesEno', :foreign_key => 'person_diagnostico_atencion_salud_id'
  has_many :interconsultas, :class_name => 'FiInterconsultas', :foreign_key => 'person_diagnostico_atencion_salud_id'

  private
  def app_params
    params.require(:list).permit(:atencion_salud,
                  							 :estado_diagnostico,
                                 :es_cronica,
                  				  		 :id,
                                 :fecha_inicio,
                                 :fecha_termino,
                  							 :persona_diagnostico,
                  							 :prioridad,
                                 :en_tratamiento,
                                 :primer_diagnostico,
                                 :comentario,
                                 :notificaciones_ges,
                                 :notificaciones_eno,
                                 :interconsultas,
                                 :es_antecedente)
  end
								
end
