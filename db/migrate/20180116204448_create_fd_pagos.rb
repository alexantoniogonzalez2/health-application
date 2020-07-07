class CreateFdPagos < ActiveRecord::Migration[5.0]
  def change
    create_table :fd_pagos do |t|
    	t.references :presupuesto
    	t.references :responsable
      t.decimal :monto, :precision => 10, :scale => 2 
      t.string :comentario
      t.datetime :fecha_pago
      t.timestamps null: false
      t.integer :numero
      t.boolean :pagado, :default => 0
    end
  end
end
