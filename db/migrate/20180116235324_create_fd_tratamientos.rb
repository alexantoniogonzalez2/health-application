class CreateFdTratamientos < ActiveRecord::Migration[5.0]
  def change
    create_table :fd_tratamientos do |t|
    	t.string :descripcion
      t.timestamps null: false
    end
  end
end
