class CreateMedComponentes < ActiveRecord::Migration
  def change
    create_table :med_componentes do |t|
    	t.text :nombre
      t.text :descripcion

      t.timestamps
    end
  end
end