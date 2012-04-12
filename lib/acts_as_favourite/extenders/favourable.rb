module ActsAsFavourite
  module Extenders
    module Favourable

      # args = { favouriter: User.new }
      # args = { favouriter: User.new, remove: true }
      def favor favouriter, args={}
        cond = conditions(favouriter).merge conditions
        fav = find(cond).first

        # If the user had already favorited this :favourable then
        # checks if :remove in set to true and remove that favourite entry
        # if not, return the :favourite entry
        if fav
          ActsAsFavourite::Favourite.destroy fav  if args[:remove]
          return fav
        end

        # If no fav is found then creates new one
        fav = ActsAsFavourite::Favourite.new(:favourable => self, :favouriter=>favouriter)

        if fav.save
          return fav
        else
          false
        end
      end

      def favoured_by? favouriter
        cond = conditions(favouriter).merge conditions
        !find(cond).all.empty?
      end

      def times_favoured
        find(conditions).count
      end

      private

      def find conditions
        return ActsAsFavourite::Favourite.where(conditions)
      end

      def conditions model=self
        name = model.favouriter? ?  "favouriter" : ( model.favourable? ? "favourable" : nil )
        {:"#{name}_id" => model.id, :"#{name}_type" =>  model.class.name.to_s}
      end
    end
  end
end