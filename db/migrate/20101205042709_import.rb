class Import < ActiveRecord::Migration
  def self.up
    execute "create table cities (`name` varchar(500), `country_code` varchar(3), alternate_names varchar(5000), location point, population bigint(11), lat float, lng float) charset utf8;"
  end

  def self.down
    drop_table :cities
  end
end
