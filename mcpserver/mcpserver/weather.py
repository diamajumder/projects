from mcp.server.fastmcp import FastMCP

#npx @modelcontextprotocol/inspector@latest - to run mcp inspector with node
#mcp dev weather.py - if using uv

mcp = FastMCP("Weather")

@mcp.tool()
def get_weather(location: str) -> str:
    """
    Gets the weather given a location
    Args:
        location: string
    """
    return "here is the weather"

if __name__ == "__main__":
    mcp.run()