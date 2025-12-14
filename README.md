# Insight-Agent MVP

## Overview
**Insight-Agent** is a minimal viable product (MVP) designed to analyze text input and provide simple metrics such as word and character counts. The application is built using **Python** with **FastAPI** and deployed serverlessly on **Google Cloud Platform (GCP) Cloud Run**. The infrastructure is fully managed via **Terraform**, and CI/CD is automated using **GitHub Actions** with Docker and Artifact Registry.

### Architecture
+--------------------+
| GitHub Repository |
+---------+----------+
|
v
GitHub Actions CI/CD
|
v
+---------------------+
| Docker Image Build |
| & Push to AR |
+----------+----------+
|
v
Cloud Run
|
v
FastAPI App

**GCP Services Used:**
- **Cloud Run:** Serverless deployment for the FastAPI application.
- **Artifact Registry:** Stores Docker images securely.
- **Cloud Build / GitHub Actions:** CI/CD pipeline for building and deploying images.
- **Terraform:** Infrastructure-as-Code (IaC) for reproducible deployment.

---

## Design Decisions

1. **Cloud Run:**  
   Chosen for its serverless, fully-managed environment. It automatically scales based on traffic and simplifies deployment without managing VM infrastructure.

2. **Security:**  
   - All sensitive credentials (service account keys, project IDs) are stored as **GitHub secrets**.  
   - Docker authentication is performed with `gcloud auth configure-docker` to securely push images to Artifact Registry.  
   - Terraform service account key is used locally during deployment and removed after execution to prevent leakage.

3. **CI/CD Pipeline:**  
   - On every push to `main`, GitHub Actions builds the Docker image, pushes it to Artifact Registry, and triggers Terraform to deploy/update Cloud Run.  
   - Linting with `flake8` ensures code quality before deployment.  
   - Docker image tags use `${GITHUB_SHA}` for traceability.

---

## Setup and Deployment Instructions

Follow these steps to set up and run the project from scratch:

### Prerequisites
- Google Cloud account with permissions for Cloud Run, Artifact Registry, and IAM.
- Terraform installed locally.
- Docker installed locally.
- GitHub account with repository access.

### Steps

1. **Clone the Repository**
```bash
git clone https://github.com/<your-username>/insight-agent.git
cd insight-agent


Set Up GCP Service Account

Create a service account with roles: roles/run.admin, roles/iam.serviceAccountUser, roles/artifactregistry.writer.

Download the service account key JSON file.

Add GitHub Secrets

Go to your GitHub repository settings → Secrets → Actions.

Add the following secrets:

GCP_PROJECT_ID → your GCP project ID

GCP_SA_KEY → the JSON content of your service account key

Configure Terraform
cd terraform
terraform init
terraform apply -auto-approve
cd terraform
terraform init
terraform apply -auto-approve

cd terraform
terraform init
terraform apply -auto-approve

This will provision Cloud Run, necessary IAM bindings, and any other infrastructure.

Build and Push Docker Image (Locally, Optional)

export PROJECT_ID=<your-project-id>
export LOCATION=us-central1
export ARTIFACT_REPO=insight-agent-repo
export IMAGE="$LOCATION-docker.pkg.dev/$PROJECT_ID/$ARTIFACT_REPO/insight-agent:latest"

docker build -t $IMAGE ./app
gcloud auth configure-docker $LOCATION-docker.pkg.dev
docker push $IMAGE

6. Deploy to Cloud Run

gcloud run deploy insight-agent \
  --image $IMAGE \
  --platform managed \
  --region $LOCATION \
  --allow-unauthenticated

7.Access the Application

After deployment, Cloud Run provides a URL to access the FastAPI application.

Notes

Secrets are never committed to the repository.

Terraform service account key is removed automatically after deployment.

The CI/CD pipeline ensures consistent deployments and versioned Docker images.
