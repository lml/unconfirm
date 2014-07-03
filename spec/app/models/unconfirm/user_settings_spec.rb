require 'spec_helper'

module Unconfirm
  describe UserSettings do
    before do
      @user = User.create email: "dummy@dummy.com", handle: "dummy"
    end

    it 'adds attributes based on the setting providers' do
      UserSettings.respond_to? :skip_user_confirmation_dialog_on_close_form
    end

    it 'retrieves default attribute values based on the setting providers' do
      sets = UserSettings.for @user
      expect(sets.skip_user_confirmation_dialog_on_close_form).not_to be true
    end

    it 'sets attribute values' do
      sets = UserSettings.for @user
      sets.update_attributes({skip_user_confirmation_dialog_on_close_form: true})
      newsets = UserSettings.for @user
      expect(newsets.skip_user_confirmation_dialog_on_close_form).to be true
    end

    it 'gets descriptive values' do
      expected = YAML.load File.open File.join(Rails.root, 'config', 'unconfirm','example_user_settings.yml')
      expected["settings"].each do |set, data|
        actual = UserSettings.setting_details_for(set)
        data.each do |k, v|
          expect(actual[k.to_sym]).to eq(v)
        end
        expect(actual[:category]).to eq(expected["category"])
        expect(actual[:category_description]).to eq(expected["description"])
      end
    end
  end
end
