import docker
import argparse

def restart_service(container_name):
    client = docker.from_env()
    try:
        container = client.containers.get(container_name)
        container.restart()
        print(f"Service '{container_name}' restarted successfully.")
    except docker.errors.NotFound:
        print(f"Service '{container_name}' not found.")


parser = argparse.ArgumentParser(description='Restart a Docker service.')
parser.add_argument('container_name', type=str, help='The name of the container to restart')
args = parser.parse_args()

restart_service(args.container_name)
