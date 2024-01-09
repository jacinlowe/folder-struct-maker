FROM python:3.11-alpine

ENV PYTHONPATH=${PYTHONPATH}:${PWD} 
RUN pip3 install poetry
RUN poetry config virtualenvs.create false
# COPY requirments.txt ./
COPY pyproject.toml ./
# RUN poetry lock --no-update
RUN poetry export -f requirements.txt --output requirements.txt
RUN pip install -r requirements.txt

COPY . .

ENTRYPOINT flet pack '/src/flet-gui-app/main.py' --name "Struct Maker"

