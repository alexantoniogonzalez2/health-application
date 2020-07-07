class CreateFiHabitosTabaco < ActiveRecord::Migration[5.0]
  def change
    create_table :fi_habitos_tabaco do |t|
    	t.references :persona #persona_id
    	t.datetime :fecha_inicio
    	t.datetime :fecha_final
    	t.integer :cigarros_por_dia
    	t.decimal :paquetes_agno, :precision => 10, :scale => 2
      t.timestamps
    end
  end
end
