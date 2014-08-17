class CreateFiPersonasVacunas < ActiveRecord::Migration
  def change
    create_table :fi_personas_vacunas do |t|
    	t.references :persona #persona_id
    	t.references :vacuna #vacuna_id
      t.timestamps
    end
  end
end
