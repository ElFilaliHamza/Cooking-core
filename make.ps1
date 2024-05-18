param (
    [string]$task
)

switch ($task) {
    "install" {
        poetry install --no-root
        break
    }
    "update" {
        ./make.ps1 install
        ./make.ps1 migrate
        ./make.ps1 install-precommit
        break
    }
    "run-server" {
        python -m cooking_core.manage runserver
        break
    }
    "migrate" {
        python -m cooking_core.manage migrate
        break
    }
    "migrates" {
        python -m cooking_core.manage makemigrations
        python -m cooking_core.manage migrate
        break
    }
    "superuser" {
        python -m cooking_core.manage createsuperuser
        break
    }
    "makemigrations"{
        python -m cooking_core.manage makemigrations
        python -m cooking_core.manage migrate
        break
    }
    "collectstatic" {
        python -m cooking_core.manage collectstatic --noinput
        break
    }
    "precommit-all" {
        poetry run pre-commit run --all-files
        break
    }
    "install-precommit" {
        poetry run pre-commit uninstall
        poetry run pre-commit install
        break
    }
    "up-dependencies-only" {
        if (-Not (Test-Path .env)) {
            New-Item -Path .env -ItemType File
        }
        docker-compose -f docker-compose.dev.yml up --force-recreate db
        break
    }
    default {
        Write-Output "Unknown task: $task"
        Write-Output "try one of these : install-precommit, precommit-all, collectstatic, makemigrations, superuser,migrates, migrate, run-server,update, install"
        break
    }
}
