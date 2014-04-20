class CreateMedGrupos < ActiveRecord::Migration
  def change
    create_table :med_grupos do |t|
    	t.text :codigo
    	t.text :nombre
      t.timestamps
    end
  end
end
