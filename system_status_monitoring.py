# Needs psutil module, documentation: http://pythonhosted.org/psutil/
# We will use the CollectD coded by HuaWei in the research. Before done, we will use the psutil module in the simulation.

import psutil,datetime,time

second = 5 # Time tick for counting.

# CPU usage of all the cores (threads) in one server.

cpu_usage = psutil.cpu_percent(interval=1)

# Memory usage

memory_usage = psutil.swap_memory()[3]

# Hard disk usage: data input and data output among all the disks (bytes/second).

input_before_sleep = psutil.disk_io_counters()[2]
output_before_sleep = psutil.disk_io_counters()[3]
time.sleep(second)
input_after_sleep = psutil.disk_io_counters()[2]
output_after_sleep = psutil.disk_io_counters()[3]

data_input = (input_after_sleep - input_before_sleep)/5
data_output = (output_after_sleep - output_before_sleep)/5

# Network usage: data transfered in and out (bytes/second).

in_before_sleep = psutil.net_io_counters()[0]
out_before_sleep = psutil.net_io_counters()[1]
time.sleep(second)
in_after_sleep = psutil.net_io_counters()[0]
out_after_sleep = psutil.net_io_counters()[1]

net_in = (in_after_sleep - in_before_sleep)/5
net_out = (out_after_sleep - out_before_sleep)/5

# Get date and time

date_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
