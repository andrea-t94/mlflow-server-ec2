FROM python:3.8.5
LABEL maintainer="Andrea Tamburri atamburriandrea1@gmail.com"
ARG MLFLOW_VERSION=1.29.0

WORKDIR .
RUN pip install --no-cache-dir mlflow==$MLFLOW_VERSION
RUN pip install boto3 sqlalchemy==1.4.26


ENV LOCAL_DIR database
ENV BACKEND_URI sqlite:///${LOCAL_DIR}/mlruns.db

RUN mkdir -p ${LOCAL_DIR}/

CMD mlflow server \
    --backend-store-uri ${BACKEND_URI} \
    --default-artifact-root ${ARTIFACT_ROOT}  \
    --host 0.0.0.0


