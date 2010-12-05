# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101205042709) do

  create_table "cities", :id => false, :force => true do |t|
    t.string  "name",            :limit => 500
    t.string  "country_code",    :limit => 3
    t.string  "alternate_names", :limit => 5000
    t.integer "location",        :limit => nil
    t.integer "population",      :limit => 8
  end

end
