class CreateAgAgendamientoLogEstados < ActiveRecord::Migration[5.0]
  def change
    create_table :ag_agendamiento_log_estados do |t|
    	t.references :responsable #responsable_id
    	t.references :agendamiento_estado #agendamiento_estado_id
    	t.references :agendamiento #agendamiento_id
    	t.datetime :fecha
    end
  end
end
