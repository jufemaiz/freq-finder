class Station < ActiveRecord::Base
  has_many        :transmitters
end
