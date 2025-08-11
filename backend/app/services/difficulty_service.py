difficulties = {}

def set_difficulty(player_id: str, difficulty: str):
    print(f"Estableciendo dificultad: player_id={player_id}, difficulty={difficulty}")
    difficulties[player_id] = difficulty
    print(f"Dificultad actual para {player_id}: {difficulties[player_id]}")
    return difficulties[player_id]

def get_difficulty(player_id: str):
    print(f"Consultando dificultad para player_id={player_id}")
    return difficulties.get(player_id, "facil")  # Valor por defecto

def get_all_difficulties():
    print("Consultando todas las dificultades")
    return sorted(difficulties.items(), key=lambda x: x[0])