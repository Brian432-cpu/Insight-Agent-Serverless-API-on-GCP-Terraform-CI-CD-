from fastapi.testclient import TestClient
from app.main import app


client = TestClient(app)


def test_analyze():
resp = client.post('/analyze', json={"text": "I love cloud engineering!"})
assert resp.status_code == 200
data = resp.json()
assert data['word_count'] == 3 or data['word_count'] == 4
assert 'character_count' in data