working_directory "./"
pid '/tmp/pids/unicorn.pid'
stderr_path './log/unicorn.log'
stdout_path './log/unicorn.log'

listen '/tmp/sockets/unicorn.sock'
worker_processes 2
timeout 30
