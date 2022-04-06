#!/bin/bash

password="$1"
container_name="tensorflow-jupyter"
containers=$(docker ps | grep -E "$container_name")

if [ "$containers" == "" ]; then
  echo Server is not running...
  docker-compose up -d
else
  echo Server is running...
fi

count=0

while true; do
  containers=$(docker ps | grep "$container_name")

  if [ "$containers" != "" ]; then
    break
  else
    count=$((count + 1))
    echo "Waiting to up... trying $count times"
  fi

  if [ $count == 10 ]; then
    echo "Can not compose up container"
    exit 1
  fi

  sleep 2

done

container_id=$(docker ps -aqf "name=$container_name")

# Password setting
expect -c "
set timeout 5
spawn docker exec -it $container_id jupyter notebook password
expect \"Enter password:\"
send \"${password}\n\"
expect \"Verify password:\"
send \"${password}\n\"
exit 0
"
echo "\n"
unset password

exit 0
