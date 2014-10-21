class CreateTraProfesionesOficios < ActiveRecord::Migration
  def change
    create_table :tra_profesiones_oficios do |t|
    	t.string :nombre

      t.timestamps
    end
  end
end
