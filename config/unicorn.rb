working_directory "./"
pid '/var/pids/unicorn.pid'
stderr_path './log/unicorn.log'
stdout_path './log/unicorn.log'

listen '/var/sockets/improf.club.sock'
worker_processes 2
timeout 30
