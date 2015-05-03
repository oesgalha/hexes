class Panel

  attr_accessor :x, :y, :width, :height

  def initialize(label)
    @label = label
  end

  def refresh
    Curses.move(@x, @y)
    Curses.type_special(Curses::ULCORNER)
    Curses.type_special(Curses::HLINE)
    Curses.type(@label)
    (@width - @label.size - 3).times { Curses.type_special(Curses::HLINE) }
    Curses.type_special(Curses::URCORNER)
    for i in 1...@height
      Curses.move(@x, @y + i)
      Curses.type_special(Curses::VLINE)
      Curses.move(@x + @width - 1, @y + i)
      Curses.type_special(Curses::VLINE)
    end
    Curses.move(@x, @y + @height - 1)
    Curses.type_special(Curses::LLCORNER)
    (@width - 2).times { Curses.type_special(Curses::HLINE) }
    Curses.type_special(Curses::LRCORNER)
  end
end
