module ActsAsFavourite
  module Extenders
    module Favouriter

      def self_conditions
        {:favouriter_id => self.id,:favouriter_type => self.class.base_class.name.to_s}
      end

      def favor favourable, args={}
        favourable.favor self, args
      end

      # favourites type: "Photo" - photos
      # favourites - all
      def list_favourites args= {}
        cond =  args[:type] ?
            self_conditions.merge(favourable_type: args[:type]):
            self_conditions

        # Get all favourites of this particular favouriter
        query_result = query_favourites(cond)

        #info{:photo => [1, 2, 3, 4], :car => [1,2,4]}
        info = query_result.inject({}) do |grouped, entry|
          grouped[:"#{entry.favourable_type}"] ||= []
          grouped[:"#{entry.favourable_type}"] <<  Integer("#{entry.favourable_id}")
          grouped
        end

        (info.inject([]) do |ret, (key, value) |
          ret << (key.to_s.classify.constantize).find(value)
          ret
        end).flatten
      end

      def query_favourites  cond
        ActsAsFavourite::Favourite.order("favourable_type DESC").where(cond).all
      end

    end
  end
end