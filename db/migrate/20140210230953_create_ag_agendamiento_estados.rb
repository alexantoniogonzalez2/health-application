class CreateAgAgendamientoEstados < ActiveRecord::Migration
  def change
    create_table :ag_agendamiento_estados do |t|
    	t.string		:nombre
    		
      t.timestamps
    end
  end
end
