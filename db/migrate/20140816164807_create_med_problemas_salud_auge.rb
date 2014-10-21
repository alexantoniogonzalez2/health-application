class CreateMedProblemasSaludAuge < ActiveRecord::Migration
  def change
    create_table :med_problemas_salud_auge do |t|
    	t.string :nombre
    	t.references :diagnostico #diagnostico_id
    	t.integer :edad_desde
    	t.integer :edad_hasta
    	t.string :genero
    	t.integer :prioridad
    	t.datetime :fecha_inicio_auge 

      t.timestamps
    end
  end
end
