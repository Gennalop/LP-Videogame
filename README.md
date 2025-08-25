# LP-Videogame. EchoCatch Demo
Demo del juego **EchoCatch**, un juego educativo de reciclaje. Esta guía explica las herramientas necesarias y los pasos para probar la demo en Linux con el backend en `localhost`.

---

## Requisitos Previos

- **Python 3.10+** recomendado.
- Flutter
- Dependencias: FastAPI, Uvicorn, Pydantic, etc.
- Sistema operativo: Linux (los comandos abajo son para Linux).

### Pasos para levantar el backend en Linux

1. Abrir terminal y navegar a la carpeta del backend:
2. Crear un entorno virtual limpio:
```bash
rm -rf .venv
python3 -m venv .venv
```
3. Activar el entorno virtual:
```bash
source .venv/bin/activate
```
4.  Instalar dependencias:
```bash
pip install -r requirements.txt
```
5.  Levantar el servidor:
```bash
uvicorn app.main:app --reload
```
Esto levantará el backend en `http://127.0.0.1:8000`.

- Nota: El flag `--reload` permite que el servidor se reinicie automáticamente al modificar código.

---

## Levantar el Frontend (Flutter)

1. Abre una terminal en la carpeta del proyecto Flutter.
2. Instala las dependencias del proyecto:
```bash
flutter pub get
```
3. Ejecuta el proyecto en un navegador o emulador:
```bash
flutter run -d chrome
```

Asegúrate de que el backend esté corriendo antes de iniciar la app, para que las llamadas a la API funcionen correctamente.
