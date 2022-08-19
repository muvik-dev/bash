curl -s https://raw.githubusercontent.com/muvik-dev/bash/main/ATH/logo.sh | bash
if [ -x "$(command -v docker)" ]; then
    echo "Docker already installed"
    if [[ "$(docker images -q muvikdev/monitoring:latest > /dev/null)" == "" ]]; then
      echo "-----------------------------------------------------------------------------"
      echo "Image already exist"
      if [ "$( docker container inspect -f '{{.State.Running}}' MONITORING )" == "true" ]; then
        echo "-----------------------------------------------------------------------------"
        echo "Container already running, adding to autostart"
        docker update --restart=always [MONITORING] &>/dev/null
      else
        echo "-----------------------------------------------------------------------------"
        echo "Start container"
        docker start MONITORING &>/dev/null
        docker update --restart=always [MONITORING] &>/dev/null
      fi
    else
      echo "-----------------------------------------------------------------------------"
      echo "Image doesn't exist"
      docker pull muvikdev/monitoring:latest
      echo "-----------------------------------------------------------------------------"
      echo "Pull image"
      docker run -d -p 5678:5678 --name MONITORING muvikdev/monitoring:latest
      echo "-----------------------------------------------------------------------------"
      echo "Start container on 5678 port"
      if [ "$( docker container inspect -f '{{.State.Running}}' MONITORING )" == "true" ]; then
        echo "-----------------------------------------------------------------------------"
        echo "Container already running, adding to autostart"
        docker update --restart=always [MONITORING] &>/dev/null
      fi
    fi
else
    echo "Install docker"
    sudo apt update -y &>/dev/null
    sudo apt install apt-transport-https ca-certificates curl software-properties-common -y &>/dev/null
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" &>/dev/null
    sudo apt update -y &>/dev/null
    apt-cache policy docker-ce &>/dev/null
    sudo apt install docker-ce -y &>/dev/null
    docker pull muvikdev/monitoring:latest &>/dev/null
    docker run -d -p 5678:5678 --name MONITORING muvikdev/monitoring:latest &>/dev/null
    docker update --restart=always [MONITORING] &>/dev/null
fi
echo "-----------------------------------------------------------------------------"
echo "Install completed"