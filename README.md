# Insight-Agent


Serverless MVC: FastAPI -> Docker -> Artifact Registry -> Cloud Run


## Architecture
Client (curl / service) -> Cloud Run (private, authenticated) -> (Artifact Registry store images)
### Key design decisions
- **Why Cloud Run?** Cloud Run provides fully managed serverless containers, fast deployments, built-in autoscaling, and simple integration with GCP services. This is ideal for an MVP API.
- **Security:** The Cloud Run service is not made public (`no allUsers invoker`). Authentication is enforced by requiring an identity token (service accounts or aut