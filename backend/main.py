from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

stored_data = {}

class UserData(BaseModel):
    name: str
    mood: str
    level: int

@app.post("/userdata")
def receive_user_data(data: UserData):
    stored_data["last"] = data.dict()
    return {"message": f"Daten empfangen für {data.name}"}

@app.get("/userdata")
def get_user_data():
    return stored_data.get("last", {})
