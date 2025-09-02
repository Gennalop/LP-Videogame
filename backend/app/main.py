from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routes import score_routes, stats_routes, difficulty_routes, trash_routes
from random import choice, uniform

app = FastAPI(
    title="Backend Juego Reciclaje",
    description="API para manejar puntajes, estadísticas y materiales",
    version="1.0.0"
)

# Configuración de CORS para Flutter web
origins = [
    "http://localhost:5173",    # Cambia según la URL de tu Flutter web
    "http://127.0.0.1:5173",
    "http://localhost:5000",    # Opcional, si accedes por otra IP local
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],        # Permitir estas URLs
    allow_credentials=True,
    allow_methods=["*"],          # Permitir todos los métodos HTTP
    allow_headers=["*"],          # Permitir todos los headers
)

app.include_router(score_routes.router)
app.include_router(stats_routes.router)
app.include_router(difficulty_routes.router)
app.include_router(trash_routes.router)

@app.get("/")
def root():
    return {"message": "API del juego de reciclaje funcionando"}