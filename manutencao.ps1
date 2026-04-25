# Ferramentas de Manutenção PerfectPro
Write-Host "--- PAINEL DE CONTROLE PERFECTPRO ---" -ForegroundColor Cyan
function Menu {
    Write-Host "1. Publicar Atualizações (Build + Push)"
    Write-Host "2. Limpar Cache do Flutter (Se o app travar)"
    Write-Host "3. Testar Conexão com a API"
    Write-Host "4. Verificar Status do Git"
    Write-Host "Q. Sair"
}
do {
    Menu
    $input = Read-Host "Escolha uma opção"
switch ($input) {
        "1" {
            Write-Host "🚀 Iniciando Build Web..." -ForegroundColor Yellow
            flutter build web --release
            git add .
            $msg = Read-Host "Mensagem do Commit"
            git commit -m $msg
            git push origin main --force
            Write-Host "✅ Enviado! Aguarde o deploy no Render." -ForegroundColor Green
        }
        "2" {
            Write-Host "🧹 Limpando Cache..." -ForegroundColor Yellow
            flutter clean
            flutter pub get
            Write-Host "✅ Projeto limpo e dependências atualizadas." -ForegroundColor Green
        }
        "3" {
            Write-Host "🔍 Testando API..." -ForegroundColor Yellow
            Start-Process "https://onrender.com"
        }
        "4" {
            git status
        }
    }
} while ($input -ne "q")
Use o código com cuidado.