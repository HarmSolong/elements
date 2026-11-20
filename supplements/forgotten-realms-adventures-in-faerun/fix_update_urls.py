from pathlib import Path

OLD_URL = "https://raw.githubusercontent.com/AuroraLegacy/elements/master/"
NEW_URL = "https://raw.githubusercontent.com/HarmSolong/elements/personal-library/"

REPLACEMENTS = [
    ('<file name="fighter-arcane archer.xml"', '<file name="fighter-arcane-archer.xml"'),
    ('<file name="background-familiar friend.xml"', '<file name="background-familiar-friend.xml"'),
]

changed = 0
unchanged = 0

for path in sorted(Path(".").glob("*.xml")):
    text = path.read_text(encoding="utf-8")
    original = text

    text = text.replace(OLD_URL, NEW_URL)

    for old, new in REPLACEMENTS:
        text = text.replace(old, new)

    if text != original:
        path.write_text(text, encoding="utf-8", newline="\n")
        changed += 1
        print(f"Geändert: {path.name}")
    else:
        unchanged += 1
        print(f"Keine Änderung: {path.name}")

print(f"\nFertig: {changed} geändert, {unchanged} unverändert.")