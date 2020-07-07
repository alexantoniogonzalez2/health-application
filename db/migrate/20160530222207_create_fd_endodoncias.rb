class CreateFdEndodoncias < ActiveRecord::Migration[5.0]
  def change
    create_table :fd_endodoncias do |t|
    	t.references :atencion_salud
    	t.references :pieza_dental
    	t.integer :comienzo_dolor
    	t.integer :dolor
    	t.integer :intensidad
    	t.boolean :es_pulsatil
    	t.boolean :cede_con_analgesicos
    	t.boolean :duele_al_acostarse
    	t.boolean :es_posible_senalar
    	t.boolean :se_genera_con_calor
    	t.boolean :se_genera_con_frio
    	t.boolean :se_genera_con_dulce
    	t.boolean :se_genera_al_masticar
    	t.text :informacion_adicional
    	t.text :examen_extraoral
    	t.text :examen_intraoral
    	t.text :examen_radiologico
    	t.text :comentario
        t.references :diagnostico
      t.timestamps null: false
    end
  end
end
