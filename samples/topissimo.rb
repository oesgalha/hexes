def get_data
  procs = []
  # Get CPU usage, Mem usage and the name of each proc running
  IO.popen('ps -Aro %cpu,%mem,comm').each_line do |line|
    proc_data = line.split
    procs << [ proc_data[2].split('/')[-1], proc_data[0].to_f, proc_data[1].to_f ]
  end
  # Remove the ["%CPU", "%MEM", "COMM"]
  procs.shift
  procs.unshift(['Process', 'CPU %', 'MEM %'])
end

dashboard = Dashboard.new
proc_table = Table.new(label: 'Process List', width: 12, height: 12)
dashboard.add proc_table

loop do
  proc_table.data = get_data
  dashboard.refresh
  sleep(1)
end
