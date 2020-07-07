class CreateAgAgendamientoEstados < ActiveRecord::Migration[5.0]
  def change
    create_table :ag_agendamiento_estados do |t|
    	t.string		:nombre
    		
      t.timestamps
    end
  end
end
