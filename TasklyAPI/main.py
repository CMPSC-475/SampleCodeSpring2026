from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from pickledb import PickleDB
from contextlib import asynccontextmanager

tasks = []
app = FastAPI()


class Task(BaseModel):
    id: str
    title: str
    description: str
    completed: bool


@app.get("/tasks")
def get_tasks():
    global tasks
    return tasks

@app.post("/tasks")
async def create_task(task: Task):
    global tasks
    tasks.append(task.model_dump())
    return task

@app.delete("/tasks/{task_id}")
async def delete_task(task_id: str):
    global tasks
    for i, t in enumerate(tasks):
        if t["id"] == task_id:
            tasks.pop(i)
            return {"msg": "Task deleted successfully"}
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

