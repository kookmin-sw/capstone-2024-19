import pytest
import json
import motor.motor_asyncio
import asyncio
import os
import websockets
from httpx import AsyncClient
from main import app

MAGICIAN_MONGO_USERNAME = os.getenv("MAGICIAN_MONGO_USERNAME")
MAGICIAN_MONGO_PASSWORD = os.getenv("MAGICIAN_MONGO_PASSWORD")
MAGICIAN_MONGO_PORT = os.getenv("MAGICIAN_MONGO_PORT")
MAGICIAN_MONGO_HOST = os.getenv("MAGICIAN_MONGO_HOST")
db_name = "chat_db"
MONGO_URI = f"mongodb://{MAGICIAN_MONGO_USERNAME}:{MAGICIAN_MONGO_PASSWORD}@{MAGICIAN_MONGO_HOST}:{MAGICIAN_MONGO_PORT}/{db_name}?authSource=admin"



@pytest.fixture(scope="session")
def chat_collection():
    M_Client = motor.motor_asyncio.AsyncIOMotorClient(MONGO_URI)
    db = M_Client["chat_db"]
    collection = db["chats"]
    yield collection
    M_Client.close()

# 1. GPT 로 전송, 답이 잘 오는지
@pytest.mark.asyncio(scope="session")
@pytest.mark.dependency()
async def test_gpt(chat_collection):
    async with websockets.connect("ws://0.0.0.0:8000/ws/Test1") as websocket:
        # userid -> 1 로 테스트 진행.
        await websocket.send("test/-1")
        await websocket.send("테스트중이야, 안녕이라고 딱 두글자만 문장부호 없이 대답해줘")
        msg = await websocket.recv()
        await websocket.close()

    await asyncio.sleep(2)
    await chat_collection.delete_many({"user_id": "Test1"})
    assert msg == "안녕"

# 2. 처음 시작하는 방이 없을떄 (-1)
@pytest.mark.asyncio(scope="session")
@pytest.mark.dependency(depends=["test_gpt"])
# 대화종료후 메시지를 잘 저장하는지
async def test_end_of_message(chat_collection):
    async with websockets.connect("ws://0.0.0.0:8000/ws/Test2") as websocket:
        await websocket.send("test/-1")
        await websocket.send("all_저장테스트")
        await websocket.recv()
        await websocket.close()
    # 웹소켓이 닫히고 5초 대기
    await asyncio.sleep(3)

    result = await chat_collection.find_one({"user_id": "Test2"})
    await chat_collection.delete_many({"user_id": "Test2"})
    assert result["conversation"][-1]["user_message"] == "all_저장테스트"


# 새롭게 방을 연결할때
# 대화가 끝난후 이어서 대화를 진행하려할때, 이전 대화내역을 모두 받아오는지.
@pytest.mark.asyncio(scope="session")
@pytest.mark.dependency(depends=["test_end_of_message"])
async def test_reload_message(chat_collection):
    async with websockets.connect("ws://0.0.0.0:8000/ws/Test3") as websocket:
        await websocket.send("test/-1")
        await websocket.send("reload_테스트")
        await websocket.recv()
        await websocket.send("reload_테스트2")
        await websocket.recv()
        await websocket.close()

    await asyncio.sleep(3)
    raw_room_id = await chat_collection.find_one({"user_id": "Test3"})
    room_id = raw_room_id["room_id"]

    async with websockets.connect("ws://0.0.0.0:8000/ws/Test3") as websocket:
        await websocket.send(f"test/{room_id}")
        msg = json.loads(await websocket.recv())
        msg2 = await websocket.recv()

    await chat_collection.delete_many({"user_id": "Test3"})
    assert msg[-1]["user_message"] == "reload_테스트2" and msg2 == "이전 대화를 이어서 진행합니다."

@pytest.mark.asyncio(scope="session")
@pytest.mark.dependency(depends=["test_reload_message"])
async def test_delete_chat(chat_collection):
    async with websockets.connect("ws://0.0.0.0:8000/ws/Test4") as websocket:
        await websocket.send("test/-1")
        await websocket.send("delete_테스트")
        await websocket.recv()
        await websocket.close()

    await asyncio.sleep(3)
    raw_room_id = await chat_collection.find_one({"user_id": "Test4"})
    room_id = raw_room_id["room_id"]

    test_client = AsyncClient(app=app, base_url="http://0.0.0.0:8000")
    test_response = await test_client.delete(f"/chat/{room_id}")
    assert test_response.status_code == 200

    result = await chat_collection.find_one({"room_id": room_id})
    assert result is None