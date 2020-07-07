class CreatePrePrestadorProfesionales < ActiveRecord::Migration[5.0]
  def change
    create_table :pre_prestador_profesionales do |t|
      t.references :prestador 		#prestador_id
      t.references :profesional		#profesional_id
      t.references :especialidad	#especialidad_id

      t.timestamps
    end
  end
end
