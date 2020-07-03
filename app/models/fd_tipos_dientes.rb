class FdTiposDientes < ActiveRecord::Base
	has_many :piezas_dentales, :class_name => 'FiPiezasDentales', :foreign_key => 'tipo_diente_id'
  def app_params
    params.require(:list).permit(:id,:nomenclatura,:primer_digito,:segundo_digito,:descripcion,:tipo_denticion,:grupo)
  end
end
