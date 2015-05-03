class Screen
  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    @widgets = []
    Curses.initialize
  end

  def add_widget(widget, row, col, width, height)
    @widgets << {
      widget: widget,
      row: row,
      col: col,
      width: width,
      height: height
    }
  end

  def refresh
    screen_width = Curses.width
    screen_height = Curses.height
    @widgets.each do |info|
      widget = info[:widget]
      widget.x = info[:col] * ( screen_width / @cols )
      widget.y = info[:row] * ( screen_height / @rows )
      widget.width = info[:width] * ( screen_width / @cols )
      widget.height = info[:height] * ( screen_height / @rows )
      widget.refresh
    end
    Curses.refresh
  end

  def terminate
    Curses.shutdown
  end
end
