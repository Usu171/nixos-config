mkdir -p /root/.ssh
cp ~/.ssh/id_ed25519 /root/.ssh/
cp ~/.ssh/id_ed25519.pub /root/.ssh/
cp ~/.ssh/known_hosts /root/.ssh/
chmod 600 /root/.ssh/id_ed25519
