class CreateProProfesionales < ActiveRecord::Migration[5.0]
  def change
    create_table :pro_profesionales do |t|
      t.boolean :validado				#validado
      t.references :profesional			#profesional_id
      t.references :especialidad 		#especialidad_id
      t.references :institucion			#institucion_id

      t.timestamps
    end
  end
end
