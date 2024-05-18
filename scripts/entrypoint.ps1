# Ensure the script stops on any errors
$ErrorActionPreference = "Stop"

# Define the command to run manage.py with poetry
$RUN_MANAGE_PY = "poetry run python -m cooking_core.manage"

# Collect static files
Write-Output "Collecting static files..."
Invoke-Expression "$RUN_MANAGE_PY collectstatic --no-input"

# Run migrations
Write-Output "Running migrations..."
Invoke-Expression "$RUN_MANAGE_PY migrate --no-input"

# Start the Daphne server
Write-Output "Starting the Daphne server..."
Invoke-Expression "poetry run daphne cooking_core.project.asgi:application -p 8000 -b 0.0.0.0"
