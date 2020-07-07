class CreateFiPersonaAntecedentesGinecologicos < ActiveRecord::Migration[5.0]
  def change
    create_table :fi_persona_antecedentes_ginecologicos do |t|
    	t.references :persona #persona_id
    	t.datetime :fecha_menarquia
    	t.datetime :fecha_menopausia
    	t.integer :duracion_menstruacion
    	t.integer :frecuencia_promedio
    	t.datetime :fecha_ultimo_PAP
    	t.datetime :fecha_ultima_mamografia
    	t.integer :numero_gestaciones
    	t.integer :numero_partos
    	t.integer :numero_abortos
      t.timestamps
    end
  end
end
