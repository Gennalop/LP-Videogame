from fastapi import APIRouter
from backend.app.models.score import Score
from backend.app.services.score_service import get_all_scores, update_score, get_score

router = APIRouter()

@router.post("/score/update")
def capture_recyclable(score: Score):
    print(f"Recibido: player_id={score.player_id}, points={score.points}")
    #Para Aumentar puntos para un jugador
    total = update_score(score.player_id, 
                         score.points
                         
                         )
    
    print(f"Nuevo total para {score.player_id}: {total}")
    return {"player_id": score.player_id, 
            "total_points": total
            
            }

@router.get("/score/{player_id}")
def show_score(player_id: str):

    #Para mostrar puntos totales de un jugador
    total = get_score(player_id)

    return {"player_id": player_id, 
            "total_points": total}

@router.get("/ranking")
def get_ranking():
    ranking = get_all_scores()
    return [{"player_id": player_id, "points": points} for player_id, points in ranking]

