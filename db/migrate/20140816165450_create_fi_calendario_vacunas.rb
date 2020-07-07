class CreateFiCalendarioVacunas < ActiveRecord::Migration[5.0]
  def change
    create_table :fi_calendario_vacunas do |t|
    	t.references :vacuna #vacuna_id
    	t.string :edad 
    	t.integer :numero_vacuna
    	t.integer :agno
      t.timestamps
    end
  end
end
