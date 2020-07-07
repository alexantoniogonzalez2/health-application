class CreateOcuGrandesGrupos < ActiveRecord::Migration[5.0]
  def change
    create_table :ocu_grandes_grupos do |t|
    	t.string :nombre
    	t.string :codigo
      t.timestamps
    end
  end
end
