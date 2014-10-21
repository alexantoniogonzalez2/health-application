class FiPersonaMedicamentos < ActiveRecord::Base
	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :medicamento, :class_name => 'MedMedicamentos'
	belongs_to :persona_diagnostico, :class_name => 'FiPersonaDiagnosticos'
	belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'
  belongs_to :persona_vacuna, :class_name => 'FiPersonasVacunas'
  def getPosologia
    posologia = '-'
    if cantidad and periodicidad and duracion and [1,2,3,4].include? medicamento.medicamento_tipo.id 
      unidad = medicamento.medicamento_tipo.unidad.to_s
      posologia = cantidad.to_s<<' '<<unidad<<' cada '<<periodicidad.to_s<<' horas durante '<<duracion.to_s<<' día(s). Total: '<<total.to_s<<' '<<unidad
      if medicamento.medicamento_tipo.id == 4
        posologia<<' ('<<(total/20).to_s<<' ml)' 
      end 
    end  
    return posologia
  end  
  private
  def app_params
    params.require(:list).permit(:id,:persona,:medicamento,:persona_diagnostico,:persona_vacuna,:fecha_final,:fecha_inicio,:atencion_salud,:cantidad,:periodicidad,:duracion,:total)
  end
end
