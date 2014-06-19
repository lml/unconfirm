class CreateMaybeConfirmUserSettings < ActiveRecord::Migration
  def change
    create_table(:maybe_confirm_user_settings) do |t|
      t.integer :user_id, :null => false
      t.text    :settings
      t.timestamps
    end

    add_index :maybe_confirm_user_settings, :user_id
  end
end
