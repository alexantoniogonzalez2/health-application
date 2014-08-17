class CreateMedAlergias < ActiveRecord::Migration
  def change
    create_table :med_alergias do |t|
    	t.text :nombre
      t.timestamps
    end
  end
end
