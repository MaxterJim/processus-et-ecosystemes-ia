# Scripts d'installation — Windows (débutants)

Ce dossier contient tout ce qu'il faut pour **installer automatiquement** votre environnement de travail sous Windows, sans rien taper à la main.

Il y a **un script par version de Python** — choisissez celui qui correspond à votre installation. Chaque script crée un **environnement virtuel séparé**, ce qui vous permet d'avoir plusieurs versions de Python côte à côte sans conflit.

---

## ⚡ Démarrage ultra-rapide (5 étapes)

> Si vous n'avez **jamais** utilisé PowerShell, suivez exactement ces 5 étapes. Lisez ensuite les sections détaillées plus bas.

### Étape 1 — Ouvrir PowerShell

**Méthode la plus simple (à retenir) :**

1. Appuyez sur la touche **Windows** (⊞) de votre clavier
2. Tapez : `powershell`
3. Cliquez sur **Windows PowerShell** dans les résultats

Une fenêtre bleue (ou noire) s'ouvre avec une ligne qui ressemble à :

```
PS C:\Users\VotreNom>
```

Le `>` à la fin est le **prompt** : c'est là que vous allez taper vos commandes.

**Autres méthodes possibles :**

| Méthode | Étapes |
|---------|--------|
| Via le menu Démarrer | Clic droit sur le logo Windows ⊞ → **Terminal** ou **Windows PowerShell** |
| Via Explorateur de fichiers | Ouvrez le dossier du projet → clic droit dans un espace vide → **Ouvrir dans le Terminal** |
| Raccourci clavier | `Windows + X`, puis lettre **I** (ou **A**) |

---

### Étape 2 — Taper et exécuter une commande

C'est TRÈS simple, seulement 2 gestes :

1. **Tapez** la commande au clavier (ou copiez-collez)
2. **Appuyez sur la touche `Entrée`** (⏎) pour l'exécuter

> **Astuce copier-coller dans PowerShell** : pour coller une commande, faites **clic droit** dans la fenêtre (le texte se colle automatiquement), puis appuyez sur `Entrée`. Le raccourci `Ctrl+V` fonctionne aussi sur Windows 10/11.

Exemple, tapez :

```powershell
echo Bonjour
```

puis appuyez sur `Entrée`. Vous verrez apparaître :

```
Bonjour
```

---

### Étape 3 — Se placer dans le dossier du projet

Avant de lancer un script, vous devez « entrer » dans le dossier du projet. La commande pour cela s'appelle `cd` (« **c**hange **d**irectory »).

**Méthode la plus rapide** (pas besoin de taper le chemin à la main) :

1. Ouvrez l'**Explorateur de fichiers** et allez dans le dossier du projet
2. Faites **clic droit** dans un espace vide du dossier
3. Cliquez sur **Ouvrir dans le Terminal** (ou **Ouvrir la fenêtre PowerShell ici** sur Windows 10)
4. PowerShell s'ouvre déjà **dans le bon dossier** — vous n'avez rien à taper !

**Méthode manuelle** (si vous ouvrez PowerShell normalement) :

La commande `cd` sert à se déplacer dans un dossier. Remplacez le chemin ci-dessous par **celui de votre propre dossier de projet** :

```powershell
cd "chemin\vers\votre\dossier\de\projet"
```

Exemples concrets selon l'endroit où se trouve votre projet :

```powershell
cd C:\Projets\MonProjet
cd "C:\Mes Documents\Cours\FastAPI"
cd D:\Travaux\projet-ia
```

