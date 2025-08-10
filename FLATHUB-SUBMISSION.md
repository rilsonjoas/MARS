# 📋 Flathub Submission Guide

## 🎯 Flathub Preparation

This guide details the necessary steps to submit MARS to Flathub.

### 📋 Prerequisites

✅ **Project Ready**
- [x] Functional Flatpak built and tested
- [x] Icons in multiple resolutions
- [x] Valid AppStream metadata
- [x] Complete documentation
- [x] Code committed to GitHub

### 🔄 Submission Process

#### 1. Verify Required Files

The following files are essential for Flathub:

```
io.github.rilsonjoas.MARS.yml        # Main manifest
mars-wrapper.sh                      # Execution script  
io.github.rilsonjoas.MARS.desktop    # Desktop file
io.github.rilsonjoas.MARS.metainfo.xml # AppStream metadata
```

#### 2. Validate Metadata

```bash
# Validate desktop file
desktop-file-validate io.github.rilsonjoas.MARS.desktop

# Validate AppStream metadata
appstream-util validate-relax io.github.rilsonjoas.MARS.metainfo.xml
```

#### 3. Submit to Flathub

**Option A: Direct Submission**
1. Fork the Flathub repository: https://github.com/flathub/flathub
2. Create new branch for MARS
3. Add `io.github.rilsonjoas.MARS` to `applications.txt` file
4. Create Pull Request

**Option B: Dedicated Repository (Recommended)**
1. Create new repository: `flathub/io.github.rilsonjoas.MARS`
2. Add all manifest files
3. Configure Flathub integration

### 🚀 Submission Commands

#### Create Flathub Repository

```bash
# 1. Create repository on GitHub
# Name: io.github.rilsonjoas.MARS
# Description: Flatpak packaging for MARS MIPS Assembler and Runtime Simulator

# 2. Clone Flathub template
git clone https://github.com/flathub/org.example.Example.git flathub-mars
cd flathub-mars

# 3. Copy MARS files
cp ../MARS/io.github.rilsonjoas.MARS.yml .
cp ../MARS/mars-wrapper.sh .
cp ../MARS/io.github.rilsonjoas.MARS.desktop .
cp ../MARS/io.github.rilsonjoas.MARS.metainfo.xml .

# 4. Initial commit
git add .
git commit -m "Initial Flatpak packaging for MARS MIPS Simulator"

# 5. Configure remote to your repository
git remote set-url origin https://github.com/flathub/io.github.rilsonjoas.MARS.git
git push -u origin main
```

#### Final Validation

```bash
# Test build in clean environment
flatpak-builder --force-clean build-dir io.github.rilsonjoas.MARS.yml

# Verify installation
flatpak build-export export build-dir
flatpak build-bundle export mars-test.flatpak io.github.rilsonjoas.MARS

# Installation test
flatpak install --user mars-test.flatpak
flatpak run io.github.rilsonjoas.MARS
```

### 📋 Submission Checklist

#### Manifest Files
- [x] `io.github.rilsonjoas.MARS.yml` - Valid main manifest
- [x] `mars-wrapper.sh` - Executable script 
- [x] `io.github.rilsonjoas.MARS.desktop` - Valid desktop file
- [x] `io.github.rilsonjoas.MARS.metainfo.xml` - AppStream metadata

#### Technical Validations
- [x] Build executes without errors
- [x] Application starts correctly
- [x] Icons appear on desktop
- [x] Basic functionalities operational
- [x] No broken external dependencies

#### Documentation
- [x] Updated README.md
- [x] Installation instructions
- [x] Description of improvements
- [x] License information

#### Code Quality
- [x] No unnecessary files
- [x] Configured .gitignore
- [x] Descriptive commits
- [x] Organized structure

### 🎯 Next Steps

1. **Create Flathub repository**: 
   - Access https://github.com/flathub
   - Create `io.github.rilsonjoas.MARS`

2. **Submit application**:
   - Follow official guide: https://github.com/flathub/flathub/wiki/App-Submission

3. **Await review**:
   - Flathub team will review
   - May request changes

4. **Publication**:
   - After approval, will be available globally
   - Users can install via: `flatpak install flathub io.github.rilsonjoas.MARS`

### 🔗 Useful Links

- **Flathub**: https://flathub.org/
- **Submission Guide**: https://github.com/flathub/flathub/wiki/App-Submission
- **Flatpak Documentation**: https://docs.flatpak.org/
- **AppStream Validator**: https://www.freedesktop.org/software/appstream/docs/

---

## ✅ Current Status

**The MARS project is 100% ready for Flathub submission!** 🚀

All necessary files have been created, tested and validated. The application is working perfectly as a Flatpak with professional icons in multiple resolutions.
