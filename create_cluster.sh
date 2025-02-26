#!/bin/bash

# Define the Redis cluster node names
REDIS_NODES=(
  "redis-cluster-redis1-1"
  "redis-cluster-redis2-1"
  "redis-cluster-redis3-1"
  "redis-cluster-redis4-1"
  "redis-cluster-redis5-1"
  "redis-cluster-redis6-1"
)

# Function to get the IP address of a container
get_container_ip() {
  local container_name="$1"
  docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}:6379{{end}}' "$container_name"
}

# Build the Redis cluster create command
redis_cluster_create_command="redis-cli --cluster create"

# Confirmation prompt
read -p "This script will remove existing Redis data and create a new cluster. Continue? (y/n): " confirm
if [[ "$confirm" != "y" ]]; then
  echo "Aborted."
  exit 1
fi

# Clean up existing containers and volumes
docker-compose down -v
docker-compose up -d

# Get container IP addresses and build command
for node in "${REDIS_NODES[@]}"; do
  redis_cluster_create_command+=" $(get_container_ip "$node")"
done

redis_cluster_create_command+=" --cluster-replicas 1"

# Execute the Redis cluster create command within the first node
echo "Creating Redis cluster with command:"
echo "$redis_cluster_create_command"
docker exec -it "${REDIS_NODES[0]}" sh -c "$redis_cluster_create_command"

# Check if the cluster was created successfully (you may want to add more robust error handling)
if [ $? -eq 0 ]; then
  echo "Redis cluster created successfully!"
else
  echo "Failed to create Redis cluster."
fi

exit $?