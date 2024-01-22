FROM python:3.10-buster as builder
RUN pip install poetry
COPY pyproject.toml poetry.lock poetry.toml ./
RUN touch README.md 
WORKDIR /testk8s
RUN poetry install --no-root --without test && rm -rf $POETRY_CACHE_DIR



FROM python:3.10-slim-buster as runtime
ENV VIRTUAL_ENV=/.venv \
   PATH="/.venv/bin:$PATH"
COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}
COPY testk8s ./testk8s
EXPOSE 5000
WORKDIR /testk8s
CMD ["python", "-m", "main"]
