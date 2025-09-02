import random
from app.models.trash import Trash

colors = {
    "verde": ["trash/verde/1.png", "trash/verde/2.png"],
    "azul": ["trash/azul/a1.png", "trash/azul/a2.png"],
    "negro": ["trash/negro/n1.png"]
}

categories = {
    "verde": "reciclable",
    "azul": "reciclable",
    "negro": "no_reciclable"
}

def generate_trash(mode: str, difficulty: str) -> Trash:
    color = random.choice(list(colors.keys()))
    speed_ranges = {
        "facil": (1.0, 2.0),
        "normal": (2.0, 3.5),
        "dificil": (3.5, 5.0)
    }
    min_speed, max_speed = speed_ranges.get(difficulty, (2.0, 3.0))
    speed = round(random.uniform(min_speed, max_speed), 2)
    category = None
    if mode == "color":
        category = color
    elif mode == "reciclable":
        category = categories.get(color)
    chosen_image = random.choice(colors[color])
    return Trash(color=color, category=category, image=chosen_image, speed=speed)
