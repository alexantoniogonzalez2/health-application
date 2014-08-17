class CreateFiHabitosTabaco < ActiveRecord::Migration
  def change
    create_table :fi_habitos_tabaco do |t|
    	t.references :persona #persona_id
    	t.datetime :fecha_inicio
    	t.datetime :fecha_final
    	t.integer :cigarros_por_dia
    	t.integer :paquetes_agno
      t.timestamps
    end
  end
end
