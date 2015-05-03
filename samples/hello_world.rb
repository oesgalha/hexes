begin
  screen = Screen.new(12, 12)
  panel = Panel.new("Panel number one!")
  panel2 = Panel.new("Duos")
  panel3 = Panel.new("Coolbeeeeans!")
  screen.add_widget(panel, 0, 0, 6, 6)
  screen.add_widget(panel2, 0, 6, 6, 6)
  screen.add_widget(panel3, 6, 0, 12, 6)
  screen.refresh
  Sleep::sleep(10)
ensure
  screen.terminate
end
