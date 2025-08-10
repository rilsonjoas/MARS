# MARS Flatpak

This directory contains the necessary files to package MARS as a Flatpak and distribute it on Flathub.

## Flatpak Files

- `io.github.rilsonjoas.MARS.yml` - Main Flatpak manifest
- `mars-wrapper.sh` - Wrapper script to execute MARS
- `io.github.rilsonjoas.MARS.desktop` - Desktop file for system integration
- `io.github.rilsonjoas.MARS.metainfo.xml` - Application metadata for software stores
- `build-flatpak.sh` - Automated script for build and test

## Prerequisites

Before building the Flatpak, make sure you have installed:

```bash
# Ubuntu/Debian
sudo apt install flatpak flatpak-builder

# Fedora
sudo dnf install flatpak flatpak-builder

# Arch Linux
sudo pacman -S flatpak flatpak-builder
```

Add the Flathub repository:
```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

## Build and Local Test

Execute the automated script:
```bash
./build-flatpak.sh
```

Or manually:

### 1. Install necessary runtimes
```bash
flatpak install flathub org.freedesktop.Platform//23.08
flatpak install flathub org.freedesktop.Sdk//23.08
flatpak install flathub org.freedesktop.Sdk.Extension.openjdk17//23.08
```

### 2. Build the Flatpak
```bash
flatpak-builder --force-clean build-dir io.github.rilsonjoas.MARS.yml
```

### 3. Test locally
```bash
flatpak-builder --run build-dir io.github.rilsonjoas.MARS.yml mars
```

### 4. Create bundle for distribution
```bash
flatpak build-export export build-dir
flatpak build-bundle export mars.flatpak io.github.rilsonjoas.MARS
```

### 5. Install and test the bundle
```bash
flatpak install --user mars.flatpak
flatpak run io.github.rilsonjoas.MARS
```

## Submission to Flathub

To submit MARS to Flathub:

### 1. Fork the Flathub repository
Fork the [flathub/flathub](https://github.com/flathub/flathub) repository.

### 2. Create new repository
Create a new GitHub repository named `io.github.rilsonjoas.MARS`.

### 3. Add files
Copy the following files to the new repository:
- `io.github.rilsonjoas.MARS.yml`
- `mars-wrapper.sh`
- `io.github.rilsonjoas.MARS.desktop`
- `io.github.rilsonjoas.MARS.metainfo.xml`

### 4. Open Pull Request
Open a Pull Request in the flathub/flathub repository by adding a line to the `applications.txt` file:
```
io.github.rilsonjoas.MARS
```

### 5. Await review
The Flathub team will review and approve the submission.

## App ID Structure

The App ID `io.github.rilsonjoas.MARS` follows the convention:
- `io.github` - Reverse domain for GitHub
- `rilsonjoas` - GitHub username
- `MARS` - Application name

## Permissions

The Flatpak requests the following permissions:
- `--share=ipc` - Inter-process communication
- `--socket=x11` and `--socket=wayland` - Access to graphical display
- `--filesystem=home` - Access to user files
- `--filesystem=xdg-documents` - Access to documents folder
- `--device=dri` - Access to graphical hardware

## Troubleshooting

### Java compilation error
If there are compilation errors, check if all `.java` files are present and if the directory structure is correct.

### Runtime error
Check if OpenJDK 17 is being used correctly and if JAVA_HOME is configured in the wrapper script.

### Permission issues
Adjust permissions in the manifest as needed for the application to function.

## Additional Resources

- [Official Flatpak documentation](https://docs.flatpak.org/)
- [Flathub submission guide](https://github.com/flathub/flathub/wiki/App-Submission)
- [Flatpak Manifest Reference](https://docs.flatpak.org/en/latest/flatpak-builder.html)