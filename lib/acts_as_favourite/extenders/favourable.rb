module ActsAsFavourite
  module Extenders
    module Favourable


      # Create a new favourite using this favouriter
      # @param [Favouriter] favouriter
      def favor favouriter
        ActsAsFavourite::Favourite.create(favourable: self, favouriter: favouriter)
      end

      # Removes a favourite using this favouriter
      # @param [Favouriter] favouriter
      def remove_favor favouriter
        ActsAsFavourite::Favourite.where(
            favourable_id: self,
            favourable_type: self.class,
            favouriter_id: favouriter,
            favouriter_type: favouriter.class
        ).delete_all
      end

      # Check if the favouriter already favoured this item
      # @return [Bool]
      def favoured_by? favouriter
         favourites.collect{|favourite| favourite.favouriter}.include? favouriter
      end

      # Get the times this item was favoured
      # @return [Integer]
      def times_favoured
        favourites.count
      end

    end
  end
end