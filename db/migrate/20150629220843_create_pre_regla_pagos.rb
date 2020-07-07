class CreatePreReglaPagos < ActiveRecord::Migration[5.0]
  def change
    create_table :pre_regla_pagos do |t|
    	t.string :tipo
    	t.references :prestador #prestador_id
    	t.references :especialidad_prestador_profesional #especialidad_prestador_profesional_id
    	t.decimal :porcentaje, :precision => 10, :scale => 2
    	t.datetime :fecha_inicio
    	t.datetime :fecha_termino
      t.timestamps null: false
    end
  end
end
