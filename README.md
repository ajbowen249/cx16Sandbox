# CX16 Sandbox

This is a loosely-organized project for the [Commander X16](https://github.com/commanderx16/x16-emulator) computer, that I'm using to learn how it ticks.

## Requirements

- Have the CX16 Emulator in your PATH
- Have 64tass in your PATH
- Python 3 as your default Python
- Have [pypng](https://pypi.org/project/pypng/) installed
- have [numpy](https://numpy.org/) installed

If you are so inclined, you may also use a python3 virtualenvironment. `.venv` is in the `.gitignore` and the required python libraries are in `requirements.txt`.

## Building

If you have the above requirements satisfied, you should be able to build and run in one go with:

```bash
scripts/br.bat
```

It should work on Windows or *-nix thanks to the #! and cross-environment syntax. You may need to `chmod +x scripts/br.bat` first on *-nix. Once the emulator comes up, just type `RUN` and hit return to start the program.
