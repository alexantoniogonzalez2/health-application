class MedDiagnosticos < ActiveRecord::Base
	has_many :persona_diagnosticos, :class_name => 'FiPersonaDiagnosticos', :foreign_key => 'diagnostico_id'
  belongs_to :grupo, :class_name => 'MedGrupos'

  def formato_lista
    {
      'id'        => id,
      'text'      => codigo_cie10 + ' ' + nombre      
    }

  end
  

  private
  def app_params
    params.require(:list).permit(
                                  :codigo_cie10,
                  							  :descripcion,
                                  :frecuente,
                                  :nodo_terminal,
                                  :grupo,
                  							  :id,
                  							  :nombre,
                  							  :persona_diagnosticos )
  end
							  
end
