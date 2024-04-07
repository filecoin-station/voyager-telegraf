#!/usr/bin/env bash

getLastMessageGas() {
  account=$1
  cid=$(curl -s -H"Content-Type: application/json" -XPOST -d"{\"query\":\"{messages(address: \\\"${account}\\\", limit: 1, offset: 0) {cid}}\"}" "https://graph.glif.link/query" | jq -r '.data.messages[0].cid')
  curl -s -H"Content-Type: application/json" -XPOST -d"{\"query\":\"{stateReplay(cid: \\\"${cid}\\\") {gasCost {totalCost}}}\"}" "https://graph.glif.link/query" | jq -r '.data.stateReplay.gasCost.totalCost'
}

echo "meridian measureServiceLastMessageGas=$(getLastMessageGas "f410f7r55f5drots2se43ww44ai6eyax2fjfyfwphpyy")i"
echo "meridian evaluateServiceLastMessageGas=$(getLastMessageGas "f410fkdm2qoofuw7tggw4ouc5woh6tagrfhtaz2wc7eq")i"
