# frozen_string_literal: true

# [ApplicationRecord]
#
# @since 20181220
# @author Joel Courtney <joel@aceteknologi.com>
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
