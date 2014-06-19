require 'activerecord-typedstore'
class MCUserSettings < ActiveRecord::Base
  SETTING_FIELDS = [:user_id, :category, :category_description,
                    :settings, :description, :message, :message_title,
                    :dont_show_text, :continue_text, :cancel_text]

  attr_accessor *SETTING_FIELDS

  cattr_accessor :categories
  @@categories = {}

  scope :for, lambda { |user|
    scoped.find_by_user_id user.id
  }

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
        unless SETTING_FIELDS.include? sym
          category[:settings][sym] = data
          s.boolean sym, default: false, null: false
        end
      end
    end
  end

  Dir.glob(File.join(Rails.root, 'config', 'mc_user_settings','*.yml')).each do |f|
    begin
      add_settings HashWithIndifferentAccess.new(YAML.load(File.open(f)))
    rescue Exception => ex
      puts ex
      Rails.logger.warn "Failed to import settings #{f}"
      Rails.logger.warn ex
    end
  end

end
