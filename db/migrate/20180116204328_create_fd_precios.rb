class CreateFdPrecios < ActiveRecord::Migration[5.0]
  def change
    create_table :fd_precios do |t|
    	t.references :tratamiento
      t.integer :valor
      t.datetime :fecha_inicio
      t.datetime :fecha_termino
      t.boolean :activo
      t.string :descripcion
      t.references :prestador
      t.timestamps null: false
    end
  end
end
