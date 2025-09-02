from pydantic import BaseModel

class Trash(BaseModel):
    color: str
    category: str
    image: str
    speed: float
