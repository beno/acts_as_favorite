module ActsAsFavourite
  class Favourite < ActiveRecord::Base
    belongs_to :favourable, :polymorphic => true
    belongs_to :favouriter, :polymorphic => true

    attr_accessible :favourable_id, :favourable_type,
                    :favouriter_id, :favouriter_type,
                    :favourable, :favouriter

    validates_presence_of :favourable_id
    validates_presence_of :favouriter_id


  end
end