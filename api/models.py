from pydantic import BaseModel
from typing import Optional


class TestCreateRequest(BaseModel):
    station: str
    type: str
    object_name: str
    variable: str
    value: str
    value_for_setup: Optional[str] = None
    test_interval: Optional[str] = None
    wait_seconds: Optional[str] = None
