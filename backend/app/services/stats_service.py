import json
from pathlib import Path
from app.models.stats import Stats

_stats_file = Path("stats.json")

def add_stats_record(stats_record: dict):
    try:
        if _stats_file.exists():
            with _stats_file.open() as f:
                data = json.load(f)
        else:
            data = []
    except json.JSONDecodeError:
        data = []
    data.append(stats_record)
    with _stats_file.open("w") as f:
        json.dump(data, f, indent=2)


def get_stats_history():
    try:
        if _stats_file.exists():
            with _stats_file.open() as f:
                return json.load(f)
    except json.JSONDecodeError:
        return []
    return []
