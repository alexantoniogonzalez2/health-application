class FiPersonaDiagnosticosAtencionesSalud < ActiveRecord::Base

  self.table_name = "fi_persona_diagnosticos_atenciones_salud"
  
	belongs_to :persona_diagnostico, :class_name => 'FiPersonaDiagnosticos'
	belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'
	belongs_to :estado_diagnostico, :class_name => 'MedDiagnosticoEstados'
  has_many :notificaciones_ges, :class_name => 'FiNotificacionesGes', :foreign_key => 'persona_diagnostico_atencion_salud_id'
  has_many :notificaciones_eno, :class_name => 'FiNotificacionesEno', :foreign_key => 'persona_diagnostico_atencion_salud_id'
  has_many :interconsultas, :class_name => 'FiInterconsultas', :foreign_key => 'persona_diagnostico_atencion_salud_id'
  has_many :certificado_diagnosticos, :class_name => 'FiCertificadoDiagnosticos', :foreign_key => 'persona_diagnostico_atencion_salud_id'
  has_many :persona_prestacion_diagnosticos, :class_name => 'FiPersonaPrestacionDiagnosticos', :foreign_key => 'persona_diagnostico_atencion_salud_id'
  has_many :persona_medicamento_diagnosticos, :class_name => 'FiPersonaMedicamentoDiagnostico', :foreign_key => 'persona_diagnostico_atencion_salud_id'
  has_many :reabrir_estado_diagnostico, :class_name => 'FiReabrirEstadoDiagnostico', :foreign_key => 'persona_diagnostico_atencion_salud_id'

  def editarEnReabrir
    respuesta = true
    fecha_comienzo = atencion_salud.agendamiento.fecha_comienzo_real
    fecha_final = atencion_salud.agendamiento.fecha_final_real
    respuesta = false if created_at > fecha_comienzo and created_at < fecha_final
    return respuesta
  end 

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
                                 :es_antecedente,
                                 :certificado_diagnosticos,
                                 :persona_prestacion_diagnosticos,
                                 :persona_medicamento_diagnosticos,
                                 :reabrir_estado_diagnostico,
                                 :es_ultima_actualizacion,
                                 :created_at)
  end
								
end
