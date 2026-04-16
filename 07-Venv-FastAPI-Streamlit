<a id="top"></a>

# Pratique — Environnement virtuel avec FastAPI et Streamlit

## Table des matières

| #  | Section                                                                                           |
| -- | ------------------------------------------------------------------------------------------------- |
| 1  | [Introduction — Architecture FastAPI + Streamlit](#section-1)                                    |
| 2  | [Étape 1 — Ouvrir l'invite de commandes](#section-2)                                             |
| 3  | [Étape 2 — Vérifier Python et pip](#section-3)                                                   |
| 3a | &nbsp;&nbsp;&nbsp;↳ [Vérifier Python](#section-3)                                                |
| 3b | &nbsp;&nbsp;&nbsp;↳ [Vérifier pip](#section-3)                                                   |
| 3c | &nbsp;&nbsp;&nbsp;↳ [Utiliser py -3.11 sur Windows (Python Launcher)](#section-3)               |
| 4  | [Étape 3 — Créer le dossier projet](#section-4)                                                  |
| 5  | [Étape 4 — Créer l'environnement virtuel](#section-5)                                            |
| 6  | [Étape 5 — Activer l'environnement virtuel](#section-6)                                          |
| 7  | [Étape 6 — Installer FastAPI et Streamlit](#section-7)                                           |
| 7a | &nbsp;&nbsp;&nbsp;↳ [Installer FastAPI + Uvicorn](#section-7)                                    |
| 7b | &nbsp;&nbsp;&nbsp;↳ [Installer Streamlit](#section-7)                                            |
| 7c | &nbsp;&nbsp;&nbsp;↳ [Vérifier les installations](#section-7)                                     |
| 8  | [Étape 7 — Créer les fichiers du projet](#section-8)                                             |
| 8a | &nbsp;&nbsp;&nbsp;↳ [backend.py — API FastAPI](#section-8)                                       |
| 8b | &nbsp;&nbsp;&nbsp;↳ [frontend.py — Interface Streamlit](#section-8)                              |
| 9  | [Étape 8 — Lancer FastAPI et Streamlit](#section-9)                                              |
| 10 | [Étape 9 — Tester dans le navigateur](#section-10)                                               |
| 11 | [Étape 10 — Exporter les dépendances](#section-11)                                               |
| 12 | [Étape 11 — Désactiver l'environnement](#section-12)                                             |
| 13 | [Récapitulatif des commandes](#section-13)                                                        |
| 14 | [Pratique guidée — de A à Z](#section-14)                                                        |
| 15 | [Conclusion](#section-15)                                                                         |

---

<a id="section-1"></a>

<details>
<summary><strong>1 — Introduction — Architecture FastAPI + Streamlit</strong></summary>

<br/>

**FastAPI** est un framework Python pour créer des APIs web rapides et documentées automatiquement.
**Streamlit** est une bibliothèque Python pour créer des interfaces web interactives sans HTML ni CSS.

Ensemble, ils forment une architecture **backend + frontend** 100 % Python :

```mermaid
flowchart LR
    USER["Utilisateur\n(navigateur)"]
    ST["Streamlit\nfrontend.py\nPort 8501"]
    API["FastAPI\nbackend.py\nPort 8000"]
    DB["Données\n(liste, base de données...)"]

    USER -->|"http://localhost:8501"| ST
    ST -->|"Requête HTTP GET/POST"| API
    API -->|"Réponse JSON"| ST
    ST -->|"Affichage"| USER
    API --> DB
```

**Pourquoi cette combinaison ?**

| Outil | Rôle | Port par défaut |
|-------|------|-----------------|
| **FastAPI** | Backend — logique métier, données, calculs | `8000` |
| **Streamlit** | Frontend — interface, formulaires, graphiques | `8501` |
| **Uvicorn** | Serveur ASGI pour lancer FastAPI | — |
| **Requests** | Bibliothèque HTTP pour que Streamlit appelle FastAPI | — |

> Les deux applications tournent **simultanément** dans deux terminaux séparés.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-2"></a>

<details>
<summary><strong>2 — Étape 1 — Ouvrir l'invite de commandes</strong></summary>

<br/>

### Windows

- Appuyez sur `Windows + R`, tapez `cmd`, puis appuyez sur **Entrée**.
- Ou tapez **"Invite de commandes"** dans la barre de recherche Windows.

### macOS / Linux

- Ouvrez le **Terminal** depuis les applications ou avec `Ctrl + Alt + T` (Linux).

```mermaid
flowchart LR
    W["Windows"] -->|"Windows + R → cmd"| CMD["Invite de commandes"]
    M["macOS"] -->|"Finder → Terminal"| CMD
    L["Linux"] -->|"Ctrl + Alt + T"| CMD
    CMD --> PY["Python disponible"]
```

> Pour ce projet, vous aurez besoin de **deux terminaux ouverts** : un pour FastAPI, un pour Streamlit.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-3"></a>

<details>
<summary><strong>3 — Étape 2 — Vérifier Python et pip</strong></summary>

<br/>

### Vérifier Python

```cmd
python --version
python3 --version
python3.11 --version
python3.12 --version
```

**Résultat attendu :**

```plaintext
Python 3.11.5
```

> Si aucune commande ne fonctionne, téléchargez Python depuis [python.org](https://www.python.org) et cochez **"Add Python to PATH"** lors de l'installation.

---

### Vérifier pip

```cmd
pip --version
python -m pip --version
```

**Résultat attendu :**

```plaintext
pip 24.0 from C:\...\pip (python 3.11)
```

---

### Le Python Launcher Windows — commande `py`

Windows installe automatiquement le **Python Launcher** (`py.exe`) lorsque vous installez Python depuis [python.org](https://www.python.org). Il permet de choisir précisément la version Python, même si plusieurs coexistent.

#### Voir les versions installées

```cmd
py --list
```

```plaintext
 -V:3.13 *        Python 3.13 (64-bit)
 -V:3.11          Python 3.11 (64-bit)
 -V:3.9           Python 3.9 (64-bit)
```

#### Utiliser une version précise

```cmd
py -3.11 --version
```

#### Créer le venv avec Python 3.11 exactement

```cmd
py -3.11 -m venv myfastapienv
```

```mermaid
flowchart TD
    A["Plusieurs versions Python installées\n3.9 — 3.11 — 3.13"] --> B{"Commande utilisée ?"}
    B -->|"python -m venv env"| C["Version par défaut\n(incertain)"]
    B -->|"py -3.11 -m venv env"| D["Python 3.11\nexactement"]
    D --> E["Environnement garanti\ncompatible avec votre code"]
```

> **Bonne pratique :** utilisez toujours `py -3.11 -m venv myfastapienv` sur Windows avec plusieurs versions installées.

| Commande | Rôle |
|----------|------|
| `py --list` | Lister toutes les versions installées |
| `py -3.11 --version` | Vérifier Python 3.11 |
| `py -3.11 -m venv env` | Créer un venv avec Python 3.11 |
| `py -3.12 -m venv env` | Créer un venv avec Python 3.12 |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-4"></a>

<details>
<summary><strong>4 — Étape 3 — Créer le dossier projet</strong></summary>

<br/>

```cmd
cd C:\Users\VotreNom\Documents
mkdir MonProjetFastAPIStreamlit
cd MonProjetFastAPIStreamlit
```

**Structure finale du projet :**

```mermaid
flowchart TD
    ROOT["MonProjetFastAPIStreamlit\\"]
    ROOT --> ENV["myfastapienv\\\n(environnement virtuel)"]
    ROOT --> BACK["backend.py\n(API FastAPI)"]
    ROOT --> FRONT["frontend.py\n(Interface Streamlit)"]
    ROOT --> REQ["requirements.txt\n(dépendances)"]
```

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-5"></a>

<details>
<summary><strong>5 — Étape 4 — Créer l'environnement virtuel</strong></summary>

<br/>

### Méthode recommandée sur Windows (Python Launcher)

```cmd
py -3.11 -m venv myfastapienv
```

### Méthode alternative

```cmd
python -m venv myfastapienv
python3.11 -m venv myfastapienv
python3.12 -m venv myfastapienv
```

**Résultat attendu :** un dossier `myfastapienv` est créé.

```cmd
dir
```

```plaintext
myfastapienv\
```

---

### Structure interne du venv

```mermaid
flowchart TD
    ENV["myfastapienv\\"]
    ENV --> SCR["Scripts\\\n— activate.bat\n— python.exe\n— pip.exe"]
    ENV --> LIB["Lib\\\n— site-packages\\\n  fastapi\n  streamlit\n  uvicorn\n  requests"]
    ENV --> CFG["pyvenv.cfg"]
```

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-6"></a>

<details>
<summary><strong>6 — Étape 5 — Activer l'environnement virtuel</strong></summary>

<br/>

### Windows

```cmd
myfastapienv\Scripts\activate
```

### macOS / Linux

```bash
source myfastapienv/bin/activate
```

**Résultat attendu :**

```plaintext
(myfastapienv) C:\Users\VotreNom\Documents\MonProjetFastAPIStreamlit>
```

```mermaid
flowchart LR
    BEFORE["C:\...\MonProjet>"]
    AFTER["(myfastapienv) C:\...\MonProjet>"]
    BEFORE -->|"myfastapienv\Scripts\activate"| AFTER
```

> Tant que `(myfastapienv)` est visible, toutes les installations `pip` seront isolées dans cet environnement.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-7"></a>

<details>
<summary><strong>7 — Étape 6 — Installer FastAPI et Streamlit</strong></summary>

<br/>

### Installer FastAPI + Uvicorn

**FastAPI** est le framework backend. **Uvicorn** est le serveur ASGI qui l'exécute.

```cmd
pip install fastapi
pip install "uvicorn[standard]"
```

> L'option `[standard]` installe les dépendances supplémentaires : rechargement automatique, support WebSocket, etc.

---

### Installer Streamlit

**Streamlit** crée l'interface web frontend.

```cmd
pip install streamlit
```

---

### Installer requests

**Requests** permet à Streamlit d'appeler l'API FastAPI via HTTP.

```cmd
pip install requests
```

---

### Installer tout en une seule commande

```cmd
pip install fastapi "uvicorn[standard]" streamlit requests
```

---

### Vérifier les installations

```cmd
pip list
```

**Résultat attendu (extraits) :**

```plaintext
Package     Version
----------  -------
fastapi     0.110.0
streamlit   1.32.0
uvicorn     0.29.0
requests    2.31.0
pydantic    2.6.4
...
```

Vérifier les versions individuellement :

```cmd
python -c "import fastapi; print('FastAPI', fastapi.__version__)"
python -c "import streamlit; print('Streamlit', streamlit.__version__)"
python -c "import uvicorn; print('Uvicorn', uvicorn.__version__)"
```

| Package | Rôle |
|---------|------|
| `fastapi` | Framework backend — routes, validation, documentation |
| `uvicorn[standard]` | Serveur ASGI pour lancer FastAPI |
| `streamlit` | Framework frontend — interface web interactive |
| `requests` | Client HTTP — Streamlit appelle FastAPI |
| `pydantic` | Validation de données (installé automatiquement avec FastAPI) |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-8"></a>

<details>
<summary><strong>8 — Étape 7 — Créer les fichiers du projet</strong></summary>

<br/>

### backend.py — API FastAPI

Créez un fichier `backend.py` dans votre dossier projet :

```python
from fastapi import FastAPI

app = FastAPI(title="Mon API FastAPI", version="1.0.0")

taches = []

@app.get("/")
def accueil():
    return {"message": "API FastAPI opérationnelle"}

@app.get("/taches")
def lire_taches():
    return {"taches": taches}

@app.post("/taches")
def ajouter_tache(tache: str):
    taches.append(tache)
    return {"message": f"Tâche ajoutée : {tache}", "total": len(taches)}

@app.delete("/taches/{index}")
def supprimer_tache(index: int):
    if index < 0 or index >= len(taches):
        return {"erreur": "Index invalide"}
    supprimee = taches.pop(index)
    return {"message": f"Tâche supprimée : {supprimee}"}
```

---

### frontend.py — Interface Streamlit

Créez un fichier `frontend.py` dans le même dossier :

```python
import streamlit as st
import requests

API_URL = "http://127.0.0.1:8000"

st.title("Gestionnaire de tâches")
st.subheader("Propulsé par FastAPI + Streamlit")

# Ajouter une tâche
st.header("Ajouter une tâche")
nouvelle_tache = st.text_input("Entrez une nouvelle tâche :")
if st.button("Ajouter"):
    if nouvelle_tache:
        response = requests.post(f"{API_URL}/taches", params={"tache": nouvelle_tache})
        if response.status_code == 200:
            st.success(response.json()["message"])
        else:
            st.error("Erreur lors de l'ajout.")
    else:
        st.warning("Veuillez entrer une tâche.")

st.divider()

# Afficher les tâches
st.header("Liste des tâches")
response = requests.get(f"{API_URL}/taches")
if response.status_code == 200:
    taches = response.json()["taches"]
    if taches:
        for i, tache in enumerate(taches):
            col1, col2 = st.columns([4, 1])
            col1.write(f"**{i + 1}.** {tache}")
            if col2.button("Supprimer", key=f"del_{i}"):
                requests.delete(f"{API_URL}/taches/{i}")
                st.rerun()
    else:
        st.info("Aucune tâche pour le moment.")
else:
    st.error("Impossible de contacter l'API. Vérifiez que FastAPI est démarré.")
```

---

### Structure du projet après création des fichiers

```mermaid
flowchart TD
    ROOT["MonProjetFastAPIStreamlit\\"]
    ROOT --> ENV["myfastapienv\\"]
    ROOT --> BACK["backend.py\nAPI FastAPI — routes GET, POST, DELETE"]
    ROOT --> FRONT["frontend.py\nInterface Streamlit — formulaire + liste"]
    ROOT --> REQ["requirements.txt"]
```

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-9"></a>

<details>
<summary><strong>9 — Étape 8 — Lancer FastAPI et Streamlit</strong></summary>

<br/>

Vous devez ouvrir **deux terminaux séparés**, tous les deux dans le dossier projet avec l'environnement activé.

---

### Terminal 1 — Lancer FastAPI

```cmd
cd C:\Users\VotreNom\Documents\MonProjetFastAPIStreamlit
myfastapienv\Scripts\activate
uvicorn backend:app --reload
```

**Résultat attendu :**

```plaintext
INFO:     Started server process [xxxxx]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
```

---

### Terminal 2 — Lancer Streamlit

```cmd
cd C:\Users\VotreNom\Documents\MonProjetFastAPIStreamlit
myfastapienv\Scripts\activate
streamlit run frontend.py
```

**Résultat attendu :**

```plaintext
  You can now view your Streamlit app in your browser.
  Local URL: http://localhost:8501
  Network URL: http://192.168.x.x:8501
```

---

```mermaid
flowchart TD
    T1["Terminal 1\nuvicorn backend:app --reload\nPort 8000"]
    T2["Terminal 2\nstreamlit run frontend.py\nPort 8501"]
    BROWSER["Navigateur"]
    T1 -->|"API active"| BROWSER
    T2 -->|"Interface active"| BROWSER
```

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-10"></a>

<details>
<summary><strong>10 — Étape 9 — Tester dans le navigateur</strong></summary>

<br/>

### Tester l'interface Streamlit

Ouvrez votre navigateur à l'adresse :

```
http://localhost:8501
```

Vous verrez le **Gestionnaire de tâches** : un champ texte pour ajouter des tâches et la liste des tâches existantes.

---

### Tester l'API FastAPI (Swagger UI)

```
http://127.0.0.1:8000/docs
```

Swagger UI liste toutes les routes disponibles :

| Route | Méthode | Description |
|-------|---------|-------------|
| `/` | GET | Message d'accueil |
| `/taches` | GET | Lire toutes les tâches |
| `/taches` | POST | Ajouter une tâche (paramètre `tache`) |
| `/taches/{index}` | DELETE | Supprimer la tâche à l'index donné |

---

### Flux de communication complet

```mermaid
flowchart LR
    USER["Utilisateur\n(navigateur :8501)"]
    ST["Streamlit\nfrontend.py"]
    FAST["FastAPI\nbackend.py"]
    DATA["taches = []\n(liste en mémoire)"]

    USER -->|"Remplit le formulaire"| ST
    ST -->|"POST /taches?tache=..."| FAST
    FAST -->|"taches.append(...)"| DATA
    DATA -->|"Réponse JSON"| FAST
    FAST -->|"{'message': '...'}"| ST
    ST -->|"Affiche la liste mise à jour"| USER
```

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-11"></a>

<details>
<summary><strong>11 — Étape 10 — Exporter les dépendances</strong></summary>

<br/>

Pour permettre à quelqu'un d'autre (ou à vous-même sur un autre ordinateur) de recréer exactement le même environnement :

```cmd
pip freeze > requirements.txt
```

**Exemple de contenu de `requirements.txt` :**

```plaintext
annotated-types==0.6.0
anyio==4.3.0
fastapi==0.110.0
h11==0.14.0
httptools==0.6.1
pydantic==2.6.4
requests==2.31.0
streamlit==1.32.0
uvicorn==0.29.0
...
```

**Pour réinstaller depuis ce fichier :**

```cmd
python -m venv myfastapienv
myfastapienv\Scripts\activate
pip install -r requirements.txt
```

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-12"></a>

<details>
<summary><strong>12 — Étape 11 — Désactiver l'environnement</strong></summary>

<br/>

Une fois le travail terminé, désactivez chaque terminal avec :

```cmd
deactivate
```

Pour réactiver plus tard :

```cmd
myfastapienv\Scripts\activate
```

```mermaid
flowchart LR
    ACTIVE["(myfastapienv) C:\...\MonProjet>"]
    GLOBAL["C:\...\MonProjet>"]
    ACTIVE -->|"deactivate"| GLOBAL
    GLOBAL -->|"myfastapienv\Scripts\activate"| ACTIVE
```

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-13"></a>

<details>
<summary><strong>13 — Récapitulatif des commandes</strong></summary>

<br/>

```mermaid
flowchart TD
    A["1. Créer le dossier\nmkdir MonProjetFastAPIStreamlit"] --> B["2. Créer le venv\npy -3.11 -m venv myfastapienv"]
    B --> C["3. Activer\nmyfastapienv\\Scripts\\activate"]
    C --> D["4. Installer\npip install fastapi uvicorn streamlit requests"]
    D --> E["5. Créer backend.py\net frontend.py"]
    E --> F["Terminal 1\nuvicorn backend:app --reload"]
    E --> G["Terminal 2\nstreamlit run frontend.py"]
    F --> H["http://127.0.0.1:8000/docs"]
    G --> I["http://localhost:8501"]
```

---

| Action | Commande |
|--------|----------|
| Créer le dossier | `mkdir MonProjetFastAPIStreamlit` |
| Entrer dans le dossier | `cd MonProjetFastAPIStreamlit` |
| Voir les versions Python | `py --list` |
| Créer le venv | `py -3.11 -m venv myfastapienv` |
| Activer le venv | `myfastapienv\Scripts\activate` |
| Installer FastAPI | `pip install fastapi "uvicorn[standard]"` |
| Installer Streamlit | `pip install streamlit requests` |
| Tout installer | `pip install fastapi "uvicorn[standard]" streamlit requests` |
| Vérifier les packages | `pip list` |
| Exporter les dépendances | `pip freeze > requirements.txt` |
| Lancer FastAPI | `uvicorn backend:app --reload` |
| Lancer Streamlit | `streamlit run frontend.py` |
| Désactiver le venv | `deactivate` |
| Supprimer le venv | `rmdir /s /q myfastapienv` |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-14"></a>

<details>
<summary><strong>14 — Pratique guidée — de A à Z</strong></summary>

<br/>

Suivez ces étapes dans l'ordre pour lancer votre première application FastAPI + Streamlit.

---

### 1 — Créer le projet

```cmd
cd C:\Users\VotreNom\Documents
mkdir MonProjetFastAPIStreamlit
cd MonProjetFastAPIStreamlit
```

---

### 2 — Créer et activer l'environnement virtuel

```cmd
py -3.11 -m venv myfastapienv
myfastapienv\Scripts\activate
```

Vérifiez que `(myfastapienv)` est visible.

---

### 3 — Installer FastAPI et Streamlit

```cmd
pip install fastapi "uvicorn[standard]" streamlit requests
pip list
```

---

### 4 — Créer les deux fichiers

Créez `backend.py` (code FastAPI fourni à l'étape 8a) et `frontend.py` (code Streamlit fourni à l'étape 8b).

---

### 5 — Lancer les deux applications

**Terminal 1 :**

```cmd
uvicorn backend:app --reload
```

**Terminal 2 (nouveau terminal, même dossier) :**

```cmd
myfastapienv\Scripts\activate
streamlit run frontend.py
```

---

### 6 — Tester

- Interface Streamlit : [http://localhost:8501](http://localhost:8501)
- Documentation FastAPI : [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)

---

### 7 — Exporter et désactiver

```cmd
pip freeze > requirements.txt
deactivate
```

---

> **Vérification :** Si Streamlit affiche "Impossible de contacter l'API", vérifiez que FastAPI est bien démarré dans l'autre terminal et que l'URL est `http://127.0.0.1:8000`.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-15"></a>

<details>
<summary><strong>15 — Conclusion</strong></summary>

<br/>

Ce tutoriel vous a montré comment :

- Créer un environnement virtuel Python isolé avec `py -3.11`
- Installer **FastAPI**, **Uvicorn**, **Streamlit** et **Requests** dans le même environnement
- Créer un backend API avec FastAPI (routes GET, POST, DELETE)
- Créer une interface web interactive avec Streamlit qui communique avec l'API
- Lancer les deux applications simultanément dans deux terminaux
- Tester l'API via Swagger UI et l'interface via Streamlit
- Exporter les dépendances avec `pip freeze`

Avec cette architecture **FastAPI + Streamlit**, vous disposez d'une base solide pour vos projets Python : calculs, IA, traitement de données, gestion de tâches, tableaux de bord et bien plus.

> **Prochaine étape :** consultez le document [02 — FastAPI Calculator + Streamlit Frontend](./02-FastAPI-Calculator-Frontend-Streamlit-Backend-FastAPI.md) pour aller plus loin avec cette architecture.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>
