module ActsAsFavourite
  module Extenders
    module Favouriter

      # Favor a given item
      # @param [Favourable] favourable that is favouring this item
      # @return [Bool]
      def favor favourable
        ActsAsFavourite::Favourite.create(favourable: favourable, favouriter: self)
      end

      def remove_favor favourable
        ActsAsFavourite::Favourite.where(
            favourable_id: favourable,
            favourable_type: favourable.class,
            favouriter_id: self,
            favouriter_type: self.class
        ).delete_all
      end

      # List the favourites by type, type can be an [Array]
      # @param [Hash] type that are passed to filter results
      # @return [Array] of favourable items
      def favourites_of type= {}
         favourites.collect{|favourite| favourite.favourable if Array.wrap(type).include? favourite.favourable_type.to_s.to_sym}
      end

      # List all favourites of this favourites
      # @return [Array] of favourable items
      def all_favourites
        favourites.collect{|favourite| favourite.favourable}
      end


    end
  end
end