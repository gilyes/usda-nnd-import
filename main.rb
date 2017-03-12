#!/usr/bin/env ruby

require './config.rb'
require './import.rb'

def get_source(filename)
  File.join('data/source', filename)
end

def get_schema(filename)
  File.join('data/schema', filename)
end

importer = Importer.new(Config::DB)

start = Time.now

importer.import_table('FoodGroup', get_source('FD_GROUP.txt'), get_schema('FD_GROUP.columns.txt'))
importer.import_table('Food', get_source('FOOD_DES.txt'), get_schema('FOOD_DES.columns.txt'))
importer.import_table('NutrientDefinition', get_source('NUTR_DEF.txt'), get_schema('NUTR_DEF.columns.txt'))
importer.import_table('NutrientData', get_source('NUT_DATA.txt'), get_schema('NUT_DATA.columns.txt'))
importer.import_table('Weight', get_source('WEIGHT.txt'), get_schema('WEIGHT.columns.txt'))

puts "Done in #{(Time.now - start)} seconds."
