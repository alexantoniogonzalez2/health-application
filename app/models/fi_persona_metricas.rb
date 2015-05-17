class FiPersonaMetricas < ActiveRecord::Base
	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :metricas, :class_name => 'FiMetricas'
	belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'

  def formato_metricas

    {
      'valor'      => valor 
    }

  end 

  def showFecha
    return fecha.strftime('%Y-%m-%d')
  end  

  private
  def app_params
    params.require(:list).permit(:atencion_salud,:id,:metrica,:persona,:fecha,:valor,:caracteristica)
  end
								
end
