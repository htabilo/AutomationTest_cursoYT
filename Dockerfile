# 1. IMAGEN BASE
# Usamos una imagen de Python ligera y estable (3.11-slim-bookworm)
FROM python:3.11-slim-bookworm

# 2. INSTALACIÓN DE GOOGLE CHROME Y DEPENDENCIAS DEL SISTEMA
# Instala las librerías necesarias para correr un navegador en modo headless
# y añade Google Chrome (stable) a través de su repositorio oficial.
RUN apt-get update && \
    apt-get install -y \
    wget \
    gnupg \
    unzip \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libgcc1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    ca-certificates \
    fonts-liberation \
    lsb-release \
    xdg-utils \
    # Instala Google Chrome (estable)
    && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /etc/apt/keyrings/google-chrome.gpg \
    && echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y google-chrome-stable \
    # Limpieza para reducir el tamaño de la imagen
    && rm -rf /var/lib/apt/lists/*

# 3. CONFIGURACIÓN DEL ENTORNO DE TRABAJO
# Establece la carpeta principal para el código
WORKDIR /app

# 4. INSTALACIÓN DE DEPENDENCIAS DE PYTHON
# Copia requirements.txt y lo instala
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. COPIA DEL CÓDIGO
# Copia el código de prueba (incluyendo test_selenium.py) al contenedor
COPY . .

# 6. COMANDO DE EJECUCIÓN
# Define el comando que se ejecutará por defecto al iniciar el contenedor (ejecutar Pytest)
CMD ["pytest", "-v"]
