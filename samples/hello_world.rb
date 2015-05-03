begin
  Curses.initialize
  panel = Panel.new("Hello World!", 0, 0, 30, 12)
  panel.refresh
  Curses.refresh
  Sleep::sleep(10)
ensure
  Curses.shutdown
end
