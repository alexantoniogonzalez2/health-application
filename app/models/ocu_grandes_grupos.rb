class OcuGrandesGrupos < ActiveRecord::Base
	has_many :grupos, :class_name => 'OcuGrupos', :foreign_key => 'gran_grupo_id'

	private
  def app_params
    params.require(:list).permit(:id, :nombre, :codigo, :grupos)
  end  
end
