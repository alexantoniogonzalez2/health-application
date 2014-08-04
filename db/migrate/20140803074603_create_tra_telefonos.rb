class CreateTraTelefonos < ActiveRecord::Migration
  def change
    create_table :tra_telefonos do |t|
    	t.integer :codigo
    	t.integer :numero

      t.timestamps
    end
  end
end
