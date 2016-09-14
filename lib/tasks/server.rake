namespace :server do
  desc "kills rails daemon"
  task kill: :environment do
  	pid_file = 'tmp/pids/server.pid'
    pid = File.read(pid_file).to_i
    Process.kill 9, pid
    File.delete pid_file
  end

  desc "kills unicorn daemon"
  task ukill: :environment do
  	pid_file = '/var/pids/unicorn.pid'
    pid = File.read(pid_file).to_i
    Process.kill 9, pid
    File.delete pid_file
  end

end
