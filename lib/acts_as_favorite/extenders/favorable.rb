module ActsAsFavorite  #:nodoc:
  # Module Extenders
  module Extenders
    # Module Favorable
    module Favorable

      # Create a new favorite using this favoriter
      def favor favoriter
        ActsAsFavorite::favorite.create(favorable: self, favoriter: favoriter)
      end

      # Removes a favorite using this favoriter
      def remove_favor favoriter
        ActsAsFavorite::favorite.where(
            favorable_id: self,
            favorable_type: self.class,
            favoriter_id: favoriter,
            favoriter_type: favoriter.class
        ).delete_all
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