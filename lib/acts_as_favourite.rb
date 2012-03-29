require 'active_model'
require 'active_support'
require 'active_record'

module ActsAsFavourite

  if defined?(ActiveRecord::Base)
    require 'acts_as_favourite/favourable'
    require 'acts_as_favourite/favouriter'
    require 'acts_as_favourite/favourite'
    require 'acts_as_favourite/extenders/favourable'
    require 'acts_as_favourite/extenders/favouriter'
  end

end