# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

MARS (MIPS Assembler and Runtime Simulator) is a Java-based educational tool for MIPS assembly programming. This is a Flatpak-packaged version of the original MARS project by Pete Sanderson and Kenneth Vollmar, maintained as a stable educational application.

## Build Commands

### Flatpak Build (Primary)
```bash
# Full build and test
./build-flatpak.sh

# Manual build steps
flatpak-builder --force-clean build-mars-flatpak io.github.rilsonjoas.MARS.yml
flatpak build-export export build-mars-flatpak
flatpak build-bundle export mars.flatpak io.github.rilsonjoas.MARS

# Test locally
flatpak install --user mars.flatpak
flatpak run io.github.rilsonjoas.MARS
```

### Manual Java Build (Alternative)
```bash
# Compile all Java sources
javac -encoding ISO-8859-1 -cp . $(find . -name "*.java" -not -path "./.flatpak-builder/*")

# Create JAR using mainclass.txt manifest
jar cfm Mars.jar mainclass.txt $(find . -name "*.class") images/ help/ docs/ *.xml *.txt *.properties

# Run application
java -jar Mars.jar
```

### Quick Test Commands
```bash
# Test build without installation
./test-build.sh

# Test final flatpak
./test-final.sh

# Run flatpak in build environment
flatpak-builder --run build-mars-flatpak io.github.rilsonjoas.MARS.yml mars
```

## Architecture

### Core Packages Structure
```
mars/
├── MarsLaunch.java        # Application entry point
├── Globals.java           # Global configuration and data structures
├── assembler/             # MIPS assembly parsing and translation
├── mips/                  # MIPS processor simulation
│   ├── hardware/          # CPU registers, memory, coprocessors
│   ├── instructions/      # Instruction set implementation
│   └── dump/              # Memory dump formats
├── simulator/             # Execution engine and control
├── venus/                 # GUI components (Swing-based)
├── tools/                 # Educational tools (cache sim, bitmap display)
└── util/                  # Utility classes
```

### Key Components

- **MarsLaunch**: Main application launcher, handles command-line arguments
- **Globals**: Central registry for instruction sets, memory, registers, settings
- **Assembler**: Two-pass assembler with macro support and symbol table
- **MIPS Hardware**: Register file, memory management, coprocessors
- **Venus UI**: Complete IDE with editor, debugger, and execution controls
- **Tools**: Pluggable educational tools for visualization and simulation

### Entry Points
- GUI Mode: `Mars.java` → `mars.MarsLaunch` → `mars.venus.VenusUI`
- Command Line: `mars.MarsLaunch` with arguments for batch processing

## Configuration Files

- `mainclass.txt`: JAR manifest specifying `mars.Mars` as main class
- `Config.properties`: Application settings and preferences
- `Syscall.properties`: System call number mappings
- `Settings.properties`: Default UI and simulator settings
- `io.github.rilsonjoas.MARS.yml`: Flatpak build manifest

## Key Development Notes

### Java Version
- **Target**: Java 17 (bundled with Flatpak via Adoptium OpenJDK)
- **Encoding**: Source files use ISO-8859-1 encoding (legacy requirement)
- **GUI**: Swing-based interface with custom syntax highlighting

### Flatpak Specifics
- Runtime: `org.freedesktop.Platform//23.08`
- Permissions: Documents access, X11/Wayland, IPC sharing
- Bundle includes complete JRE for consistency across distributions

### Testing and Quality Assurance
- Functional tests available via test scripts
- 217 Java source files compile without warnings
- Zero syscall errors in current configuration
- GUI components tested on X11 and Wayland

## Common Development Tasks

### Adding New Instructions
1. Create instruction class in `mars/mips/instructions/`
2. Add to appropriate instruction set in `Globals.java`
3. Update help documentation if needed

### Modifying GUI Components  
- Main UI elements in `mars/venus/` package
- Editor components in `mars/venus/editors/` subpackages
- Window management through `*Window.java` classes

### Adding Educational Tools
1. Extend `AbstractMarsToolAndApplication` in `mars/tools/`
2. Register tool in `ToolLoader.java`
3. Add help documentation in `help/` directory

### Flatpak Updates
- Modify `io.github.rilsonjoas.MARS.yml` for build changes
- Update metadata in `io.github.rilsonjoas.MARS.metainfo.xml`
- Icons located in `icons/hicolor/` structure

### Flathub Submission Requirements
- All URLs in metainfo.xml must be accessible (no redirects)
- Screenshots must be valid images (PNG/JPG) accessible via HTTPS
- Git source must use branch instead of specific commit for updates
- Validation script available: `./validate-manifest.sh`