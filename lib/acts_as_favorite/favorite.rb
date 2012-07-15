module ActsAsFavorite #:nodoc:
  # Class Favorite
  class Favorite < ActiveRecord::Base
    belongs_to :favorable, :polymorphic => true
    belongs_to :favoriter, :polymorphic => true

    attr_accessible :favorable_id, :favorable_type,
                    :favoriter_id, :favoriter_type,
                    :favorable, :favoriter

    validates_presence_of :favorable_id
    validates_presence_of :favoriter_id


  end
end