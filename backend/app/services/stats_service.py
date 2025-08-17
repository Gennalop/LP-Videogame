# Diccionario que guarda lista de estadísticas por jugador
_stats_history = {}  # { jugador: [ {registro1}, {registro2}, ... ] }

def add_stats_record(stats_record: dict):
    jugador = stats_record["jugador"]
    if jugador not in _stats_history:
        _stats_history[jugador] = []
    _stats_history[jugador].append(stats_record)
    print(f"Agregado registro stats para {jugador}, total registros: {len(_stats_history[jugador])}")

def get_stats_history(jugador: str = None):
    if jugador:
        return _stats_history.get(jugador, [])
    else:
        # Devolver todo el historial para todos los jugadores
        return _stats_history