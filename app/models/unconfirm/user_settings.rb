require 'activerecord-typedstore'

module Unconfirm
  class UserSettings < ActiveRecord::Base
    CATEGORY_FIELDS = [:category, :category_description]
    SETTING_FIELDS  = [:description, :message, :message_title,
                       :dont_show_text, :continue_text, :cancel_text]
    MODEL_FIELDS    = [:user_id]

    cattr_accessor :categories
    @@categories = {}
    @@all_settings = []

    def truthy_settings
      if settings
        settings.select do |k, v|
          v
        end
      else
        {}
      end
    end

    def self.table_name_prefix
      'unconfirm_'
    end

    def self.for (user)
      if user
        find_or_create_by_user_id(:user_id => user.id)
      end
    end

    def self.add_settings(settings_data)
      category = settings_data[:category]
      unless @@categories.include? category
        @@categories[category] = {
          :description => settings_data[:description],
          :settings => {}
        }
      end
      category = @@categories[settings_data[:category]]
      typed_store :settings do |s|
        settings_data[:settings].each do |setting, data|
          sym = setting.to_sym
          @@all_settings << sym
          unless MODEL_FIELDS.include? sym
            category[:settings][sym] = data
            s.boolean sym, default: false, null: true
          end
        end
      end
      attr_accessible *(MODEL_FIELDS + @@all_settings)
    end

    def self.setting_details_for (setting)
      details = {}
      category = @@categories.detect do |cat, data|
        data[:settings].include? setting.to_sym
      end
      if category
        data = category[1]
        details[:category] = category[0]
        details[:category_description] = data[:description]
        setting_data = data[:settings][setting.to_sym]
        SETTING_FIELDS.each do |set|
          details[set] = setting_data[set]
        end
      end
      details
    end

    Dir.glob(File.join(Rails.root, 'config', 'unconfirm', '*_user_settings.yml')).each do |f|
      begin
        add_settings HashWithIndifferentAccess.new(YAML.load(File.open(f)))
      rescue Exception => ex
        puts ex
        Rails.logger.warn "Failed to import settings #{f}"
        Rails.logger.warn ex
      end
    end

  end
end
