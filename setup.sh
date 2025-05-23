#!/bin/bash
set -e

curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt-get update
sudo apt install -y openjdk-17-jdk ufw ngrok screen unzip p7zip-full neofetch btop wget curl git
curl -fsSL https://tailscale.com/install.sh | sh && \
mkdir ~/Main
touch ~/Main/startup.sh
echo "java -Xms8G -Xmx24G -XX:+UseG1GC -XX:MaxGCPauseMillis=50 -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+UseCompressedOops -Dfile.encoding=UTF-8 -XX:+UseStringDeduplication -XX:+OptimizeStringConcat -XX:+UnlockDiagnosticVMOptions -XX:+ParallelRefProcEnabled -XX:InitiatingHeapOccupancyPercent=75 -jar ~/Server/paper.jar -o true --nogui" >> ~/Main/startup.sh
sudo update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java
git clone https://github.com/qhuyluvyou/Arclyx0.git Server/
cp -rf ~/Main/* Server/.
cd Server
chmod +x ~/Server/startup.sh
unzip ~/Server/spawn.zip
rm -rf .git
echo "alias qhuy='bash ~/Server/startup.sh'" >> ~/.bashrc
source ~/.bashrc
echo "🎉 Setup complete! Now restart your terminal (or run source ~/.bashrc) and summon your mighty server with 'qhuy'"
echo "To connect, login in tailscaled with command: sudo tailscale up --auth-key=tskey-auth-kbY3b8o4Sk11CNTRL-NfHE5os4bmGUSRgb3V99nGESDCG6SVm95"
