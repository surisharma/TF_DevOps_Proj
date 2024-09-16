#! /bin/bash
# shellcheck disable=SC2164
cd /home/ubuntu
sudo apt update
sudo apt install python3 python3-pip
#yes | sudo apt update
#yes | sudo apt install python3 python3-pip
git clone https://github.com/rahulwagh/python-mysql-db-proj-1.git
sleep 20
# shellcheck disable=SC2164
cd python-mysql-db-proj-1
pip3 install -r requirements.txt --break-system-packages
echo 'Waiting for 30 seconds before running the app.py'
setsid python3 -u app.py &
sleep 30
