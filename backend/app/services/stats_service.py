import json

_stats_history = {} 

def add_stats_record(stats_record: dict):
    jugador = stats_record["jugador"]
    _stats_history.setdefault(jugador, []).append(stats_record)
    with open("stats.json", "w") as f:
        json.dump(_stats_history, f)

def get_stats_history(jugador: str = None):
    try:
        with open("stats.json") as f:
            data = json.load(f)
    except FileNotFoundError:
        data = {}
    if jugador:
        return data.get(jugador, [])
    return data
