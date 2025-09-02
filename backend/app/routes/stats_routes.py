from fastapi import APIRouter, Query
from app.models.stats import Stats
from app.services.stats_service import add_stats_record, get_stats_history

router = APIRouter(prefix="/stats", tags=["stats"])

@router.post("/add")
def post_stats(update: Stats):
    add_stats_record(update.dict())
    return {"message": "Registro agregado correctamente"}

@router.get("/")
def get_stats_route():
    records = get_stats_history()
    if not records:
        return {"message": "No se encontraron registros"}
    return records
