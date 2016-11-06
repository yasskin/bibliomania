class CreateExercises < ActiveRecord::Migration[5.0]
  def change
    create_table :exercises do |t|
      t.integer :length_in_pp
      t.text :workout
      t.date :workout_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
