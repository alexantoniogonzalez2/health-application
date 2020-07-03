class CreateFdPresupuestos < ActiveRecord::Migration
  def change
    create_table :fd_presupuestos do |t|
    	t.references :atencion_salud
    	t.string :estado
    	t.integer :valor
      t.decimal :descuento, :precision => 10, :scale => 2 
      t.integer :total
      t.integer :pagado
      t.integer :pendiente
      t.integer :numero_cuotas, :default => 3
      t.iguales :boolean, :default => 1
      t.timestamps null: false
    end
  end
end
