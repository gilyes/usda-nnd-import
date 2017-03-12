require './load.rb'
require './save.rb'

class Importer
  def initialize(host:, dbname:, user:, password:)
    @loader = Loader.new
    @saver = Saver.new(host: host, dbname: dbname, user: user, password: password)
  end

  def import_table(table_name, records_filename, columns_filename)
    puts "Importing #{table_name} from #{records_filename}..."
    columns = @loader.load_columns(columns_filename)

    @saver.prep_table(table_name, columns)

    @saver.transaction do
      @loader.load_records(records_filename) do |record|
        @saver.insert_row(table_name, record)
      end
    end
  end
end
