class CreateAgAgendamientoEstados < ActiveRecord::Migration
  def change
    create_table :ag_agendamiento_estados do |t|
    	t.text		:nombre
    		
      t.timestamps
    end
  end
end
