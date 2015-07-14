class CreatePreAtencionesPagadas < ActiveRecord::Migration
  def change
    create_table :pre_atenciones_pagadas do |t|
    	t.references :agendamiento #agendamiento_id
    	t.references :prestacion #prestacion_id
    	t.integer :valor
    	t.integer :bonificacion_financiador
    	t.integer :aporte_seguro_complementario
    	t.integer :excedentes
    	t.integer :copago_beneficiario
    	t.datetime :fecha_pago
      t.integer :monto_pago_profesional
    	t.references :prevision_salud #prevision_salud_id
      t.timestamps null: false
    end
  end
end
