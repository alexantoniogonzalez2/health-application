class CreateFiPersonaExamenes < ActiveRecord::Migration
  def change
    create_table :fi_persona_examenes do |t|
      t.references :persona 	#persona_id
      t.references :examen 	#examen_id
      t.references :atencion_salud	#atencion_salud_id

      t.timestamps
    end
  end
end
