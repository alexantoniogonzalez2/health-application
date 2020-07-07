class CreateFiReabrirEstadoDiagnostico < ActiveRecord::Migration[5.0]
  def change
    create_table :fi_reabrir_estado_diagnostico do |t|
    	t.references :persona_diagnostico_atencion_salud, index: { name: :persona_diagnostico_at_sal_fired }  #persona_diagnostico_atencion_salud_id
    	t.references :estado_diagnostico #estado_diagnostico_id    
    	t.datetime :fecha_cambio
      t.timestamps null: false
    end
  end
end
