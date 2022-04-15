import json

from neuro_sdk import get


async def create_config() -> None:
    async with get() as client:
        config = {
            "1": {
                "name": f"{client.config.cluster_name} registry",
                "url": str(client.config.registry_url),
                "user": client.config.username,
                "password": await client.config.token(),
            }
        }
        with open("db.json", "w") as db_file:
            json.dump(config, db_file)
