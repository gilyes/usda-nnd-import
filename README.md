# usda-nnd-import

Imports the [USDA National Nutrient Database](https://ndb.nal.usda.gov/ndb/) to a Postgres database from the ASCII data files provided [here](https://www.ars.usda.gov/northeast-area/beltsville-md/beltsville-human-nutrition-research-center/nutrient-data-laboratory/docs/sr28-download-files/).

### Usage
* `bundle install`
* Extract text files from the above link to `data/source`.
* Rename `config.sample.rb` to `config.rb` and set up the db connection in it.
* `ruby main.rb`