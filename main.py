# main.py
from fastapi import FastAPI, HTTPException, Path, Request
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
from services import content_service, review_service

app = FastAPI()

# Allow CORS for frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class ReviewInput(BaseModel):
    guest_id: str
    name: str
    rating: int
    comment: str

@app.get("/api/object/{slug}")
async def get_object_content(slug: str = Path(...)):
    content = content_service.get_content_by_slug(slug)
    if not content:
        raise HTTPException(status_code=404, detail="Content not found")
    return {"success": True, "data": content}

@app.post("/api/review/submit")
async def submit_review(review: ReviewInput):
    result = review_service.submit_review(review.dict())
    if not result:
        raise HTTPException(status_code=400, detail="Review submission failed")
    return {"success": True, "data": result}
