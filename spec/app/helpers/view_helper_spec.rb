require 'spec_helper'

module Unconfirm
  describe ViewHelper, :type => :helper do

    def expect_dict_subset_of(d1, d2)
      d1.each do |k, v|
        assert d2.include? k
        expect(d2[k]).to eq(v)
      end
    end

    def setting_equals_data(setting, data)
      expected = YAML.load File.open File.join(Rails.root, 'config', 'unconfirm','example_user_settings.yml')
      expected["settings"][setting.to_s].each do |key, val|
        expect(data["unconfirm_#{key}"]).to eq(val)
      end
    end

    it 'should get the data dictionary for a valid setting' do
      setting = :skip_user_confirmation_dialog_on_close_form
      data = data_with_unconfirm setting
      setting_equals_data setting, data
    end

    it 'should get empty dictionary for an unknown setting' do
      setting = :skip_user_confirmation_dialog_on_close_form_junk
      data = data_with_unconfirm setting
      expect(data).to eq({})
    end

    it 'should merge the given dictionary with the setting data' do
      extra = {:a => 1, :b => 2}
      setting = :skip_user_confirmation_dialog_on_close_form
      data = data_with_unconfirm setting, extra
      setting_equals_data setting, data
      expect_dict_subset_of(extra, data)
    end

    it 'should return unchanged dictionary for unknown setting' do
      extra = {:a => 1, :b => 2}
      setting = :skip_user_confirmation_dialog_on_close_form1
      data = data_with_unconfirm setting, extra
      expect_dict_subset_of(extra, data)
      expect(data.length).to eq(extra.length)
    end
  end
end
