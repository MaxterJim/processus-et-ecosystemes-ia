# =============================================================================
#  05-setup-venv-py310.ps1
#  Script d'installation automatique pour DÉBUTANTS sur Windows
#  >>> VERSION POUR PYTHON 3.10 <<<
#  -----------------------------------------------------------------------------
#  Ce script :
#    1. Vérifie que Python 3.10 est installé
#    2. Crée (si absent) un environnement virtuel "myfastapienv-py310"
#    3. Active l'environnement virtuel
#    4. Met à jour pip
#    5. Installe uniquement les paquets MANQUANTS
#    6. Génère un fichier requirements.txt
#
#  UTILISATION (depuis la racine du projet dans PowerShell) :
#     .\scripts\05-setup-venv-py310.ps1
#
#  Pour que l'environnement virtuel reste activé APRÈS le script :
#     . .\scripts\05-setup-venv-py310.ps1
#
#  Si Windows bloque le script, exécutez UNE SEULE FOIS dans PowerShell :
#     Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
# =============================================================================

$PythonVersion = "3.10"
$VenvName      = "myfastapienv-py310"

function Write-Step($message) {
    Write-Host ""
    Write-Host "========================================================" -ForegroundColor Cyan
    Write-Host " $message" -ForegroundColor Cyan
    Write-Host "========================================================" -ForegroundColor Cyan
}

function Write-OK($message)    { Write-Host "[OK]   $message" -ForegroundColor Green }
function Write-Info($message)  { Write-Host "[INFO] $message" -ForegroundColor Yellow }
function Write-Err($message)   { Write-Host "[ERREUR] $message" -ForegroundColor Red }

Clear-Host
Write-Host ""
Write-Host "  ╔══════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "  ║  Installation automatique — Projet FastAPI / Streamlit   ║" -ForegroundColor Magenta
Write-Host "  ║  Version Python : $PythonVersion                                   ║" -ForegroundColor Magenta
Write-Host "  ║  Environnement  : $VenvName                         ║" -ForegroundColor Magenta
Write-Host "  ╚══════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host ""

Write-Step "Étape 1/6 — Vérification de Python $PythonVersion"

try {
    $pythonCheck = & py -$PythonVersion --version 2>&1
    if ($LASTEXITCODE -ne 0) { throw "py -$PythonVersion introuvable" }
    Write-OK "Python détecté : $pythonCheck"
}
catch {
    Write-Err "Python $PythonVersion n'est pas installé ou introuvable !"
    Write-Host ""
    Write-Info "Pour l'installer :"
    Write-Host "  1. Allez sur https://www.python.org/downloads/release/python-3100/"
    Write-Host "  2. Téléchargez 'Windows installer (64-bit)'"
    Write-Host "  3. IMPORTANT : cochez 'Add python.exe to PATH' pendant l'installation"
    Write-Host "  4. Relancez ce script"
    Write-Host ""
    exit 1
}

Write-Step "Étape 2/6 — Création de l'environnement virtuel"

$activateScript = Join-Path $VenvName "Scripts\Activate.ps1"

if ((Test-Path $VenvName) -and (Test-Path $activateScript)) {
    Write-OK "Le venv '$VenvName' existe déjà. Réutilisation (aucune recréation)."
} else {
    if (Test-Path $VenvName) {
        Write-Info "Dossier '$VenvName' trouvé mais incomplet. Suppression..."
        Remove-Item -Recurse -Force $VenvName
    }
    Write-Info "Création du venv avec 'py -$PythonVersion -m venv $VenvName'..."
    & py -$PythonVersion -m venv $VenvName
    if ($LASTEXITCODE -ne 0) {
        Write-Err "Échec de la création du venv."
        exit 1
    }
    Write-OK "Environnement virtuel '$VenvName' créé."
}

Write-Step "Étape 3/6 — Activation de l'environnement virtuel"

if (-not (Test-Path $activateScript)) {
    Write-Err "Fichier d'activation introuvable : $activateScript"
    exit 1
}

