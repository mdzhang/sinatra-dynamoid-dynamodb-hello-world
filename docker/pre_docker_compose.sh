# TODO: pretty sure this throws an error on many Linux machines?
if hash docker-machine 2>/dev/null; then
  # IP will be the IP of the virtual machine on non-linux machines, where docker cannot run natively
  export DOCKER_HOST_IP=$(docker-machine ip $(docker-machine active));
else
 export DOCKER_HOST_IP='127.0.0.1';
fi