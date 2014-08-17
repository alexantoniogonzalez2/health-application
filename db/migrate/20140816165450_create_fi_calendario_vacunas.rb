class CreateFiCalendarioVacunas < ActiveRecord::Migration
  def change
    create_table :fi_calendario_vacunas do |t|
    	t.references :vacuna #vacuna_id
    	t.integer :edad 
    	t.integer :numero_vacuna
    	t.text :grupo_objetivo
    	t.integer :agno
    	t.text :protege_contra 
      t.timestamps
    end
  end
end
