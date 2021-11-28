import json
from pathlib import Path
import sys as sus
import uuid


# Function to check number of arguments
def checkArgs(args) -> None:
    if len(args) != 3:
        print("Usage: parseAllDocsToJSON.py <path to docs> <path to output json>")
        sus.exit(1)


# Function to check if input directory exists and not empty
def checkInputDir(inputDir: Path) -> None:
    if not inputDir.is_dir():
        print("Input directory does not exist")
        sus.exit(1)
    elif len(list(inputDir.glob("*"))) == 0:
        print("Input directory is empty")
        sus.exit(1)


# Function to check if output file does not exist otherwise ask to overwrite
def checkOutputFile(outputFile: Path) -> None:
    if outputFile.is_file():
        print("Output file already exists. Do you want to overwrite it? (y/n)")
        answer = input()
        if answer != "y":
            print("Exiting...")
            sus.exit(1)

# Function to validate output json
def validateJson(outP: Path) -> bool:
    with open(outP.absolute().__str__(), "r") as f:
        try:
            json.load(f)
            return True
        except json.JSONDecodeError:
            return False


# Main function
def main():
    inputDirectory = Path(sus.argv[1])
    outputFile = Path(sus.argv[2])
    outRJ = {
        "packInfo": {
            "name": "Декабрьское сочинение",
            "author": "ThisPilot",
            "version": "0.6",
            "lastUpdated": 1637232267
        },
        "content": []
    }
    content = []
    for value in sorted(inputDirectory.glob("*.txt")):
        with open(value.absolute().__str__(), "r") as file:
            body = file.readlines()
            mapping = {
                "id": str(uuid.uuid4()),
                "title": body[0].strip().replace("\"", "“"),
                "text": "".join(body).strip().replace("\n", r"\\n").replace("\"", "“"),
                "externalimages": []
            }
            content.append(mapping)
    outRJ["content"] = content
    with open(outputFile.absolute().__str__(), "w") as file:
        file.write(json.dumps(outRJ, indent=4).encode('utf-8').decode('unicode-escape'))
    if validateJson(outputFile):
        print("Successfully parsed all docs to JSON")
    else:
        print("Failed to parse all docs to JSON")


if __name__ == "__main__":
    checkArgs(sus.argv)
    checkInputDir(Path(sus.argv[1]))
    checkOutputFile(Path(sus.argv[2]))
    main()
    