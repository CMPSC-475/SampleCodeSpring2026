from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from pickledb import PickleDB
from contextlib import asynccontextmanager

tasks = []

db = PickleDB("tasks.db")


@asynccontextmanager
async def lifespan(app: FastAPI):
    global db
    await db.load()
    if db is None:
        db = PickleDB("tasks.db")
        db.set("tasks", [])
        db.save()
    yield
    db.save()
    print("Goodbye!")


app = FastAPI(lifespan=lifespan)


class Task(BaseModel):
    id: str
    title: str
    description: str
    completed: bool


@app.get("/tasks")
async def get_tasks():
    tasks = await db.get("tasks") or []
    return tasks

@app.post("/tasks")
async def create_task(task: Task):
    tasks = await db.get("tasks") or []
    tasks.append(task.model_dump())
    await db.set("tasks", tasks)
    await db.save()
    return task

@app.delete("/tasks/{task_id}")
async def delete_task(task_id: str):
    tasks = await db.get("tasks") or []
    for i, t in enumerate(tasks):
        if t["id"] == task_id:
            tasks.pop(i)
            await db.set("tasks", tasks)
            await db.save()
    raise HTTPException(status_code=404, detail="Task not found")


@app.put("/tasks/{task_id}")
async def update_task(task_id: str, task: Task):
    global tasks
    for i, t in enumerate(tasks):
        if t["id"] == task_id:
            tasks[i] = task.model_dump()
            return task
    raise HTTPException(status_code=404, detail="Task not found")


@app.patch("/tasks/{task_id}/complete")
@app.put("/tasks/{task_id}/complete")  # Accept both PATCH and PUT
async def complete_task(task_id: str):
    global tasks
    for i, t in enumerate(tasks):
        if t["id"] == task_id:
            tasks[i] = {**t, "completed": True}
            return tasks[i]
    raise HTTPException(status_code=404, detail="Task not found")

@app.patch("/tasks/{task_id}/incomplete")
@app.put("/tasks/{task_id}/incomplete")  # Accept both PATCH and PUT
async def incomplete_task(task_id: str):
    global tasks
    for i, t in enumerate(tasks):
        if t["id"] == task_id:
            tasks[i] = {**t, "completed": False}
            return tasks[i]
    raise HTTPException(status_code=404, detail="Task not found")

