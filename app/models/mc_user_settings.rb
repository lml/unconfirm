require 'activerecord-typedstore'
class MCUserSettings < ActiveRecord::Base
  SETTING_FIELDS = [:user_id, :category, :category_description,
                    :settings, :description, :message, :message_title,
                    :dont_show_text, :continue_text, :cancel_text]

  cattr_accessor :categories
  @@categories = {}
  @@all_settings = []

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
        unless SETTING_FIELDS.include? sym
          category[:settings][sym] = data
          s.boolean sym, default: false, null: true
        end
      end
    end
    attr_accessible *(SETTING_FIELDS + @@all_settings)
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
