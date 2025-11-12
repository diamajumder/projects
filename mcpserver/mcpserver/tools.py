from mcp.server.fastmcp import FastMCP
from mcp.server.fastmcp.utilities.types import Image
from pydantic import BaseModel, Field
from typing import List

import pyautogui
import io
import requests
#npx @modelcontextprotocol/inspector@latest - to run mcp inspector with node

mcp = FastMCP("Tools")

class Person(BaseModel):
    first_name: str = Field(..., description="first name")
    last_name: str = Field(..., description="last name")
    exp: int = Field(..., description="years of experience")
    prev_addresses: List[str] = Field(..., description="previous addresses")

@mcp.tool()
def add_note_to_file(content: str) -> str:
    """
    Appends content to local file
    Args:
        content: content to be added to local file
    """

    filename = "notes.txt"

    try:
        with open(filename, "a", encoding="utf-8") as f:
            f.write(content + "\n")
            return f"content appended to {filename}."
    except Exception as e:
        return f"error appending to {filename} - {e}"

@mcp.tool()
def read_file() -> str:
    """
    Reads content from local file
    """

    filename = "notes.txt"

    try:
        with open(filename, "r", encoding="utf-8") as f:
            content = f.read()
            return content if content else "no content found"
    except FileNotFoundError:
        return "File not found"
    except Exception as e:
        return f"error reading from {filename} - {e}"

##orchestrate does not work with images
@mcp.tool()
def capture_screenshot() -> Image:
    """
    Capture the current screen and return the image. Use this tool whenever the user requests a screenshot of their activity.
    """

    buffer = io.BytesIO()

    screenshot = pyautogui.screenshot()
    screenshot.convert("RGB").save(buffer, format="JPEG", quality=60, optimize=True)
    return Image(data=buffer.getvalue(), format="jpeg")

#API call
@mcp.tool()
def get_cryptocurrency_price(crypto: str) -> str:
    """
    Gets the price of cyptocurrency 
    Args:
        crypto: type of cryptocurrency
    """
    try:
        # Use CoinGecko API to fetch current price in USD
        url = f"https://api.coingecko.com/api/v3/simple/price"
        params = {"ids": crypto.lower(), "vs_currencies": "usd"}
        response = requests.get(url, params=params, timeout=10)
        response.raise_for_status()
        data = response.json()
        price = data.get(crypto.lower(), {}).get("usd")
        if price is not None:
            return f"The price of {crypto} is ${price} USD."
        else:
            return f"Price for {crypto} not found."
    except Exception as e:
        return f"Error fetching price for {crypto}: {e}"

@mcp.tool()
def add_person(person: Person) -> str:
    """
    Adds person details to member database
    Args:
        Person: object of person class
            - first_name: person's first name
            - last_name: person's last name
            - exp: experience in years
            - prev_addresses: List of previous addresses of the person
    Returns:
        str
    """
    with open("log.txt", "a", encoding="utf-8") as f:
        f.write(f"first name: {person.first_name}\n")
        f.write(f"last name: {person.last_name}\n")
        f.write(f"experience: {person.exp}\n")
        f.write("previous addresses\n")
        for idx, address in enumerate(prev_addresses,1):
            f.write(f"{idx}. {address}\n")
        f.write("\n")
    return "data added successfully"

if __name__ == "__main__":
    mcp.run()

