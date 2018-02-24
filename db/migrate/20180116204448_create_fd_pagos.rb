class CreateFdPagos < ActiveRecord::Migration
  def change
    create_table :fd_pagos do |t|
    	t.references :presupuesto
    	t.references :responsable
      t.integer :monto 
      t.string :comentario
      t.datetime :fecha_pago
      t.timestamps null: false
    end
  end
end
