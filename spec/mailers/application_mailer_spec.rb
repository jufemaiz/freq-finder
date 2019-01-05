# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationMailer, type: :maile do
  it 'creates new mailer' do
    expect { ApplicationMailer.new }.not_to raise_error
  end
end
