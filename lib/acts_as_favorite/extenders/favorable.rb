module ActsAsFavorite  #:nodoc:
  # Module Extenders
  module Extenders
    # Module Favorable
    module Favorable

      # Create a new favorite using this favoriter
      def favor favoriter
        ActsAsFavorite::Favorite.find_or_create(self, favoriter)
        reload && favoriter.reload
      end

      # Removes a favorite using this favoriter
      def remove_favor favoriter
        ActsAsFavorite::Favorite.find_for(self, favoriter).delete_all
        reload && favoriter.reload
      end

      # Check if the favoriter already favored this item
      def favored_by? favoriter
         favorites.collect{|favorite| favorite.favoriter}.include? favoriter
      end

      # Get the times this item was favored
      def times_favored
        favorites.count
      end

    end
  end
end