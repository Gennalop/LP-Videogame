from fastapi import APIRouter
from backend.app.models.game import Player
from backend.app.services.difficulty_service import set_difficulty, get_difficulty

router = APIRouter()

@router.post("/player/{player_id}/difficulty")
def change_difficulty(player_id: str, player: Player):
    set_difficulty(player_id, player.difficulty)
    return {"player_id": player_id, "difficulty": player.difficulty}

@router.get("/player/{player_id}/difficulty")
def show_difficulty(player_id: str):
    difficulty = get_difficulty(player_id)
    return {"player_id": player_id, "difficulty": difficulty}