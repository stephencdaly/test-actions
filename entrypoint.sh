#!/bin/sh -l

broker=$1
username=$2
password=$3
consumer=$4
consumer_tag=$5

function pacts_already_verified(){
    can_deploy="$(pact-broker can-i-deploy \
      --pacticipant $consumer --version $consumer_tag \
      --broker_base_url $broker \
      --broker-username $username \
      --broker-password $password \
      --output json)"
    return $?
}

if pacts_already_verified; then
  echo "All $consumer pacts have already been verified"
  exit 0
fi

echo "Providers needing verification: "
echo "$can_deploy"
providers=$(echo "$can_deploy" | \
  jq -r '.matrix[] | select(.verificationResult.success != true) | .provider.name ' | \
  tr '\n' ',' | tr -d '"')

echo "::set-output name=providers-needing-validation::$providers"