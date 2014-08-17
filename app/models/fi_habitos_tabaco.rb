class FiHabitosTabaco < ActiveRecord::Base

	self.table_name = "fi_habitos_tabaco"
	belongs_to :persona, :class_name => 'PerPersonas'

	private
  def app_params
    params.require(:list).permit(:id,:persona,:fecha_inicio,:fecha_final,:cigarros_por_dia,:paquetes_agno)
  end

end
