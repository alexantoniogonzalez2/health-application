class CreateMedComponentes < ActiveRecord::Migration[5.0]
  def change
    create_table :med_componentes do |t|
    	t.string :nombre
      t.string :descripcion

      t.timestamps
    end
  end
end
