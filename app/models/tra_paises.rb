class TraPaises < ActiveRecord::Base

	has_many :direcciones, :class_name => 'TraDirecciones', :foreign_key => 'pais_id'
	has_many :paises_contagio, :class_name => 'FiNotificacionesEno', :foreign_key => 'pais_contagio_id'
	has_many :personas, :class_name => 'PerPersonas', :foreign_key => 'pais_nacionalidad_id'

	private
  def app_params
    params.require(:list).permit(:id,:nombre,:direcciones,:personas)
  end

end
