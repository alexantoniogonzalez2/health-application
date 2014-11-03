class CreateOcuGrandesGrupos < ActiveRecord::Migration
  def change
    create_table :ocu_grandes_grupos do |t|
    	t.string :nombre
    	t.string :codigo
      t.timestamps
    end
  end
end
