module ActsAsFavourite
  module Favouriter
    extend ActiveSupport::Concern

    #Instance method
    def favouriter?
      false
    end

    #Class methods
    module ClassMethods

      def favouriter?
        false
      end
      def acts_as_favouriter(*args)
        has_many :favourites, :class_name => "ActsAsFavourite::Favourite", :as => :favouriter

        def self.favouriter?
          true
        end

        class_eval do
          include ActsAsFavourite::Extenders::Favouriter
          def favouriter?
            true
          end
        end

      end
    end

  end
end

ActiveRecord::Base.send :include, ActsAsFavourite::Favouriter
