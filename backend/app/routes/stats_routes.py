from fastapi import APIRouter, Query
from backend.app.models.stats import Stats
from backend.app.services.stats_service import add_stats_record, get_stats_history

router = APIRouter(prefix="/stats", tags=["stats"])

@router.post("/add")
def post_stats(update: Stats):
    add_stats_record(update.dict())
    return {"message": f"Registro agregado para jugador {update.jugador}"}

@router.get("/")
def get_stats_route(jugador: str = Query(None, description="Nombre del jugador para consultar historial")):
    records = get_stats_history(jugador)
    if not records:
        return {"message": "No se encontraron registros"}
    return records
