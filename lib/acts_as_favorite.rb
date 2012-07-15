require 'active_model'
require 'active_support'
require 'active_record'

module ActsAsFavorite

  if defined?(ActiveRecord::Base)
    require 'acts_as_favorite/favorable'
    require 'acts_as_favorite/favoriter'
    require 'acts_as_favorite/favorite'
    require 'acts_as_favorite/extenders/favorable'
    require 'acts_as_favorite/extenders/favoriter'
  end

end