# frozen_string_literal: true

# [ApplicationMailer]
#
# @since 20181220
# @author Joel Courtney <joel@aceteknologi.com>
class ApplicationMailer < ActionMailer::Base
  default from: 'from@freqfinder.com'
  layout 'mailer'
end