> **Astuce sans se tromper** : dans l'Explorateur Windows, ouvrez votre dossier de projet, cliquez dans la **barre d'adresse** en haut, copiez le chemin affiché (`Ctrl + C`), puis dans PowerShell tapez `cd ` (suivi d'un espace) et collez avec **clic droit**.
>
> **Attention** : utilisez des **guillemets** `"..."` autour du chemin s'il contient des **espaces** ou des **parenthèses**.

Pour vérifier que vous êtes au bon endroit, tapez :

```powershell
ls
```

Vous devez voir les fichiers `.md` du cours et le dossier `scripts`.

---

### Étape 4 — Autoriser PowerShell à exécuter des scripts (UNE SEULE FOIS)

Windows bloque par défaut les scripts `.ps1`. Pour débloquer, tapez :

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

Appuyez sur `Entrée`. Si on vous demande confirmation, tapez **O** puis `Entrée`.

> Vous n'aurez à faire cette étape **qu'une seule fois** sur votre ordinateur, pas à chaque ouverture de PowerShell.

---

### Étape 5 — Lancer le script d'installation

Tapez (ou copiez-collez) :

```powershell
.\scripts\01-setup-venv-py312.ps1
```

Puis appuyez sur `Entrée`. Le script affiche en couleurs tout ce qu'il fait. Attendez le message :

```
╔════════════════════════════════════════════════════╗
║              INSTALLATION TERMINÉE !               ║
╚════════════════════════════════════════════════════╝
```

**C'est tout !** Vous pouvez maintenant utiliser FastAPI, Streamlit, etc.

---

### 🆘 Aide rapide pendant l'utilisation de PowerShell

| Ce que je veux faire | Comment |
|----------------------|---------|
| Arrêter une commande qui tourne | `Ctrl + C` |
| Effacer la fenêtre | Taper `cls` puis `Entrée` |
| Retrouver une commande précédente | Flèche **Haut** ↑ du clavier |
| Voir la commande suivante dans l'historique | Flèche **Bas** ↓ |
| Compléter un nom de fichier | Commencer à taper puis appuyer sur `Tab` |
| Fermer PowerShell | Taper `exit` puis `Entrée` (ou fermer la fenêtre) |
| Aide sur une commande | `Get-Help nom-de-la-commande` |

---

## Quel script choisir ?

| Script | Python | Dossier venv créé | Requirements généré | Recommandé pour |
|--------|--------|-------------------|---------------------|------------------|
| `01-setup-venv-py312.ps1`   | **3.12** | `myfastapienv`           | `requirements.txt`        | ⭐ **Défaut recommandé** — très stable, supporté partout |
| `02-setup-venv-py314.ps1`   | 3.14     | `myfastapienv-py314`     | `requirements-py314.txt`  | Toute dernière version — certains paquets peuvent manquer |
| `03-setup-venv-py313.ps1`   | 3.13     | `myfastapienv-py313`     | `requirements-py313.txt`  | Version récente, bonne compatibilité |
| `04-setup-venv-py311.ps1`   | 3.11     | `myfastapienv-py311`     | `requirements-py311.txt`  | Très stable, compatible TensorFlow |
| `05-setup-venv-py310.ps1`   | 3.10     | `myfastapienv-py310`     | `requirements-py310.txt`  | Projets existants en 3.10 |
| `06-setup-venv-py39.ps1`    | 3.9      | `myfastapienv-py39`      | `requirements-py39.txt`   | Ancienne version — compatibilité limitée |

> **Si vous ne savez pas quoi choisir**, utilisez `01-setup-venv-py312.ps1` (Python 3.12).
>
> **Note** : le venv du script n°1 s'appelle simplement `myfastapienv` (sans suffixe) car c'est le venv **par défaut** du projet. Les autres ont un suffixe `-pyXYZ` pour indiquer leur version.

---

## Prérequis (à faire UNE SEULE FOIS)

### 1. Installer Python

Allez sur [python.org/downloads/](https://www.python.org/downloads/) et téléchargez la version qui correspond au script que vous voulez utiliser.

Pendant l'installation :

- Cochez **Windows installer (64-bit)**
- **TRÈS IMPORTANT** : cochez la case **« Add python.exe to PATH »** en bas de la première fenêtre
- Cliquez sur **Install Now**

Pour vérifier qu'une version est disponible, ouvrez PowerShell et tapez (exemple pour 3.12) :

```powershell
py -3.12 --version
```

Vous devriez voir par exemple : `Python 3.12.7`.

Pour voir **toutes** les versions Python installées :

```powershell
py --list
```

### 2. Autoriser l'exécution des scripts PowerShell

Par défaut, Windows **bloque** les scripts `.ps1`. Ouvrez PowerShell (utilisateur normal, pas administrateur) et tapez **une seule fois** :

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

Répondez **O** (Oui) si demandé.

---

## Utilisation

### Méthode 1 — Lancement simple

Depuis la racine du projet, dans PowerShell :

```powershell
.\scripts\01-setup-venv-py312.ps1      # Python 3.12 (défaut)
.\scripts\02-setup-venv-py314.ps1      # Python 3.14
.\scripts\03-setup-venv-py313.ps1      # Python 3.13
.\scripts\04-setup-venv-py311.ps1      # Python 3.11
.\scripts\05-setup-venv-py310.ps1      # Python 3.10
.\scripts\06-setup-venv-py39.ps1       # Python 3.9
```

Chaque script :

1. Vérifie que la version Python correspondante est installée
2. Crée le venv **seulement s'il n'existe pas** (sinon le réutilise, sans rien vous demander)
3. Active l'environnement
4. Met à jour `pip`
5. Installe **uniquement les paquets manquants** (ne réinstalle pas ceux déjà présents)
6. Génère le `requirements-pyXYZ.txt` correspondant

### Méthode 2 — Lancement avec activation persistante

Si vous voulez que le venv reste **actif dans votre terminal** après l'exécution, utilisez le **dot-sourcing** (point + espace au début) :

```powershell
. .\scripts\01-setup-venv-py312.ps1
```

---

## Peut-on avoir plusieurs venv en même temps ?

**Oui, totalement.** Chaque script crée son propre dossier venv. Vous pouvez par exemple :

```powershell
.\scripts\01-setup-venv-py312.ps1     # crée myfastapienv (3.12)
.\scripts\04-setup-venv-py311.ps1     # crée myfastapienv-py311 (3.11)
```

Puis basculer d'un environnement à l'autre :

```powershell
.\myfastapienv\Scripts\Activate.ps1           # activer le 3.12
deactivate                                    # désactiver
.\myfastapienv-py311\Scripts\Activate.ps1     # activer le 3.11
```

---

## Après l'installation

### Pour réactiver un venv dans une nouvelle fenêtre PowerShell

```powershell
.\myfastapienv\Scripts\Activate.ps1            # si vous avez lancé 01 (py312)
.\myfastapienv-py314\Scripts\Activate.ps1      # si vous avez lancé 02
.\myfastapienv-py313\Scripts\Activate.ps1      # si vous avez lancé 03
.\myfastapienv-py311\Scripts\Activate.ps1      # si vous avez lancé 04
.\myfastapienv-py310\Scripts\Activate.ps1      # si vous avez lancé 05
.\myfastapienv-py39\Scripts\Activate.ps1       # si vous avez lancé 06
```

Votre invite devient alors :

```
(myfastapienv) C:\Users\VotreNom\MonProjet>
```

### Pour désactiver

```powershell
deactivate
```

### Pour lancer un backend FastAPI

```powershell
uvicorn backend:app --reload
```

Ouvrez ensuite : [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)

### Pour lancer un frontend Streamlit

```powershell
streamlit run frontend.py
```

Ouvrez ensuite : [http://localhost:8501](http://localhost:8501)

---

## En cas de problème

| Message d'erreur | Solution |
|------------------|----------|
| `py -3.XX introuvable` | La version Python demandée n'est pas installée. Téléchargez-la sur python.org. |
| `cannot be loaded because running scripts is disabled` | Exécutez `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned`. |
| `Activate.ps1 introuvable` | Le venv est incomplet. Supprimez le dossier `myfastapienv*` et relancez le script. |
| `pip install a échoué` | Vérifiez votre connexion Internet, ou essayez une version Python plus stable (3.11 ou 3.12). |
| L'invite ne montre pas `(myfastapienv...)` | Activez le venv manuellement avec `.\myfastapienv\Scripts\Activate.ps1`. |
| Un paquet refuse de s'installer en 3.14 ou 3.9 | Ces versions ont un support limité ; utilisez 3.11 ou 3.12. |

---

## Contenu du dossier `scripts\`

| Fichier | Rôle |
|---------|------|
| `01-setup-venv-py312.ps1`    | Installation pour Python 3.12 (par défaut) |
| `02-setup-venv-py314.ps1`    | Installation pour Python 3.14 |
| `03-setup-venv-py313.ps1`    | Installation pour Python 3.13 |
| `04-setup-venv-py311.ps1`    | Installation pour Python 3.11 |
| `05-setup-venv-py310.ps1`    | Installation pour Python 3.10 |
| `06-setup-venv-py39.ps1`     | Installation pour Python 3.9 |
| `requirements.txt`           | Liste générique des dépendances (utilisable manuellement) |
| `README.md`                  | Ce fichier |

---

## Tableau récapitulatif — quelle commande pour quoi ?

| Je veux... | Commande |
|------------|----------|
| Installer tout en 3.12 (défaut) | `.\scripts\01-setup-venv-py312.ps1` |
| Installer tout en 3.11 (stable + TensorFlow) | `.\scripts\04-setup-venv-py311.ps1` |
| Voir toutes mes versions Python installées | `py --list` |
| Activer un venv existant | `.\myfastapienv\Scripts\Activate.ps1` |
| Désactiver le venv courant | `deactivate` |
| Lancer FastAPI | `uvicorn backend:app --reload` |
| Lancer Streamlit | `streamlit run frontend.py` |
| Sortir d'un terminal bloqué | `Ctrl + C` puis `deactivate` |
