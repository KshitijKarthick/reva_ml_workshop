#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

install_core_dependencies() {
    echo -e "${RED}Installing Core Dependencies${NC}"
    sudo apt-get update
    sudo apt-get install python-dev
    sudo apt-get install python-pip
    sudo pip install --upgrade pip
    sudo -H pip install virtualenv
}

install_python_dependencies() {
    echo -e "${RED}Installing Python Dependencies${NC}"
    pip install -r requirements.txt
}

create_python_environment() {
    echo -e "${RED}Creating Python Environment${NC}"
    virtualenv venv
}

activate_python_enviroment() {
    echo -e "${RED}Activating Python Environment${NC}"
    source venv/bin/activate
}

deactivate_python_environment() {
    echo -e "${RED}Deactivating Python Environment${NC}"
    deactivate
}

setup_environment() {
    install_core_dependencies
    create_python_environment
    activate_python_enviroment
    install_python_dependencies
    deactivate_python_environment
}

clean() {
    echo -e "${RED}Cleaning Environment${NC}"
    rm -rf venv
}

start_jupyter_environment() {
    activate_python_enviroment
    echo -e "${RED}Starting Jupyter Notebook${NC}"
    jupyter notebook
    deactivate_python_environment
}

if [ "$1" == "install" ]; then
    setup_environment
elif [ "$1" == "jupyter" ]; then
    start_jupyter_environment
elif [ "$1" == "activate" ]; then
    activate_python_enviroment
elif [ "$1" == "deactivate" ]; then
    deactivate_python_environment
elif [ "$1" == "clean" ]; then
    clean
else
    echo -e "Usage: ./setup.sh [options]"
    echo -e "install\t\t: Install python and all dependencies required."
    echo -e "jupyter\t\t: Start Jupyter notebook"
    echo -e "clean\t\t: Clean Python Environment"
    echo -e "activate\t: Activate python environment"
    echo -e "deactivate\t: Deactivate python environment"
fi