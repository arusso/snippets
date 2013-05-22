# This code will take a list of hosts, as returned by a puppet api query
# and gather the kernel version it is running, placing the output in 2 files:
#
# host-kernels.csv : lists each host adjacent to the kernel version
# kernel-counts.csv : lists each kernel version adjacent to the number of times
#                     it appears
require 'yaml'

hosts = YAML::load( File.open('hosts.yaml') )

kernel = { }

hosts.each do |host|
  out = %x[ ssh -o StrictHostKeyChecking=no -o ConnectTimeout=2 -a -T #{host} "uname -r" ]
  if ! out =~ /^2\.6\.32/
    # probably dead
    out = 'bad output'
  end
  kernel[host] = out
end

count = Hash.new(0)

kernel.each do |host,version|
  count[version]+=1
end


File.open('host-kernels.csv', 'w') { |hk|
  kernel.each do |host,version|
    hk.write("#{host},#{version}\n")
  end
}

File.open('kernel-counts.csv', 'w') { |kc|
  count.each do |k,c|
    kc.write("#{k},#{c}\n")
  end
}
