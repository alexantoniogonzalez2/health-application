class CreateFiPersonasVacunas < ActiveRecord::Migration[5.0]
  def change
    create_table :fi_personas_vacunas do |t|
    	t.references :persona #persona_id
    	t.references :vacuna #vacuna_id
    	t.datetime :fecha
    	t.integer :numero_vacuna
    	t.references :atencion_salud #atencion_salud_id
      t.timestamps
    end
  end
end
