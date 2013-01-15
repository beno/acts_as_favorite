module ActsAsFavorite  #:nodoc:
  # Module Extenders
  module Extenders
    # Module Favorable
    module Favoriter

      # Favor a given item
      def favor favorable
        ActsAsFavorite::Favorite.find_or_create(favorable, self)
        reload && favorable.reload
      end

      # Removes the item from the favorable list
      def remove_favor favorable
        ActsAsFavorite::Favorite.find_for(favorable, self).delete_all
        reload && favorable.reload
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