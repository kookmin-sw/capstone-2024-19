from fastapi import FastAPI, WebSocket
from fastapi.middleware.cors import CORSMiddleware
import asyncio
import uvicorn
import motor.motor_asyncio
import uuid
import gpt
import datetime
import os

app = FastAPI()

# CORS
# TODO: CORS 수정하기
origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Asyncio 이벤트 루프 생성
loop = asyncio.get_event_loop()

# MongoDB와의 연결 설정
MAGICIAN_MONGO_USERNAME = os.getenv("MAGICIAN_MONGO_USERNAME")
MAGICIAN_MONGO_PASSWORD = os.getenv("MAGICIAN_MONGO_PASSWORD")
MAGICIAN_MONGO_PORT = os.getenv("MAGICIAN_MONGO_PORT")
MAGICIAN_MONGO_HOST = os.getenv("MAGICIAN_MONGO_HOST")
db_name = "chat_db"
MONGO_URI = f"mongodb://{MAGICIAN_MONGO_USERNAME}:{MAGICIAN_MONGO_PASSWORD}@{MAGICIAN_MONGO_HOST}:{MAGICIAN_MONGO_PORT}/{db_name}?authSource=admin"
client = motor.motor_asyncio.AsyncIOMotorClient(MONGO_URI)
db = client["chat_db"]  # MongoDB 데이터베이스 선택
collection = db["chats"]  # 채팅 내용을 저장할 컬렉션 선택


# INPUT -> USERID
@app.websocket("/ws/{user_id}")
async def websocket_endpoint(websocket: WebSocket, user_id: str):
    await websocket.accept()
    init = await websocket.receive_text()
    added_prompt, room_id = init.split("/")
    conversation = []
    is_continued = False

    try:
        # 사전정의된 프롬프트 받기, 이전 채팅방 이어하는지 여부 받기, 만약 새로 시작이라면 -1 보내기
        if room_id != "-1":
            is_continued = True

            # 이전 채팅 로딩
            chat = await collection.find_one({"room_id": room_id})

            # 이전 대화내용
            conversation = chat["conversation"]
            added_prompt = chat["added_prompt"]
            await websocket.send_json(chat["conversation"])

            # 이전 대화를 GPT에 입력, 문맥을 따라가도록
            await gpt.gpt_reload(chat["conversation"])
            await websocket.send_text("이전 대화를 이어서 진행합니다.")

        else:
            # 새로운 대화 시작
            is_continued = False
            room_id = str(uuid.uuid4())

        # 대화 시작
        while True:
            data = await websocket.receive_text()
            # 응답 생성 with added_prompt
            msg = await gpt.gpt_talk(data, added_prompt)
            await websocket.send_text(msg)
            conversation.append({"user_message": data, "bot_response": msg})

    except Exception as e:
        print(e)

    finally:
        await save_chat(user_id, room_id, added_prompt, conversation, is_continued)  # 대화 기록을 MongoDB에 저장


# 채팅 내용 저장 함수
async def save_chat(user_id, room_id, added_prompt, conversation, is_continued):
    if is_continued:
        await collection.update_one({"room_id": room_id}, {"$set": {"conversation": conversation}})
    else:
        chat_data = {"start_time": datetime.datetime.now(), "user_id": user_id, "room_id": room_id,
                     "added_prompt": added_prompt, "conversation": conversation}
        await collection.insert_one(chat_data)


# READ
# TODO: CQRS 패턴으로 변경
# 어떤 사용자가 진행했던 채팅들 리스트 반환
@app.get("/chat/list/{user_id}")
async def chat_list(user_id: str):
    chats = []
    async for chat in collection.find({"user_id": user_id}):
        chat["_id"] = str(chat["_id"])
        chats.append(chat)
    return {"chats": chats}


# READ
# TODO: CQRS 패턴으로 변경
# 어떤 채팅의 디테일 내용을 반환
@app.get("/chat/{room_id}")
async def chat_detail(room_id: str):
    chat = await collection.find_one({"room_id": room_id})
    chat["_id"] = str(chat["_id"])
    return {"chat": chat}

# DELETE
# 채팅방의 채팅 내용 삭제
@app.delete("/chat/{room_id}")
async def delete_chat(room_id: str):
    await collection.delete_one({"room_id": room_id})
    return {"message": "Chat deleted successfully"}


# FastAPI 서버 실행
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
