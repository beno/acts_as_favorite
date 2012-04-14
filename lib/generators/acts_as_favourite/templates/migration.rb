class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites, :force => true do |t|
      t.references :favourable, :polymorphic => true
      t.references :favouriter, :polymorphic => true
      t.timestamps
    end

    add_index :favourites, [:favourable_id, :favourable_type]
    add_index :favourites, [:favouriter_id, :favouriter_type]
  end

end