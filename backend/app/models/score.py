from pydantic import BaseModel

class Score(BaseModel):
    player_id: str
    points: int