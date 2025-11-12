from mcp.server.fastmcp import FastMCP
#npx @modelcontextprotocol/inspector@latest - to run mcp inspector with node
mcp = FastMCP("Prompts")

@mcp.prompt()
def get_prompt(topic: str) -> str:
    """
    Returns a prompt that will do a detailed search for a topic
    Args: 
        topic: str
    """
    return f"search the internet for the topic \"{topic}\""

@mcp.prompt()
def write_report(topic:str, number_paras: int) -> int:
    """
    Writes a detailed report
    Args: 
        topic: str
        num_paraa: int
    """
    prompt = """
    create a concise research report based on the topic {topic}.
    the report should contain 3 sections: introduction, main, conclusion
    the main section should be {num_paras} long
    include a timeline of major events
    write the conclusion in bullet points
    """
    return prompt


if __name__ == "__main__":
    mcp.run()