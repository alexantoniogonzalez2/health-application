class CreateMedPrestacionesSubgrupos < ActiveRecord::Migration
  def change
    create_table :med_prestaciones_subgrupos do |t|

    	t.string :nombre
      t.string :descripcion
      t.references :grupo #grupo_id

      t.timestamps
    end
  end
end
