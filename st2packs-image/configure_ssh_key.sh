if [ "$SSH_PRIVATE_KEY" ] ;
then mkdir /root/.ssh/ && echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa && \
  chmod 400 /root/.ssh/id_rsa && \
  echo -e "StrictHostKeyChecking no\n" >> /etc/ssh/ssh_config;
fi
