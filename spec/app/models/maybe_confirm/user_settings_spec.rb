require 'spec_helper'

module MaybeConfirm
  describe UserSettings do
    before do
      setup_model_spec
    end

    it 'adds attributes based on the setting providers' do
      UserSettings.respond_to? :skip_user_confirmation_dialog_on_close_form
    end

    it 'retrieves default attribute values based on the setting providers' do
      sets = UserSettings.for @user
      refute sets.skip_user_confirmation_dialog_on_close_form
    end

    it 'sets attribute values' do
      sets = UserSettings.for @user
      sets.update_attributes({skip_user_confirmation_dialog_on_close_form: true})
      newsets = UserSettings.for @user
      assert newsets.skip_user_confirmation_dialog_on_close_form
    end

    it 'gets descriptive values' do
      expected = YAML.load File.open File.join(Rails.root, 'config', 'maybe_confirm','example_user_settings.yml')
      expected["settings"].each do |set, data|
        actual = UserSettings.setting_details_for(set)
        data.each do |k, v|
          actual[k.to_sym].must_equal v
        end
        actual[:category].must_equal expected["category"]
        actual[:category_description].must_equal expected["description"]
      end
    end
  end
end
