class CreatePreBoletasAtencionesPagadas < ActiveRecord::Migration
  def change
    create_table :pre_boletas_atenciones_pagadas do |t|
    	t.references :boleta #boleta_id
    	t.references :atencion_pagada # atencion_pagada_id
      t.timestamps null: false
    end
  end
end
