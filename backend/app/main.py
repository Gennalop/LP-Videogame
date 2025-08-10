from fastapi import FastAPI
from app.routes import game

app = FastAPI(
    title="Backend Juego Reciclaje",
    description="API para manejar puntajes, estadísticas y materiales",
    version="1.0.0"
)

# Rutas
app.include_router(game.router)

@app.get("/")
def root():
    return {"message": "API del juego de reciclaje funcionando"}
