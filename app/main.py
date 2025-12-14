from fastapi import FastAPI, HTTPException
from pydantic import BaseModel


class TextPayload(BaseModel):
text: str


app = FastAPI(title="Insight-Agent", version="0.1")


@app.post('/analyze')
async def analyze(payload: TextPayload):
if payload is None or payload.text is None:
raise HTTPException(status_code=400, detail="text is required")
text = payload.text
words = text.split()
word_count = len(words)
char_count = len(text)
return {
"original_text": text,
"word_count": word_count,
"character_count": char_count
}


if __name__ == '__main__':
import uvicorn
uvicorn.run(app, host='0.0.0.0', port=8080)