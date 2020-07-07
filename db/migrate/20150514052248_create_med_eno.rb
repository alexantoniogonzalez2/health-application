class CreateMedEno < ActiveRecord::Migration[5.0]
  def change
    create_table :med_eno do |t|
    	t.string :nombre
      t.timestamps null: false
    end
  end
end
