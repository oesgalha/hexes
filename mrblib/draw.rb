module Kernel
  def draw
    Curses.initialize
    Curses.draw_panel("Hello World!", 0, 0, 30, 30)
    Curses.shutdown
  end
end
