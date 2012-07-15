require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ActsAsFavorite" do

   describe "Basic Response" do
     it "favorable should be favorable" do
       Favorable.should be_favorable
     end

     it "not favorable should not be favorable" do
       NotFavorable.should_not be_favorable
     end

     it "favoriter should be favoriter" do
       Favoriter.should be_favoriter
     end

     it "not favoriter should not be favoriter" do
       NotFavorable.should_not be_favoriter
     end
  end

  describe "Operations of" do

    before :each do
      clean_database
      @favoriter = Favoriter.create!
      @favorable = Favorable.create!
      @favorable2 = OtherFavorable.create!
    end

    describe :Favorable do
      it "should return false if is not favored by the favoriter" do
        (@favorable.favored_by? @favoriter).should be_false
      end

      it "should return true if its favored by a favoriter" do
        @favoriter.favor @favorable
        (@favorable.favored_by? @favoriter).should be_true
      end

      it "should increment the times favored" do
        lambda {
          @favoriter.favor @favorable
        }.should change(@favorable,:times_favored).by(1)
      end
    end

    describe :Favoriter do
        before :each do
          @favoriter.favor @favorable
          @favoriter.favor @favorable2
        end

        it "should remove the favorable" do
          lambda{
            @favoriter.remove_favor @favorable
          }.should change(@favorable, :times_favored).from(1).to(0)
        end


        context "listing the favorites" do
          it "should return all of them" do
            @favoriter.all_favorites.should include @favorable, @favorable2
          end

          it "should return only filtered favorites" do
            @favoriter.favorites_of(@favorable.class.name.to_sym).should_not include @favorable2
            @favoriter.favorites_of(@favorable.class.name.to_sym).should include @favorable
          end
       end
    end

  end
end

def clean_database
  models = [ActsAsFavorite::Favorite, Favorable, Favoriter, NotFavorable, NotFavorable]
  models.each do |model|
    ActiveRecord::Base.connection.execute "DELETE FROM #{model.table_name}"
  end
end