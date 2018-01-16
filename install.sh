#!/bin/bash
# install yara
wget https://github.com/VirusTotal/yara/archive/v3.6.3.tar.gz -O yara.tar.gz
tar -zxf yara.tar.gz
cd yara-3.6.3 
./bootstrap.sh
./configure
make -j 4
sudo make install
cd ..

# install PasteHunter
sudo git clone https://github.com/vishnubob/wait-for-it /opt/wait-for-it
sudo git clone https://github.com/kevthehermit/PasteHunter /opt/PasteHunter
sudo chown -R ${INSTALL_USER}:${INSTALL_USER} /opt/PasteHunter
sudo pip3 install -r /opt/PasteHunter/requirements.txt
cp /opt/PasteHunter/settings.json.sample /opt/PasteHunter/settings.json
sudo cp pastehunter.service /lib/systemd/system/pastehunter.service
sudo systemctl enable pastehunter.service
sudo systemctl start pastehunter.service

# install ELK
wget https://artifacts.elastic.co/downloads/kibana/kibana-5.5.2-amd64.deb
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.5.2.deb
