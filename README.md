# FastAPI-app-example

## Description
This is a simple example of a FastAPI application. It includes a simple API with a single endpoint that returns a JSON response.
The application is containerized using Docker and uses Traefik as a reverse proxy and load balancer.

## How to run
### Local execution
0. Install Docker and Docker Compose
1. Clone the repository
2. Run the following command in the root directory of the project to build the Docker image:
```bash
docker-compose build
```
3. Run the following command to start the FastAPI application and local load balancer:
```bash
docker-compose up
```
4. Verify that the application is running:
```bash
docker-compose ps
```
5. Open a web browser and navigate to [http://app-example-backend.localhost/](http://app-example-backend.localhost/)
6. Access OpenAPI documentation at [http://app-example-backend.localhost/docs](http://app-example-backend.localhost/docs)
7. You can also access Traefik dashboard at [http://localhost:8080/](http://localhost:8080/)

### Alternative execution
You can also run the FastAPI application without Traefik by running the following command:
```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
fastaapi run main:app
```
The application will be available at [http://localhost:8000/](http://localhost:8000/)

## CI/CD
The repository includes a GitHub Actions workflow that runs the tests and builds the Docker image on every push to the main branch.
The CI/CD pipeline can be found in `.github/workflows/ci-cd.yml`.
There are four important stages in the pipeline:
- Linting: Runs `flake8` to check the code quality.
- Build: Builds the Docker image.
- Test: Runs the tests of the API endpoints.
- Deploy: Deploys the Docker image to GitHub Container Registry and AWS Elastic Container Registry.

## Deployment
The application deployment logic is defined in the [Terraform](https://github.com/acme-corp-2025-01/terraform) repository. This repository includes the necessary infrastructure code to deploy the FastAPI application to AWS ECS.
You might ask why we are using separate repositories for the application and infrastructure code. This is a best practice in the Infrastructure as Code (IaC) world. It allows us to separate the concerns of the application and infrastructure code, making it easier to manage and scale the application.

## Out of scope
- Application metrics
- [CI/CD] Security scanning
- [CI/CD] Integration testing
- [CI/CD] Load testing
