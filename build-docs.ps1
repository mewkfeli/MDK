# build-docs.ps1
Write-Host "Building combined documentation..." -ForegroundColor Green

# Создаем папку для сборки
New-Item -ItemType Directory -Force -Path build | Out-Null

# Очищаем предыдущую сборку
if (Test-Path "build\combined.md") {
    Remove-Item "build\combined.md"
}

# Начинаем создавать combined.md
"# Project Documentation" | Out-File -FilePath build\combined.md -Encoding UTF8
"Generated: $(Get-Date)" | Out-File -FilePath build\combined.md -Append -Encoding UTF8
"" | Out-File -FilePath build\combined.md -Append -Encoding UTF8

# Функция для добавления документации из ветки
function Add-DocsFromBranch {
    param($BranchName, $SectionTitle)
    
    try {
        # Пробуем получить README из ветки
        $content = git show "${BranchName}:README.md" 2>$null
        if ($content) {
            Write-Host "Found docs in branch: $BranchName" -ForegroundColor Green
            "## $SectionTitle" | Out-File -FilePath build\combined.md -Append -Encoding UTF8
            $content | Out-File -FilePath build\combined.md -Append -Encoding UTF8
            "" | Out-File -FilePath build\combined.md -Append -Encoding UTF8
            "" | Out-File -FilePath build\combined.md -Append -Encoding UTF8
        } else {
            Write-Host "No README.md found in branch: $BranchName" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Branch not found or error: $BranchName" -ForegroundColor Red
    }
}

# Добавляем документацию из всех веток
Add-DocsFromBranch -BranchName "testing" -SectionTitle "Testing Documentation"
Add-DocsFromBranch -BranchName "docker" -SectionTitle "Docker Documentation"

Write-Host "Documentation built: build\combined.md" -ForegroundColor Green
Write-Host "Location: $(Resolve-Path .\build\combined.md)" -ForegroundColor Cyan