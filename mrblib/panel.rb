class Panel
  def initialize(label, x, y, width, height)
    @label = label
    @x = x
    @y = y
    @width = width
    @height = height
  end

  def refresh
    Curses.move(@x, @y)
    Curses.type_special(Curses::ULCORNER)
    Curses.type_special(Curses::HLINE)
    Curses.type(@label)
    (@width - @label.size - 3).times { Curses.type_special(Curses::HLINE) }
    Curses.type_special(Curses::URCORNER)
    for i in 1...@height
      Curses.move(@x, i)
      Curses.type_special(Curses::VLINE)
      Curses.move(@x + @width - 1, i)
      Curses.type_special(Curses::VLINE)
    end
    Curses.move(@x, @y + @height - 1)
    Curses.type_special(Curses::LLCORNER)
    (@width - 2).times { Curses.type_special(Curses::HLINE) }
    Curses.type_special(Curses::LRCORNER)
  end
end
