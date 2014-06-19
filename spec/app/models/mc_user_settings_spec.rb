require 'spec_helper'

describe MCUserSettings do
  before  do
    @user = User.create email: "dummy@dummy.com", handle: "dummy"
  end

  it 'adds attributes based on the setting providers' do
    MCUserSettings.respond_to? :skip_user_confirmation_dialog_on_close_form
  end

  it 'retrieves default attribute values based on the setting providers' do
    sets = MCUserSettings.for @user
    refute sets.skip_user_confirmation_dialog_on_close_form
  end

  it 'sets attribute values' do
    sets = MCUserSettings.for @user
    sets.update_attributes({skip_user_confirmation_dialog_on_close_form: true})
    newsets = MCUserSettings.for @user
    assert newsets.skip_user_confirmation_dialog_on_close_form
  end

  it 'gets descriptive values' do
    expected = YAML.load File.open File.join(Rails.root, 'config', 'mc_user_settings','example_settings.yml')
    expected["settings"].each do |set, data|
      actual = MCUserSettings.setting_details_for(set)
      data.each do |k, v|
        actual[k.to_sym].must_equal v
      end
      actual[:category].must_equal expected["category"]
      actual[:category_description].must_equal expected["description"]
    end
  end
end
