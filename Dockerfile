# ── Image de base ─────────────────────────────────────────────
FROM python:3.11-slim

# Répertoire de travail dans le container
WORKDIR /app

# Dépendances système nécessaires pour mysql-connector
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copier et installer les dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier tout le code source
COPY . .

# Exposer le port de l'API
EXPOSE 8002

# Lancer l'application
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8002"]