ARG PYTHON_VERSION_MAJOR=3.13
ARG PYTHON_VERSION_MINOR=1

# ---------------------------------------------------------------------------------------
# BUILD
# ---------------------------------------------------------------------------------------

FROM python:${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}-slim AS builder

WORKDIR /code

COPY pyproject.toml .
COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade -r requirements.txt


# ---------------------------------------------------------------------------------------
# DEPLOY
# ---------------------------------------------------------------------------------------

FROM python:${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}-slim AS runtime

ARG PYTHON_VERSION_MAJOR
ARG PYTHON_VERSION_MINOR

WORKDIR /app

COPY --from=builder /usr/local/lib/python${PYTHON_VERSION_MAJOR}/site-packages /usr/local/lib/python${PYTHON_VERSION_MAJOR}/site-packages
COPY logging.yaml .
COPY app .

EXPOSE 8000

CMD ["python", "-m", "fastapi", "run", "/app/main.py", "--proxy-headers", "--port", "8000"]
