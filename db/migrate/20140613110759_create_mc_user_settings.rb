# Copyright 2011-2014 Rice University. Licensed under the Affero General Public
# License version 3 or later.  See the COPYRIGHT file for details.

class CreateMcUserSettings < ActiveRecord::Migration
  def change
    create_table(:mc_user_settings) do |t|
      t.integer :user_id, :null => false
      t.text    :settings
      t.timestamps
    end

    add_index :mc_user_settings, :user_id
  end
end
