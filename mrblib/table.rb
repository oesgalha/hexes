class Table < Panel

  attr_accessor :data

  def refresh
    super
    lines = @height - 2
    cur_data = data[0...lines]
    ncols = cur_data[0].size
    cols_size = Array.new(ncols) { |i| (@width - 2) / ncols }
    cur_data.each do |line|
      line.each_with_index do |str, col|
        if str.size > cols_size[col]
          cols_size[col] = str.size
        end 
      end
    end
    cur_data.each_with_index do |line, line_number|
      Curses.move(@x + 1, @y + 1 + line_number)
      line.each_with_index do |str, col|
        Curses.type(str + (' ' * (cols_size[col] - str.size)))
      end
    end
  end
end
