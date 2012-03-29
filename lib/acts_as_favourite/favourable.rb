module ActsAsFavourite
  module Favourable
    extend ActiveSupport::Concern

    #Instance method
    def favourable?
      false
    end

    #Class methods
    module ClassMethods

      def favourable?
        false
      end

      def acts_as_favourable(*args)
        has_many :favourites, :class_name => "ActsAsFavourite::Favourite", :as => :favourable

        def self.favourable?
          true
        end

        class_eval do
          include ActsAsFavourite::Extenders::Favourable
          def favourable?
            true
          end
        end

      end
    end

  end
end

ActiveRecord::Base.send :include, ActsAsFavourite::Favourable
