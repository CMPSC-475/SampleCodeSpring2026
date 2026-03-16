from uuid import uuid4

from fastapi import APIRouter, HTTPException, status

from models import UserSignup, UserLogin, TokenResponse, User
from database import get_all_users, save_users
from auth import (
    hash_password,
    verify_password,
    find_user_by_email,
    create_token_for_user,
)

router = APIRouter()


@router.post("/signup", response_model=TokenResponse, status_code=status.HTTP_201_CREATED, tags=["auth"])
async def signup(payload: UserSignup):
    #TODO: Implement signup
    return {"message": "Signup not implemented"}


@router.post("/login", response_model=TokenResponse, tags=["auth"])
async def login(payload: UserLogin):
    #TODO: Implement login
    return {"message": "Login not implemented"}
