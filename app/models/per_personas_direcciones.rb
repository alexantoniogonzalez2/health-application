class PerPersonasDirecciones < ActiveRecord::Base

	belongs_to :persona, :class_name => 'PerPersonas'
	belongs_to :direccion, :class_name => 'TraDirecciones'

	private
  def app_params
    params.require(:list).permit(
    															:id,
    															:fecha_inicio,
    															:fecha_termino,
    															:persona,
    															:direccion)
  end
end
