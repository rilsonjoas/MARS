# MARS - MIPS Assembler and Runtime Simulator (Flatpak Edition)

<div align="center">

![MARS Logo](images/mars64.png)

**An interactive educational tool for MIPS assembly programming, now available as a Flatpak.**

[![Java](https://img.shields.io/badge/Java-17-orange.svg)](https://openjdk.java.net/projects/jdk/17/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20Windows%20%7C%20macOS-lightgrey.svg)](https://github.com/rilsonjoas/io.github.rilsonjoas.MARS/)
[![Flatpak](https://img.shields.io/badge/Flatpak-Ready-green.svg)](https://flathub.org/)

</div>

## 📖 About MARS

**MARS** (MIPS Assembler and Runtime Simulator) is an integrated development environment (IDE) for MIPS assembly language programming. Designed specifically for educational purposes, MARS offers an intuitive graphical interface that allows students to learn the fundamental concepts of computer architecture and low-level programming.

This is the original MARS project, developed by **Pete Sanderson** (Otterbein University) and **Ken Vollmar** (Missouri State University). It is a very stable legacy application widely used by universities worldwide.

### 🎯 Key Features

- **🖥️ User-Friendly Graphical Interface**: Editor with syntax highlighting and line numbering.
- **🔧 Integrated Assembler**: Complete MIPS assembler with pseudoinstruction support.
- **🏃 Execution Simulator**: Execute MIPS programs step-by-step or in continuous mode.
- **📊 Data Visualization**: Monitor registers, memory, and stack in real-time.
- **🐛 Advanced Debugging**: Set breakpoints and examine program state.
- **📚 Integrated Documentation**: Contextual help and MIPS instruction reference.
- **🛠️ Additional Tools**: Cache simulator, bitmap display, keyboard simulator.

## 🏗️ Supported MIPS Architecture

MARS simulates an educational version of the MIPS32 processor with:

- **32 general-purpose registers** ($0-$31)
- **Coprocessor 0** for exception handling
- **4GB virtual memory** (segmented)
- **Complete set of basic MIPS32 instructions**
- **Syscalls** for input/output and system operations

### 📋 Supported Instructions

#### Arithmetic and Logical
```mips
add, addi, sub, mult, div, and, andi, or, ori, xor, xori, nor, slt, slti
```

#### Data Transfer
```mips
lw, sw, lb, sb, lh, sh, lui, mfhi, mflo, mthi, mtlo
```

#### Flow Control
```mips
beq, bne, blt, ble, bgt, bge, j, jal, jr, jalr
```

#### Pseudoinstructions
```mips
move, li, la, nop, push, pop, blt, bgt, ble, bge
```

## 📦 Flatpak Packaging

This repository provides a Flatpak package for the MARS MIPS Assembler and Runtime Simulator. This allows for easy and secure installation on various Linux distributions, providing a sandboxed environment for the application.

### ✅ Implemented Improvements & Status

The Flatpak packaging process involved several key improvements and fixes to ensure a robust and user-friendly experience:

#### Technical Corrections
- **JAR Manifest Issues**: Corrected `mainclass.txt` to properly point to the `mars.Mars` class, ensuring the JAR executes correctly.
- **Syscall Configuration**: Simplified syscall configuration to resolve naming conflicts and ensure zero syscall errors during execution.

#### Visual Enhancements
- **Improved Icon System**: Located a high-quality `Mars 140.jpg` image and implemented automatic generation of professional-looking icons in multiple resolutions (16x16, 32x32, 48x48, 64x64, 128x128, 256x256).

#### Flatpak Structure & Build
- **Self-Contained Environment**: The Flatpak bundles its own OpenJDK 17 (Adoptium) to ensure consistent execution across different systems.
- **Optimized Package Size**: The final Flatpak size is 161MB.
- **Build Process**: The build process involves downloading dependencies, compiling Java files, creating the JAR, and installing all necessary resources.

### 🚀 Current Status

| Aspect | Status | Details |
|---|---|---|
| **Initial Setup** | ✅ Completed | Manifest (`io.github.rilsonjoas.MARS.yml`), wrapper script (`mars-wrapper.sh`), and `.desktop`/`.metainfo.xml` files created. |
| **Java Compilation** | ✅ Completed | All 217 `.java` files compiled successfully. |
| **JAR Creation** | ✅ Completed | `Mars.jar` generated with correct `Main-Class` (`mars.Mars`). |
| **Flatpak Packaging** | ✅ Completed | The Flatpak is built successfully, including all necessary resources. |
| **Local Execution** | ✅ Completed | The Flatpak can be installed and executed locally via `flatpak run io.github.rilsonjoas.MARS`. |
| **Icons** | ✅ Completed | Icons in multiple resolutions generated and included. |
| **AppStream Metadata** | ✅ Completed | `.metainfo.xml` configured for application store integration. |
| **Functionality Tests** | ✅ Completed | Basic execution and GUI tests performed successfully. |
| **Package Size** | ✅ Optimized | Final Flatpak size: 161MB. |
| **Ready for Flathub** | ✅ Completed | The project is ready for submission to Flathub. |

## 🛠️ Installation

### Via Flatpak (Recommended)

To install the MARS Flatpak, first ensure you have Flatpak set up on your system. Then, you can install it from the local file:

```bash
# Install from local file
flatpak install --user mars-icon-update.flatpak

# Run the application
flatpak run io.github.rilsonjoas.MARS
```

### Manual Compilation (Original Project)

If you wish to compile the original MARS project manually (without Flatpak), follow these steps:

```bash
# Clone the repository
git clone https://github.com/rilsonjoas/io.github.rilsonjoas.MARS.git
cd MARS

# Compile
javac -encoding ISO-8859-1 -cp . $(find . -name "*.java")

# Create JAR
jar cfm Mars.jar mainclass.txt $(find . -name "*.class") images/ help/ docs/ *.xml *.txt *.properties

# Execute
java -jar Mars.jar
```

## 📚 How to Use

### 1. Creating Your First Program

```mips
.text
.globl main

main:
    # Print "Hello World!"
    li $v0, 4           # syscall for print_string
    la $a0, hello       # load string address
    syscall
    
    # Terminate program
    li $v0, 10          # syscall for exit
    syscall

.data
hello: .asciiz "Hello World!\n"
```

### 2. Assembling and Executing

1.  **Type or load** your assembly code.
2.  **Assemble** (F3) to compile.
3.  **Execute** (F5) to run the program.
4.  **Step** (F7) for step-by-step execution.
5.  **Reset** (F12) to restart.

### 3. Debugging

-   **Breakpoints**: Click on line numbers.
-   **Registers**: Monitor values in real-time.
-   **Memory**: Visualize memory content.
-   **Stack**: Track push/pop operations.

## 🔧 Integrated Tools

### 🖼️ Bitmap Display
Simulates a simple graphical display for pixel-by-pixel graphics creation.

### ⌨️ Keyboard and Display MMIO Simulator
Simulates keyboard input and terminal output via memory-mapped I/O.

### 💾 Cache Simulator
Visualizes the behavior of different cache configurations.

### 📊 Data Path Simulator
Visualizes the data path through the MIPS processor.

## 🎓 Educational Use

MARS is widely used in courses on:

-   **Computer Architecture**
-   **Computer Organization and Architecture**
-   **Digital Systems**
-   **Assembly Programming**
-   **Operating Systems** (basic concepts)

### 📖 Educational Resources

-   **Ready-made examples**: Example programs included.
-   **Syscall documentation**: Complete reference of system calls.
-   **Integrated help**: Contextual help and tutorials.
-   **Step-by-step mode**: Ideal for understanding execution flow.

## 🚀 Next Steps (Flatpak Specific)

### Publishing to Flathub
1.  **GitHub Repository**: Create a specific repository for the Flatpak.
2.  **Submission**: Open a Pull Request to the Flathub repository.
3.  **Review**: Await review by the Flathub team.
4.  **Publication**: Global availability.

### Useful Flatpak Commands

```bash
# Check build status
flatpak-builder --force-clean build-dir io.github.rilsonjoas.MARS.yml

# Quick compilation test
./test-build.sh

# Manual build
flatpak-builder --force-clean build-dir io.github.rilsonjoas.MARS.yml

# Test without installing
flatpak-builder --run build-dir io.github.rilsonjoas.MARS.yml mars

# Create bundle
flatpak build-export export build-dir
flatpak build-bundle export mars.flatpak io.github.rilsonjoas.MARS
```

## 🛠️ Development

### Project Structure

```
MARS/
├── mars/                   # Main source code
│   ├── venus/             # Graphical interface
│   ├── mips/              # MIPS simulator
│   └── tools/             # Additional tools
├── images/                # Visual resources
├── help/                  # HTML documentation
├── docs/                  # JavaDoc documentation
└── Flatpak/              # Packaging files (this repository)
```

### Technologies Used

-   **Java 17**: Main programming language
-   **Swing**: Graphical interface
-   **Flatpak**: Distribution system
-   **ImageMagick**: Icon processing

## 🤝 Contributing

Contributions are welcome! Please:

1.  Fork the project.
2.  Create a feature branch (`git checkout -b feature/AmazingFeature`).
3.  Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4.  Push to the branch (`git push origin feature/AmazingFeature`).
5.  Open a Pull Request.

### 🐛 Reporting Bugs

-   Use the issue template.
-   Include system information.
-   Describe steps to reproduce.
-   Attach logs if necessary.

## 📄 License

This project maintains the original MARS license. See [MARSlicense.txt](MARSlicense.txt) for details.

## 🔗 Related Links

-   **Original Website**: [https://dpetersanderson.github.io/](https://dpetersanderson.github.io/)
-   **Full Documentation**: Included in the `help/` directory.
-   **Patterson & Hennessy**: Computer Organization and Design.

## 📞 Contact

-   **GitHub**: [@rilsonjoas](https://github.com/rilsonjoas)
-   **Issues**: [GitHub Issues](https://github.com/rilsonjoas/io.github.rilsonjoas.MARS/issues)

---

<div align="center">

**🚀 Explore the world of MIPS architecture with MARS! 🚀**

[![Download](https://img.shields.io/badge/Download-Flatpak-blue.svg)](https://github.com/rilsonjoas/io.github.rilsonjoas.MARS/releases)
[![Documentation](https://img.shields.io/badge/Docs-Available-green.svg)](help/)
[![Website](https://img.shields.io/badge/Website-Original-orange.svg)](https://dpetersanderson.github.io/)

</div>
