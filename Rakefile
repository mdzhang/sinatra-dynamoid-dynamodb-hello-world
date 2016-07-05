task :run_app_locally do
  sh %{ shotgun app.rb --port=4567 }
end

task :run_app_docker do
  sh %{ source docker/pre_docker_compose.sh && docker-compose up -d }
end