from pydantic import BaseModel
from datetime import datetime

class Stats(BaseModel):
    created_at: str
    win: bool
    points: int
    vidas_restantes: int
    play_time: float
    objetos_verdes: int
    objetos_azules: int
    objetos_negros: int
