class CreateFdTratamientos < ActiveRecord::Migration
  def change
    create_table :fd_tratamientos do |t|
    	t.string :descripcion
      t.timestamps null: false
    end
  end
end
