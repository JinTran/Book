class CreateNovels < ActiveRecord::Migration[5.2]
  def change
    create_table :novels do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :description
      t.string :publisher

      t.timestamps
    end
  end
end
