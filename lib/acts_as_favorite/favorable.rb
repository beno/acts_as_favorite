module ActsAsFavorite #:nodoc:
  # Module Favorable
  module Favorable
    extend ActiveSupport::Concern

    # Instance objects have the favorable ability?
    def favorable?
      false
    end

    #Class methods
    module ClassMethods

      # Models have the favorable ability?
      def favorable?
        false
      end
      # Adds the ability to be make as favorable to the model
      def acts_as_favorable(*args)
        has_many :favorites, :class_name => "ActsAsFavorite::Favorite", :as => :favorable

        # Models have the favorable ability?
        def self.favorable?
          true
        end
        
        def self.favored_by(favoriter)
          self.includes(:favorites).where(favorites: {favoriter_id: favoriter.id})
        end

        class_eval do
          include ActsAsFavorite::Extenders::Favorable
          # Models have the favorable ability?

          def favorable?
            true
          end
        end

      end
    end

  end
end

ActiveRecord::Base.send :include, ActsAsFavorite::Favorable
