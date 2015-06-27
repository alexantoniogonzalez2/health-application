class CreateFiCertificadoDiagnosticos < ActiveRecord::Migration
  def change
    create_table :fi_certificado_diagnosticos do |t|
    	t.references :certificado #certificado_id
    	t.references :persona_diagnostico_atencion_salud #persona_diagnostico_atencion_salud_id 
      t.timestamps null: false
    end
  end
end
