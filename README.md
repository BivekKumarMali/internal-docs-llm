# internal-doc-llm

A RAG (retrieval-augmented generation) system for querying a focused document set conversationally, grounded in actual source content instead of relying on a model's training data. Built on Azure OpenAI and Azure AI Search.

Starting corpus: Azure AI documentation (the stuff I'm studying for AI-103 anyway), so the project doubles as exam prep while I build it.

## Status

Infra is live. App code (ingestion, retrieval, generation, API) hasn't started yet, that's next.

## What's done

### Infra (Terraform)

Everything under `infra/` is provisioned and working:

- Resource group
- Azure OpenAI account with two model deployments: `gpt-4o-mini` for chat, `text-embedding-3-small` for embeddings
- Azure AI Search (Basic tier)
- Storage account with a `documents` container, in case the pipeline ends up reading from blob storage instead of local files
- Everything tagged (project / environment / managed_by) so it's identifiable in the portal
- State lives in Terraform Cloud, not locally. No `.tfstate` floating around on my laptop.

### CI/CD

Two GitHub Actions workflows, both driven off Terraform Cloud:

- **`terraform-pr.yml`**: runs on any PR touching `infra/`. Does `fmt`, `validate`, `plan`, and drops the plan output as a PR comment so I can review what's about to change before merging. Doesn't touch real infra.
- **`terraform-dev.yml`**: runs on push to `dev`. Applies for real.

Terraform Cloud workspace and org come from GitHub secrets, not hardcoded. Azure auth (the service principal Terraform runs as) lives in the Terraform Cloud workspace's own variables, kept separate from GitHub entirely.

Auth setup: a dedicated App Registration in Entra ID with Contributor on the subscription (has to be subscription-level since Terraform creates the resource group itself, nothing to scope a narrower role to yet).

### Repo hygiene

- `.gitignore` covers state files, venv, secrets, IDE junk, Terraform crash logs
- `requirements.txt` pinned
- Dockerfile + docker-compose scaffolded under `docker/`, build context is the repo root

## Project Red flags

A few things are deliberately loose right now because this is a learning project, not production, and I'd tighten them if it were:

- Both the OpenAI and Search resources have public network access on. Fine for a solo dev project, wouldn't fly in an actual org, would lock it down with private endpoints or at least IP allowlisting.
- The app talks to OpenAI and Search using access keys (the Terraform outputs), not managed identity. Keys are simpler to wire up first; the better pattern is RBAC through a managed identity so there's no secret sitting in an env file at all. Noted as a next step, not done yet.
- Everything currently runs off one Terraform Cloud workspace and one `dev` branch. No separate prod workspace, because there's no prod, this is a single-environment project. Would split that out if it ever needed to be more than one.

## Stack

Python, FastAPI, Azure OpenAI, Azure AI Search, Terraform, Docker, Terraform Cloud for state and runs, GitHub Actions for the pipeline trigger.

## Next up

- `src/main.py` FastAPI entrypoint
- document ingestion (chunk, embed, push to the search index)
- retrieval + generation endpoints
- eval set (a handful of test questions with known answers)
- architecture diagrams for the README once there's something to diagram
