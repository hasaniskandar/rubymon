class CreateMonsters < ActiveRecord::Migration
  def change
    create_table :monsters do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :team, index: true, foreign_key: true
      t.string :name
      t.string :power
      t.string :element

      t.timestamps null: false
    end
  end
end
