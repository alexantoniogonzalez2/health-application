class FiPersonaPrestaciones < ActiveRecord::Base

	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :prestacion, :class_name => 'MedPrestaciones'
	belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'
  belongs_to :prestador, :class_name => 'PrePrestadores'
  has_many :persona_prestacion_diagnosticos, :class_name => 'FiPersonaPrestacionDiagnosticos', :foreign_key => 'persona_prestacion_id'

  def getFechaPrestacion
    fecha_formato = ''
    if fecha_prestacion
      fecha_formato = fecha_prestacion.strftime('%Y-%m-%d')
    end
    return fecha_formato  
  end

  private
  def app_params
    params.require(:list).permit(:id,:persona,:prestacion,:atencion_salud,:fecha_prestacion,:prestador,:es_antecedente,:prestador_texto,:persona_prestacion_diagnosticos)
  end

end
