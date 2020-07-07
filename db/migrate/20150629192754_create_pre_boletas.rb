class CreatePreBoletas < ActiveRecord::Migration[5.0]
  def change
    create_table :pre_boletas do |t|
    	t.references :especialidad_prestador_profesional #especialidad_prestador_profesional_id
      t.references :responsable #responsable_id
    	t.integer :monto
    	t.string :estado
      t.datetime :fecha
    	t.datetime :fecha_desde
    	t.datetime :fecha_hasta
      t.timestamps null: false
    end
  end
end
