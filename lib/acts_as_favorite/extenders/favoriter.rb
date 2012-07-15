module ActsAsFavorite  #:nodoc:
  # Module Extenders
  module Extenders
    # Module Favorable
    module Favoriter

      # Favor a given item
      def favor favorable
        ActsAsFavorite::Favorite.create(favorable: favorable, favoriter: self)
      end

      # Removes the item from the favorable list
      def remove_favor favorable
        ActsAsFavorite::Favorite.where(
            favorable_id: favorable,
            favorable_type: favorable.class,
            favoriter_id: self,
            favoriter_type: self.class
        ).delete_all
      end

      # List the favorites by type, type can be an [Array]
      def favorites_of type= {}
         favorites.collect{|favorite| favorite.favorable if Array.wrap(type).include? favorite.favorable_type.to_s.to_sym}
      end

      # List all favorites of this favorites
      def all_favorites
        favorites.collect{|favorite| favorite.favorable}
      end

    end
  end
end