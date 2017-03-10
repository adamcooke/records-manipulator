require 'active_record'

#
# Make some sort of database
#

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
ActiveRecord::Migration.create_table :users do |t|
  t.string :first_name, :last_name, :twitter_bio
  t.timestamps
end

class User < ActiveRecord::Base
  def manipulate
    @manipulated = true
  end

  def manipulated?
    @manipulated == true
  end
end

#
# Add some data
#
User.create!(:first_name => "Joe", :last_name => "Bloggs")
User.create!(:first_name => "Alicia", :last_name => "Florrick")
User.create!(:first_name => "Rachel", :last_name => "Ross")

#
# Load our stuff
#
require 'records_manipulator/relation_extension'
::ActiveRecord::Relation.send :include, RecordsManipulator::RelationExtension

require 'records_manipulator/base_extension'
::ActiveRecord::Base.send :include, RecordsManipulator::BaseExtension
