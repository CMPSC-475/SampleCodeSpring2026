from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

tasks = []

app = FastAPI()

# TODO:-
class Task(BaseModel):
    id: str
    title: str
    description: str
    completed: bool



@app.get("/tasks")
def get_tasks():
    return {"tasks": tasks}

@app.post("/tasks")
def create_task(task: Task):
    global tasks
    tasks.append(task)
    return {"msg": "Task created successfully"}


@app.delete("/tasks/{task_id}")
def delete_task(task_id: str):
    global tasks
    for i, t in enumerate(tasks):
        if t.id == task_id:
            tasks.pop(i)
            return {"msg": "Task deleted successfully"}