import fastapi


from typing import Union

from fastapi import FastAPI
import uvicorn
app = FastAPI()
import datetime
import os
@app.get("/")
def read_root():
    return {"Node ID: ": os.environ.get("NODE_ID"), "Pod ID: ": os.environ.get("POD_ID"), "time": datetime.datetime.now()}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=80, reload=False,
                workers=1)
