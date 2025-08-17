from pydantic import BaseModel

class Stats(BaseModel):
    jugador: str
    points: int
    vidas_restantes: int
    play_time: float
    objetos_reciclados: int
    objetos_toxicos: int
    errors: int
