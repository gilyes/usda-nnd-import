class Loader
  def load_records(filename)
    load_lines(filename) do |line|
      yield split_record_line(line)
    end
  end

  def load_columns(filename)
    columns = []
    load_lines(filename) { |line| columns.push(line) }
    columns
  end

  def split_record_line(line)
    line.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
    line.split('^', -1)
        .map { |field| field.gsub("'", "''").tr('~', '\'') }
  end

  def load_lines(filename)
    File.foreach(filename) do |line|
      yield line.strip
    end
  end
end
