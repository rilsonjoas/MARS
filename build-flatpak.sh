#!/bin/bash

# Script for building and testing MARS Flatpak

set -e

echo "=== Build and Test of MARS Flatpak ==="

# Check if flatpak-builder is installed
if ! command -v flatpak-builder &> /dev/null; then
    echo "❌ flatpak-builder is not installed!"
    echo "   Install with: sudo apt install flatpak-builder (Ubuntu/Debian)"
    echo "             or: sudo dnf install flatpak-builder (Fedora)"
    exit 1
fi

# Check if necessary runtimes are installed
echo "🔍 Checking necessary runtimes..."
if ! flatpak list --runtime | grep -q "org.freedesktop.Platform.*23.08"; then
    echo "📦 Installing runtime org.freedesktop.Platform/23.08..."
    flatpak install -y flathub org.freedesktop.Platform//23.08
fi

if ! flatpak list --runtime | grep -q "org.freedesktop.Sdk.*23.08"; then
    echo "📦 Installing SDK org.freedesktop.Sdk/23.08..."
    flatpak install -y flathub org.freedesktop.Sdk//23.08
fi

if ! flatpak list --runtime | grep -q "org.freedesktop.Sdk.Extension.openjdk17"; then
    echo "📦 Installing OpenJDK 17 extension..."
    flatpak install -y flathub org.freedesktop.Sdk.Extension.openjdk17//23.08
fi

# Create build directory
BUILD_DIR="build-mars-flatpak"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

echo "🔨 Building the Flatpak..."
flatpak-builder --force-clean "$BUILD_DIR" io.github.rilsonjoas.MARS.yml

echo "🧪 Testing the Flatpak..."
flatpak-builder --run "$BUILD_DIR" io.github.rilsonjoas.MARS.yml mars --help || true

echo "📦 Creating bundle for distribution..."
flatpak build-export export "$BUILD_DIR"
flatpak build-bundle export mars.flatpak io.github.rilsonjoas.MARS

echo ""
echo "✅ Build completed successfully!"
echo "   📁 Bundle created: mars.flatpak"
echo ""
echo "To test locally:"
echo "   flatpak install --user mars.flatpak"
echo "   flatpak run io.github.rilsonjoas.MARS"
echo ""
echo "To uninstall:"
echo "   flatpak uninstall io.github.rilsonjoas.MARS"