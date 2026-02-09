#!/bin/ash
set -eux

LABEL_SELECTOR="app=test-api"
DEST_PATH="/root/execute-smoke-test.sh"
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
LOCAL_SCRIPT="${SCRIPT_DIR}/execute-smoke-test.sh"

if [ ! -f "${LOCAL_SCRIPT}" ]; then
	echo "Smoke test script not found: ${LOCAL_SCRIPT}" >&2
	exit 1
fi

POD_NAME="$(kubectl get pods -l "${LABEL_SELECTOR}" -o jsonpath='{.items[0].metadata.name}')"

if [ -z "${POD_NAME}" ]; then
	echo "No pods found with label ${LABEL_SELECTOR}" >&2
	exit 1
fi

echo "Found pod ${POD_NAME}"
kubectl cp "${LOCAL_SCRIPT}" "${POD_NAME}:${DEST_PATH}"
kubectl exec "${POD_NAME}" -- chmod +x "${DEST_PATH}"
kubectl exec "${POD_NAME}" -- "${DEST_PATH}"


