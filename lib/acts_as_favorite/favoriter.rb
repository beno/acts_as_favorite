module ActsAsFavorite #:nodoc:
  # Module Favoriter
  module Favoriter
    extend ActiveSupport::Concern

    # Instance objects have the favoriter ability?
    def favoriter?
      false
    end

    #Class methods
    module ClassMethods
      # Models have the favoriter ability?
      def favoriter?
        false
      end
      # Adds the ability to make favorites to the model
      def acts_as_favoriter(*args)
        has_many :favorites, :class_name => "ActsAsFavorite::Favorite", :as => :favoriter

        # Models have the favoriter ability?
        def self.favoriter?
          true
        end

        class_eval do
          include ActsAsFavorite::Extenders::Favoriter
          # Models have the favoriter ability?
          def favoriter?
            true
          end
        end

      end
    end

  end
end

ActiveRecord::Base.send :include, ActsAsFavorite::Favoriter
