require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ActsAsFavourite" do

   describe "Basic Response" do
     it "favourable should be favourable" do
       Favourable.should be_favourable
     end

     it "not favourable should not be favourable" do
       NotFavourable.should_not be_favourable
     end

     it "favouriter should be favouriter" do
       Favouriter.should be_favouriter
     end

     it "not favouriter should not be favouriter" do
       NotFavouriter.should_not be_favouriter
     end
  end

  describe "Operations of" do

    before :each do
      clean_database
      @favouriter = Favouriter.create!
      @favourable = Favourable.create!
      @favourable2 = OtherFavourable.create!
    end

    describe :Favourable do
      it "should return false if is not favoured by the favouriter" do
        (@favourable.favoured_by? @favouriter).should be_false
      end

      it "should return true if its favoured by a favouriter" do
        @favouriter.favor @favourable
        (@favourable.favoured_by? @favouriter).should be_true
      end

      it "should increment the times favoured" do
        lambda {
          @favouriter.favor @favourable
        }.should change(@favourable,:times_favoured).by(1)
      end
    end

    describe :Favouriter do
        before :each do
          @favouriter.favor @favourable
          @favouriter.favor @favourable2
        end

        it "should remove the favourable" do
          lambda{
            @favouriter.favor @favourable, remove: true
          }.should change(@favourable, :times_favoured).from(1).to(0)
        end

        it "should not remove the favourable" do
          lambda{
            @favouriter.favor @favourable
          }.should_not change(@favourable, :times_favoured)
        end

        context "listing the favourites" do
          it "should return all of them" do
            @favouriter.list_favourites.should include @favourable, @favourable2
          end

          it "should return only filtered favourites" do
            @favouriter.list_favourites(type: @favourable.class.name).should_not include @favourable2
          end
       end
    end

  end
end

def clean_database
  models = [ActsAsFavourite::Favourite, Favourable, Favouriter, NotFavourable, NotFavouriter]
  models.each do |model|
    ActiveRecord::Base.connection.execute "DELETE FROM #{model.table_name}"
  end
end