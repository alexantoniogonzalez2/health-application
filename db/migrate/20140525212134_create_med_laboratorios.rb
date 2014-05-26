class CreateMedLaboratorios < ActiveRecord::Migration
  def change
    create_table :med_laboratorios do |t|
    	t.text :nombre
      t.text :descripcion

      t.timestamps
    end
  end
end
