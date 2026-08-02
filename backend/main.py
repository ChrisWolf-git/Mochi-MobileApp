from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

stored_data = {}

reactions = {
    "Müde": {
        "text": "Mochi legt sich neben dich und kuschelt sich ein.",
        "icon": "bed",
        "color": "#607D8B"
    },
    "Überreizt": {
        "text": "Mochi baut dir einen kleinen Ruhe‑Kokon.",
        "icon": "flash_on",
        "color": "#FF5252"
    },
    "Erschöpft": {
        "text": "Mochi bringt dir warmen Tee und deckt dich zu.",
        "icon": "hourglass_empty",
        "color": "#9E9E9E"
    },
    "Unruhig": {
        "text": "Mochi hüpft nervös mit dir im Kreis.",
        "icon": "run_circle",
        "color": "#FB8C00"
    },
    "Energetisch": {
        "text": "Mochi springt begeistert auf und ab!",
        "icon": "bolt",
        "color": "#FDD835"
    },
    "Motiviert": {
        "text": "Mochi zeigt dir stolz eine kleine To‑Do‑Liste.",
        "icon": "trending_up",
        "color": "#4CAF50"
    },
    "Überfordert": {
        "text": "Mochi sortiert deine Aufgaben in kleine Häppchen.",
        "icon": "warning",
        "color": "#E64A19"
    },
    "Abgelenkt": {
        "text": "Mochi winkt und versucht deinen Fokus zurückzuholen.",
        "icon": "visibility_off",
        "color": "#9C27B0"
    },
    "Im Hyperfokus": {
        "text": "Mochi setzt sich neben dich und arbeitet mit dir.",
        "icon": "center_focus_strong",
        "color": "#3F51B5"
    },
    "Fröhlich": {
        "text": "Mochi tanzt fröhlich im Kreis!",
        "icon": "sentiment_satisfied",
        "color": "#8BC34A"
    },
    "Gestresst": {
        "text": "Mochi baut dir eine kleine Stress‑Blase zum Durchatmen.",
        "icon": "sentiment_dissatisfied",
        "color": "#F44336"
    },
    "Unsicher": {
        "text": "Mochi nimmt deine Hand und lächelt beruhigend.",
        "icon": "help_outline",
        "color": "#2196F3"
    }
}


class UserData(BaseModel):
    name: str
    mood: str
    level: int

class MochiReaction(BaseModel):
    mood: str
    text: str
    icon: str
    color: str

@app.post("/userdata")
def receive_user_data(data: UserData):
    stored_data["last"] = data.dict()
    return {"message": f"Daten empfangen für {data.name}"}

@app.get("/userdata")
def get_user_data():
    return stored_data.get("last", {})

@app.get("/reaction/{mood}")
def get_reaction(mood: str):
    if mood in reactions:
        return reactions[mood]
    return {"text": "Mochi weiß nicht, wie er reagieren soll.", "icon": "help", "color": "#000000"}
