class CreateOcuOcupaciones < ActiveRecord::Migration
  def change
    create_table :ocu_ocupaciones do |t|
    	t.string :nombre
    	t.string :codigo
    	t.references :subgrupo #subgrupo_id
      t.timestamps
    end
  end
end
