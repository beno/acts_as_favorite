$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'rspec'
require 'acts_as_favourite'
require 'logger'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Base.logger = Logger.new(File.join(File.dirname(__FILE__),'debug.log'))
ActiveRecord::Base.logger.level = Logger::INFO

ActiveRecord::Schema.define(:version => 1) do
  create_table :favouriters, :force => true do |t|
    t.timestamps
  end

  create_table :not_favouriters, :force => true do |t|
    t.timestamps
  end

  create_table :favourites, :force => true do |t|
    t.references :favourable, :polymorphic => true
    t.references :favouriter, :polymorphic => true
    t.timestamps
  end

  create_table :favourables, :force => true do |t|
    t.timestamps
  end

  create_table :other_favourables, :force => true do |t|
    t.timestamps
  end

  create_table :not_favourables, :force => true do |t|
    t.timestamps
  end

end


class Favouriter < ActiveRecord::Base
  acts_as_favouriter
end

class NotFavouriter < ActiveRecord::Base
end

class Favourable < ActiveRecord::Base
  acts_as_favourable
end

class OtherFavourable < ActiveRecord::Base
  acts_as_favourable
end

class NotFavourable < ActiveRecord::Base

end



def clean_database
  models = [ActsAsFavourite::Favouriter, Favouriter, Favourable, NotFavourable, NotFavouriter, OtherFavourable]
  models.each do |model|
    ActiveRecord::Base.connection.execute "DELETE FROM #{model.table_name}"
  end
end
