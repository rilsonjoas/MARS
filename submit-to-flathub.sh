#!/bin/bash

# Script para submeter MARS ao Flathub
# Baseado no processo oficial: https://github.com/flathub/flathub

echo "🚀 Script de Submissão do MARS ao Flathub"
echo "=========================================="
echo ""

# Verificar se o usuário fez o fork
echo "📋 PASSO 1: Verificações iniciais"
echo ""

read -p "Você já fez o fork do repositório https://github.com/flathub/flathub? (y/n): " fork_done

if [ "$fork_done" != "y" ]; then
    echo ""
    echo "❌ Por favor, faça o fork primeiro:"
    echo "1. Acesse: https://github.com/flathub/flathub"
    echo "2. Clique em 'Fork'"
    echo "3. Marque 'Copy the master branch only'"
    echo "4. Execute este script novamente"
    exit 1
fi

# Obter nome de usuário GitHub
echo ""
read -p "Digite seu nome de usuário GitHub: " github_user

if [ -z "$github_user" ]; then
    echo "❌ Nome de usuário é obrigatório!"
    exit 1
fi

echo ""
echo "📂 PASSO 2: Clonando seu fork do Flathub"
echo ""

# Ir para diretório temporário
cd /tmp

# Remover clone anterior se existir
if [ -d "flathub" ]; then
    rm -rf flathub
fi

# Clonar o fork
echo "Clonando https://github.com/$github_user/flathub.git..."
if ! git clone --branch=new-pr "https://github.com/$github_user/flathub.git"; then
    echo "❌ Erro ao clonar. Verifique se o fork foi feito corretamente."
    exit 1
fi

cd flathub

echo ""
echo "🌿 PASSO 3: Criando branch para submissão"
echo ""

# Criar nova branch
git checkout -b mars-submission new-pr

echo ""
echo "📝 PASSO 4: Adicionando MARS ao applications.txt"
echo ""

# Adicionar MARS ao applications.txt
echo "io.github.rilsonjoas.MARS" >> applications.txt

# Verificar se foi adicionado
if grep -q "io.github.rilsonjoas.MARS" applications.txt; then
    echo "✅ MARS adicionado com sucesso ao applications.txt"
else
    echo "❌ Erro ao adicionar MARS"
    exit 1
fi

echo ""
echo "💾 PASSO 5: Fazendo commit"
echo ""

# Commit
git add applications.txt
git commit -m "Add org.example.MyAwesomeApp

Request to add MARS MIPS Assembler and Runtime Simulator to Flathub.

Repository: https://github.com/rilsonjoas/MARS
Application ID: io.github.rilsonjoas.MARS

MARS is a MIPS processor simulator that provides a complete educational
environment for learning assembly language programming."

echo ""
echo "🚀 PASSO 6: Enviando para GitHub"
echo ""

# Push
if git push origin mars-submission; then
    echo ""
    echo "✅ SUCESSO! Branch enviada para GitHub"
    echo ""
    echo "📋 PRÓXIMOS PASSOS:"
    echo "1. Acesse: https://github.com/$github_user/flathub"
    echo "2. Você verá uma notificação para criar Pull Request"
    echo "3. Clique em 'Compare & pull request'"
    echo "4. Título do PR: 'Add org.example.MyAwesomeApp'"
    echo "5. Não abra o PR contra a branch 'master' (como mostrado no aviso)"
    echo "6. Abra contra a branch 'new-pr'"
    echo ""
    echo "🎉 Seu MARS será revisado pela equipe do Flathub!"
else
    echo "❌ Erro ao fazer push. Verifique suas credenciais GitHub."
    exit 1
fi

# Limpeza
cd ..
rm -rf flathub

echo ""
echo "🧹 Limpeza concluída. Script finalizado!"
