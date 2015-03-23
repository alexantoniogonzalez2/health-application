class CreateMedAlergias < ActiveRecord::Migration
  def change
    create_table :med_alergias do |t|
    	t.string :nombre
    	t.boolean :normal
      t.timestamps
    end
  end
end
