# Base image from my multi stage Dockerfile
FROM python:3.12-slim AS builder

# sets the working directory
WORKDIR /app

# copy list dependencies into our app directory
COPY requirements.txt .

RUN python3 -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

# install those dependencies and removes the cache copy
RUN pip install --no-cache-dir -r requirements.txt

# ---- Final stage ----
FROM python:3.12-slim

WORKDIR /app

COPY --from=builder /opt/venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

COPY . .

# non-root 
RUN useradd -m appuser

USER appuser

# Expose Port 
EXPOSE 8080

# run command 
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8080"]