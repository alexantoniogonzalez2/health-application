class PrePrestadoresDirecciones < ActiveRecord::Base

	belongs_to :direccion, :class_name => 'TraDirecciones'
	belongs_to :prestador, :class_name => 'PrePrestadores'

	private
  def app_params
    params.require(:list).permit(:id,:direccion,:prestador)
  end

end
