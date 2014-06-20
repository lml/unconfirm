module Unconfirm
  module ViewHelper

    def data_with_unconfirm(setting, data=nil)
      details = UserSettings.setting_details_for(setting)
      res = {}
      UserSettings::SETTING_FIELDS.each do |field|
        if details and details.include? field
          res["unconfirm_#{field.to_s}"] = details[field]
        end
      end
      res["unconfirm_setting"] = setting
      res.merge!(data || {})
    end

    def unconfirm_tag
      # TODO: Make this complete with all the options accepted by jquery.unconfirm.
      javascript_tag "window.unconfirmUserSettings = #{unconfirm_user_settings.to_json}; $('.unconfirm').unconfirm();"
    end

    def include_unconfirm
      render partial: 'unconfirm/dialog'
    end

  end
end
