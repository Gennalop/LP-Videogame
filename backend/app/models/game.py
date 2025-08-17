from pydantic import BaseModel

class Score(BaseModel):
    player_id: str
    points: int

class Player(BaseModel):
    player_id: str
    difficulty: str  # Ejemplo: "facil", "media", "dificil"