$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'rspec'
require 'acts_as_favorite'
require 'logger'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Base.logger = Logger.new(File.join(File.dirname(__FILE__),'debug.log'))
ActiveRecord::Base.logger.level = Logger::INFO

ActiveRecord::Schema.define(:version => 1) do
  create_table :favoriters, :force => true do |t|
    t.timestamps
  end

  create_table :not_favoriters, :force => true do |t|
    t.timestamps
  end

  create_table :favorites, :force => true do |t|
    t.references :favorable, :polymorphic => true
    t.references :favoriter, :polymorphic => true
    t.timestamps
  end

  create_table :favorables, :force => true do |t|
    t.timestamps
  end

  create_table :other_favorables, :force => true do |t|
    t.timestamps
  end

  create_table :not_favorables, :force => true do |t|
    t.timestamps
  end

end


class Favoriter < ActiveRecord::Base
  acts_as_favoriter
end

class NotFavoriter < ActiveRecord::Base
end

class Favorable < ActiveRecord::Base
  acts_as_favorable
end

class OtherFavorable < ActiveRecord::Base
  acts_as_favorable
end

class NotFavorable < ActiveRecord::Base

end



def clean_database
  models = [ActsAsfavorite::Favoriter, Favoriter, Favorable, NotFavorable, NotFavoriter, OtherFavorable]
  models.each do |model|
    ActiveRecord::Base.connection.execute "DELETE FROM #{model.table_name}"
  end
end
