class CreateMedPrestacionesSubgrupos < ActiveRecord::Migration[5.0]
  def change
    create_table :med_prestaciones_subgrupos do |t|
    	t.string :nombre
      t.text :descripcion
      t.references :grupo #grupo_id
      t.timestamps
    end
  end
end
