class CreateFdGlosas < ActiveRecord::Migration[5.0]
  def change
    create_table :fd_glosas do |t|
    	t.references :tratamiento
      t.references :precio
      t.decimal :descuento, :precision => 10, :scale => 2 
      t.integer :total
      t.references :presupuesto
      t.string :estado
      t.timestamps null: false
    end
  end
end
