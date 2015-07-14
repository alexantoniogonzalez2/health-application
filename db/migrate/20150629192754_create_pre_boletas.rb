class CreatePreBoletas < ActiveRecord::Migration
  def change
    create_table :pre_boletas do |t|
    	t.references :profesional #profesional_id
    	t.references :prestador #prestador_id
    	t.integer :monto
    	t.string :estado
    	t.datetime :fecha_desde
    	t.datetime :fecha_hasta
      t.timestamps null: false
    end
  end
end
