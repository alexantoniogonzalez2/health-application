class CreateFiCertificadoDiagnosticos < ActiveRecord::Migration[5.0]
  def change
    create_table :fi_certificado_diagnosticos do |t|
    	t.references :certificado #certificado_id
    	t.references :persona_diagnostico_atencion_salud, index: { name: :persona_diagnostico_at_sal_ficd} #persona_diagnostico_atencion_salud_id 
      t.timestamps null: false
    end
  end
end
