class CreateMedPrestacionesGrupos < ActiveRecord::Migration[5.0]
  def change
    create_table :med_prestaciones_grupos do |t|

    	t.string :nombre
      t.text :descripcion
      t.timestamps
    end
  end
end
