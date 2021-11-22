# HOSTNAME="WEB-0"
# CONSUL=localhost
CONSUL=consul
INDEX=${HOSTNAME##*-}
if [ $INDEX -gt 0 ]; then
    PREVIOUS_INDEX="$(($INDEX - 1))"
    NAME="${HOSTNAME%-*}"
    until [ "$(curl --silent  http://$CONSUL/v1/kv/last?raw)" = $PREVIOUS_INDEX ]; do echo waiting for previous "$NAME-$PREVIOUS_INDEX" pod; sleep 2; done
    echo "Found index $PREVIOUS_INDEX"
fi
echo "Writing current INDEX $INDEX to 'http://$CONSUL/v1/kv/last'"
curl --silent --request PUT http://$CONSUL/v1/kv/last --data "$INDEX" > /dev/null