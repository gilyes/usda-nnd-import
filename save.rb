require 'pg'

class Saver
  def initialize(host:, dbname:, user:, password:)
    @host = host
    @dbname = dbname
    @user = user
    @password = password
    @conn = PG.connect(host: @host, dbname: @dbname, user: @user,
                       password: @password)
  end

  def prep_table(table_name, columns)
    @conn.exec "drop table if exists #{table_name}"
    @conn.exec "create table #{table_name} (#{columns.join(',')})"
    @conn.exec "prepare insert#{table_name} " \
               "(#{create_type_string(columns)}) " \
               "as insert into #{table_name} " \
               "values(#{(1..columns.length).map { |n| "$#{n}" }.join(',')});"
  end

  def insert_row(table_name, row)
    @conn.exec "execute insert#{table_name} (#{create_values_string(row)})"
  end

  def create_type_string(columns)
    columns.map { |c| c.split(' ')[1].tr(',', '') }.join(',')
  end

  def create_values_string(values)
    values.map { |v| v != '' ? v : 'NULL' }.join(',')
  end

  def transaction
    @conn.transaction do |_conn|
      yield
    end
  end
end
