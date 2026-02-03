#!/bin/ash
# This is intended to be run inside the skypilot container. It installs dependencies (pytest), and runs the upstream smoke test.

cd /skypilot
pip install -r requirements-dev.txt
python - <<'PY'
from pathlib import Path

path = Path('tests/smoke_tests/smoke_tests_utils.py')
text = path.read_text()
old = "LOW_RESOURCE_ARG = '--cpus 2+ --memory 4+'"
new = "LOW_RESOURCE_ARG = '--cpus 4+ --memory 8+'"
if old not in text:
	raise SystemExit('LOW_RESOURCE_ARG definition not found or already patched.')
path.write_text(text.replace(old, new, 1))
PY
SKYPILOT_DISABLE_USAGE_COLLECTION=1 SKYPILOT_SKIP_CLOUD_IDENTITY_CHECK=1 pytest tests/smoke_tests/test_basic.py::test_minimal --terminate-on-failure  --generic-cloud runpod