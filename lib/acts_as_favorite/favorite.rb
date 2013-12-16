module ActsAsFavorite #:nodoc:
  # Class Favorite
  class Favorite < ActiveRecord::Base
    belongs_to :favorable, :polymorphic => true
    belongs_to :favoriter, :polymorphic => true


    validates_presence_of :favorable_id
    validates_presence_of :favoriter_id
    
    def self.find_or_create(favorable, favoriter)
      existing = find_for(favorable, favoriter)
      if existing.blank?
        favorite = create(favorable: favorable, favoriter: favoriter)
      else
        favorite = existing.first
      end
      favorite
    end
    
    def self.find_for(favorable, favoriter)
      where({
        favorable_id: favorable,
        favorable_type: favorable.class.to_s,
        favoriter_id: favoriter,
        favoriter_type: favoriter.class.to_s
      })
    end

  end
end