Write-Info "Activation via : $activateScript"
& $activateScript
Write-OK "Environnement activé. Votre invite PowerShell devrait maintenant commencer par ($VenvName)."

Write-Step "Étape 4/6 — Mise à jour de pip, setuptools et wheel"

python -m pip install --upgrade pip setuptools wheel
if ($LASTEXITCODE -ne 0) {
    Write-Err "Échec de la mise à jour de pip."
    exit 1
}
Write-OK "pip est à jour."

Write-Step "Étape 5/6 — Installation des bibliothèques"

$packages = @(
    "fastapi",
    "uvicorn[standard]",
    "python-multipart",
    "pydantic",
    "pydantic-settings",
    "streamlit",
    "requests",
    "httpx",
    "pandas",
    "numpy",
    "matplotlib",
    "seaborn",
    "scikit-learn",
    "plotly",
    "openpyxl",
    "python-dotenv",
    "jupyter",
    "ipykernel"
)

Write-Info "Nombre de paquets à vérifier : $($packages.Count)"
Write-Host ""

$installedRaw = pip list --format=freeze 2>$null
$installedNames = @{}
foreach ($line in $installedRaw) {
    if ($line -match "^([A-Za-z0-9_\-\.]+)==") {
        $installedNames[$matches[1].ToLower()] = $true
    }
}

$index     = 0
$installed = 0
$skipped   = 0

foreach ($pkg in $packages) {
    $index++
    $pkgBase = ($pkg -replace "\[.*\]", "") -replace "==.*", ""
    $pkgKey  = $pkgBase.ToLower()

    if ($installedNames.ContainsKey($pkgKey)) {
        Write-Host ("  ({0}/{1}) [DÉJÀ INSTALLÉ] {2}" -f $index, $packages.Count, $pkg) -ForegroundColor DarkGray
        $skipped++
    } else {
        Write-Host ("  ({0}/{1}) pip install {2}" -f $index, $packages.Count, $pkg) -ForegroundColor White
        pip install --quiet $pkg
        if ($LASTEXITCODE -ne 0) {
            Write-Err "Échec de l'installation de $pkg"
            exit 1
        }
        $installed++
    }
}

Write-Host ""
Write-OK "Vérification terminée : $installed installé(s), $skipped déjà présent(s)."

Write-Step "Étape 6/6 — Génération du fichier requirements.txt"

pip freeze | Out-File -Encoding utf8 "requirements-py310.txt"
Write-OK "Fichier 'requirements-py310.txt' généré à la racine du projet."

Write-Host ""
Write-Host "  ╔════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "  ║              INSTALLATION TERMINÉE !               ║" -ForegroundColor Green
Write-Host "  ╚════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "  Vérifications rapides (copiez-collez) :" -ForegroundColor Cyan
Write-Host "    python --version"
Write-Host "    python -c `"import fastapi; print('FastAPI', fastapi.__version__)`""
Write-Host "    python -c `"import streamlit; print('Streamlit', streamlit.__version__)`""
Write-Host "    python -c `"import uvicorn; print('Uvicorn', uvicorn.__version__)`""
Write-Host ""
Write-Host "  Pour RÉACTIVER ce venv dans une nouvelle fenêtre PowerShell :" -ForegroundColor Cyan
Write-Host "    .\$VenvName\Scripts\Activate.ps1"
Write-Host ""
Write-Host "  Pour DÉSACTIVER :" -ForegroundColor Cyan
Write-Host "    deactivate"
Write-Host ""

if ($MyInvocation.InvocationName -ne ".") {
    Write-Host "  ATTENTION : l'environnement virtuel n'est actif QUE dans ce" -ForegroundColor Yellow
    Write-Host "  script. Dans votre terminal actuel, relancez :" -ForegroundColor Yellow
    Write-Host "    .\$VenvName\Scripts\Activate.ps1" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  Ou, pour éviter cela, lancez le script en dot-sourcing :" -ForegroundColor Yellow
    Write-Host "    . .\scripts\05-setup-venv-py310.ps1" -ForegroundColor Yellow
    Write-Host ""
}
