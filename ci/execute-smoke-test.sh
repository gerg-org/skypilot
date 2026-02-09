#!/bin/bash
# This is intended to be run inside the skypilot container. It installs dependencies (pytest), and runs the upstream smoke test.

set -eu

cd /skypilot
pip install -r requirements-dev.txt
python - <<'PY'
from pathlib import Path

path = Path('tests/smoke_tests/smoke_tests_utils.py')
text = path.read_text()
old = "LOW_RESOURCE_ARG = '--cpus 2+ --memory 4+'"
new = "LOW_RESOURCE_ARG = '--cpus 6+ --memory 8+'"
disk_old = "disk_size_param = '--disk-size 20'"
disk_new = "disk_size_param = '--disk-size 50'"
if old not in text:
	raise SystemExit('LOW_RESOURCE_ARG definition not found or already patched.')
if disk_old not in text:
	raise SystemExit('disk_size_param definition not found or already patched.')
text = text.replace(old, new, 1)
text = text.replace(disk_old, disk_new, 1)
path.write_text(text)
PY
SKYPILOT_DISABLE_USAGE_COLLECTION=1 SKYPILOT_SKIP_CLOUD_IDENTITY_CHECK=1 pytest tests/smoke_tests/test_basic.py::test_minimal --terminate-on-failure  --generic-cloud runpod