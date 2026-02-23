# Python Quick Commands (CPT201)

## Virtual env + packages
- `python -m venv .venv`
- Windows: `.venv\Scripts\activate`
- `pip install -r requirements.txt`
- `pip freeze > requirements.txt`

## Files
```python
from pathlib import Path
p = Path("Output")
p.mkdir(exist_ok=True)
text = Path("log.txt").read_text(encoding="utf-8")
Path("Output/out.txt").write_text("hello", encoding="utf-8")
