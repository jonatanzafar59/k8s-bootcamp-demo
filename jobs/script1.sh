    # Point to the internal API server hostname
    APISERVER=https://kubernetes.default.svc

    # Path to ServiceAccount token
    SERVICEACCOUNT=/var/run/secrets/kubernetes.io/serviceaccount

    # Read this Pod's namespace
    NAMESPACE=$(cat ${SERVICEACCOUNT}/namespace)

    # Read the ServiceAccount bearer token
    TOKEN=$(cat ${SERVICEACCOUNT}/token)

    # Reference the internal certificate authority (CA)
    CACERT=${SERVICEACCOUNT}/ca.crt

    # Explore the API with TOKEN
    OUT=$(curl --silent --cacert ${CACERT} --header "Authorization: Bearer ${TOKEN}" -X GET ${APISERVER}/apis/apps/v1/namespaces/${NAMESPACE}/deployments/nodeapp/scale?pretty=true | jq .spec.replicas)
    curl --silent --request PUT http://consul/v1/kv/out --data "$OUT" > /dev/null
    curl --fail --silent --show-error "http://consul/v1/kv/out?raw"
    echo ""