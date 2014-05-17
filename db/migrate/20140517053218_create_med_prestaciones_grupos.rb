class CreateMedPrestacionesGrupos < ActiveRecord::Migration
  def change
    create_table :med_prestaciones_grupos do |t|

    	t.text :nombre
      t.text :descripcion
      t.timestamps
    end
  end
end
