begin
  Curses.initialize
  Curses.draw_panel("Hello World!", 0, 0, 30, 12)
  Curses.draw_panel("Uuuuuu", 40, 12, 30, 12)
  Curses.refresh
  Sleep::sleep(1)
ensure
  Curses.shutdown
end
