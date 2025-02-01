import logging

import yaml
from fastapi import FastAPI
from fastapi.responses import PlainTextResponse, JSONResponse

with open("logging.yaml", "rt") as f:
    logging_config = yaml.safe_load(f.read())

logging.config.dictConfig(logging_config)


app = FastAPI(
    title="FastAPI-app-example",
    description="A simple FastAPI application that returns 'Hello, World!' at the root endpoint (/).",
)


@app.get("/", response_class=PlainTextResponse)
async def read_root():
    return "Hello, World!"


@app.get("/health", response_class=JSONResponse)
async def health():
    return {"status": "ok"}
