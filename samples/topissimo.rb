def get_data
  procs = []
  # Get CPU usage, Mem usage and the name of each proc running
  IO.popen('ps -Aro %cpu,%mem,comm').each_line do |line|
    proc_data = line.split
    procs << [ proc_data[2].split('/')[-1], proc_data[0], proc_data[1] ]
  end
  # Remove the ["%CPU", "%MEM", "COMM"]
  procs.shift
  procs.unshift(['Process', 'CPU %', 'MEM %'])
end

begin
  screen = Screen.new(12, 12)
  procs_table = Table.new("Process List")
  screen.add_widget(procs_table, 0, 0, 12, 6)

  loop do
    procs_table.data = get_data
    screen.refresh
    Sleep::sleep(1)
  end

ensure
  screen.terminate
end
