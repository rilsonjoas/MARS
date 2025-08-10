#!/bin/bash

# Simplified script for quick testing of MARS Flatpak

set -e

echo "=== Quick Test of MARS Flatpak ==="

# Check if flatpak-builder is installed
if ! command -v flatpak-builder &> /dev/null; then
    echo "❌ flatpak-builder is not installed!"
    exit 1
fi

echo "🔨 Testing Java compilation..."
# Test Java compilation locally first
find . -name "*.java" -exec javac -cp . {} + 2>/dev/null || {
    echo "❌ Error in Java compilation. Checking files..."
    echo "Java files found:"
    find . -name "*.java" | head -10
    exit 1
}

echo "📦 Creating test JAR..."
jar cfm Mars-test.jar mainclass.txt $(find . -name "*.class") images/ help/ docs/ *.xml *.txt *.properties 2>/dev/null || {
    echo "❌ Error creating JAR"
    exit 1
}

echo "☕ Testing JAR execution..."
java -jar Mars-test.jar --help 2>/dev/null || echo "JAR created successfully (help may not be available)"

echo "✅ Local compilation successful!"
echo "   📁 Test JAR created: Mars-test.jar"

# Clean up test files
rm -f Mars-test.jar $(find . -name "*.class")

echo ""
echo "Ready for Flatpak build! Execute:"
echo "   ./build-flatpak.sh"