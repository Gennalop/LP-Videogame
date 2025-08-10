scores = {}  # Diccionario en memoria, no BD

def update_score(player_id: str, points: int):
    print(f"Sumando puntos: player_id={player_id}, points={points}")

    scores[player_id] = scores.get(player_id, 0) + points

    print(f"Total actualizado para {player_id}: {scores[player_id]}")
    return scores[player_id]

def get_score(player_id: str):
    print(f"Consultando puntos para player_id={player_id}")
    return scores.get(player_id, 0)
