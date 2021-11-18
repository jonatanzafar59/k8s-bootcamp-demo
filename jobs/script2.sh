IN=5
REQUESTS="$((3 * $IN))"
echo $REQUESTS
for i in $(seq 1 $REQUESTS);
do
    echo "$i"
done