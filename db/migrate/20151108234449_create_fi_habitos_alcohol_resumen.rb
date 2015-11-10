class CreateFiHabitosAlcoholResumen < ActiveRecord::Migration
  def change
    create_table :fi_habitos_alcohol_resumen do |t|
    	t.references :persona #persona_id
    	t.string :frecuencia
    	t.string :tipo
    	t.string :cantidad
      t.timestamps null: false
    end
  end
end
