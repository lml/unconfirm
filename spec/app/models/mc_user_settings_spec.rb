require 'spec_helper'

describe MCUserSettings do
  it 'adds attributes based on the setting providers' do
    MCUserSettings.respond_to? :skip_user_confirmation_dialog_on_close_form
  end
end
