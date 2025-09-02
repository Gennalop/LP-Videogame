from fastapi import APIRouter, Query
from app.services.trash_service import generate_trash
from app.models.trash import Trash

router = APIRouter(prefix="/trash", tags=["trash"])

@router.get("/generate_trash", response_model=Trash)
def generate_trash_route(
    mode: str = Query("color", enum=["color", "reciclable"]),
    difficulty: str = Query("normal", enum=["facil", "normal", "dificil"])
):
    return generate_trash(mode, difficulty)
