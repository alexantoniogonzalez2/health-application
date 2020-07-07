class CreateTraTelefonos < ActiveRecord::Migration[5.0]
  def change
    create_table :tra_telefonos do |t|
    	t.integer :codigo
    	t.integer :numero

      t.timestamps
    end
  end
end
