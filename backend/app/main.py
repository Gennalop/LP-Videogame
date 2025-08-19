from fastapi import FastAPI
#from backend.app.models import game
from .routes import score_routes, stats_routes, difficulty_routes

app = FastAPI(
    title="Backend Juego Reciclaje",
    description="API para manejar puntajes, estadísticas y materiales",
    version="1.0.0"
)

app.include_router(score_routes.router)
app.include_router(stats_routes.router)
app.include_router(difficulty_routes.router)

@app.get("/")
def root():
    return {"message": "API del juego de reciclaje funcionando"}

