<a id="top"></a>

# Cycle de vie d'un projet IA

## Table des matières

| # | Section |
|---|---------|
| 1 | [Vue d'ensemble — Les 7 phases du cycle de vie](#section-1) |
| 2 | [Phase 1 — Définition du problème et des objectifs](#section-2) |
| 2a | &nbsp;&nbsp;&nbsp;↳ [Identifier le bon problème](#section-2) |
| 2b | &nbsp;&nbsp;&nbsp;↳ [Définir les métriques de succès](#section-2) |
| 3 | [Phase 2 — Collecte et exploration des données](#section-3) |
| 3a | &nbsp;&nbsp;&nbsp;↳ [Vue d'ensemble des sources](#section-3) |
| 3b | &nbsp;&nbsp;&nbsp;↳ [Kaggle et dépôts de datasets](#section-3) |
| 3c | &nbsp;&nbsp;&nbsp;↳ [APIs — collecter des données en temps réel](#section-3) |
| 3d | &nbsp;&nbsp;&nbsp;↳ [Web scraping](#section-3) |
| 3e | &nbsp;&nbsp;&nbsp;↳ [Open data — données ouvertes](#section-3) |
| 3f | &nbsp;&nbsp;&nbsp;↳ [Bases de données internes](#section-3) |
| 3g | &nbsp;&nbsp;&nbsp;↳ [Capteurs et IoT](#section-3) |
| 3h | &nbsp;&nbsp;&nbsp;↳ [Analyse exploratoire (EDA)](#section-3) |
| 4 | [Phase 3 — Préparation et ingénierie des données](#section-4) |
| 4a | &nbsp;&nbsp;&nbsp;↳ [Nettoyage des données](#section-4) |
| 4b | &nbsp;&nbsp;&nbsp;↳ [Feature engineering](#section-4) |
| 5 | [Phase 4 — Modélisation et entraînement](#section-5) |
| 5a | &nbsp;&nbsp;&nbsp;↳ [Choisir le bon algorithme](#section-5) |
| 5b | &nbsp;&nbsp;&nbsp;↳ [Entraînement et validation](#section-5) |
| 5c | &nbsp;&nbsp;&nbsp;↳ [Hyperparamètrès et optimisation](#section-5) |
| 5d | &nbsp;&nbsp;&nbsp;↳ [Fine-tuning — adapter un modèle pré-entraîné](#section-5) |
| 6 | [Phase 5 — Évaluation du modèle](#section-6) |
| 6a | &nbsp;&nbsp;&nbsp;↳ [Métriques d'évaluation](#section-6) |
| 6b | &nbsp;&nbsp;&nbsp;↳ [Biais, équité et limites](#section-6) |
| 7 | [Phase 6 — Déploiement](#section-7) |
| 7a | &nbsp;&nbsp;&nbsp;↳ [Stratégies de déploiement](#section-7) |
| 7b | &nbsp;&nbsp;&nbsp;↳ [Déploiement avec FastAPI](#section-7) |
| 8 | [Phase 7 — Monitoring et maintenance](#section-8) |
| 8a | &nbsp;&nbsp;&nbsp;↳ [Data drift et model drift](#section-8) |
| 8b | &nbsp;&nbsp;&nbsp;↳ [Réentraînement et versioning](#section-8) |
| 9 | [Cycle de vie des données — Rétention, archivage et suppression](#section-data-lifecycle) |
| 9a | &nbsp;&nbsp;&nbsp;↳ [Diagramme du cycle de vie des données](#section-data-lifecycle) |
| 9b | &nbsp;&nbsp;&nbsp;↳ [Politiques de rétention](#section-data-lifecycle) |
| 9c | &nbsp;&nbsp;&nbsp;↳ [Discarding — quand et comment supprimer](#section-data-lifecycle) |
| 9d | &nbsp;&nbsp;&nbsp;↳ [RGPD et obligations légales](#section-data-lifecycle) |
| 10 | [MLOps — Automatiser le cycle de vie](#section-9) |
| 11 | [Étude de cas — Projet complet de A à Z](#section-10) |
| 12 | [Travail pratique — Planifier un projet IA](#section-11) |

---

<a id="section-1"></a>

<details>
<summary><strong>1 — Vue d'ensemble — Les 7 phases du cycle de vie</strong></summary>

<br/>

Un projet IA ne se résume pas à entraîner un modèle. Il suit un **cycle de vie structuré** qui commence bien avant le code et continue longtemps après la mise en production.

```mermaid
flowchart TD
    P1["1️⃣ Définition\ndu problème"] --> P2["2️⃣ Collecte &\nexploration des données"]
    P2 --> P3["3️⃣ Préparation &\ningénierie des données"]
    P3 --> P4["4️⃣ Modélisation &\nentraînement"]
    P4 --> P5["5️⃣ Évaluation\ndu modèle"]
    P5 --> P6{Résultats\nsatisfaisants ?}
    P6 -- Non --> P3
    P6 -- Oui --> P7["6️⃣ Déploiement"]
    P7 --> P8["7️⃣ Monitoring &\nmaintenance"]
    P8 --> P9{Dégradation\ndétectée ?}
    P9 -- Oui --> P4
    P9 -- Non --> P8

    P2 --> DL["📦 Cycle de vie des données"]
    P3 --> DL
    P8 --> DL
    DL --> R["🗄️ Rétention\n(conserver, archiver)"]
    DL --> D["🗑️ Discarding\n(supprimer, anonymiser)"]
    R --> RC{Durée de\nrétention\natteinte ?}
    RC -- Oui --> D
    RC -- Non --> R
    D --> RGPD["⚖️ Conformité RGPD\n& obligations légales"]
```

---

### Les 7 phases en résumé

| Phase | Nom | Activités clés | Qui ?|
|-------|-----|----------------|------|
| 1 | **Définition du problème** | Comprendre le besoin, définir les objectifs et les métriques | Chef de projet, client, data scientist |
| 2 | **Collecte & exploration** | Identifier les sources, explorer les données (EDA) | Data engineer, data scientist |
| 3 | **Préparation des données** | Nettoyer, transformer, créer des features | Data engineer, data scientist |
| 4 | **Modélisation** | Choisir, entraîner et optimiser le modèle | Data scientist, ML engineer |
| 5 | **Évaluation** | Mesurer la performance, détecter les biais | Data scientist, équipe métier |
| 6 | **Déploiement** | Exposer le modèle via une API, intégrer dans les systèmes | ML engineer, DevOps |
| 7 | **Monitoring** | Surveiller la performance en production, réentraîner | MLOps engineer, data scientist |

---

### Pourquoi le cycle est-il itératif ?

En pratique, on revient souvent en arrière :
- Les données collectées sont insuffisantes → retour à la phase 2
- Le modèle performe bien en test mais mal en production → retour à la phase 3 ou 4
- Les besoins du client évoluent → retour à la phase 1

> Un projet IA n'est **jamais vraiment terminé** — il évolue avec les données et les besoins.

---

### Comparaison avec un projet logiciel classique

| Étape logicielle | Équivalent IA |
|-----------------|---------------|
| Recueil des besoins | Définition du problème |
| Conception de la base de données | Collecte et préparation des données |
| Développement | Modélisation et entraînement |
| Tests | Évaluation du modèle |
| Mise en production | Déploiement |
| Maintenance | Monitoring et réentraînement |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-2"></a>

<details>
<summary><strong>2 — Phase 1 — Définition du problème et des objectifs</strong></summary>

<br/>

> C'est la phase **la plus critique** du projet. Un mauvais problème bien résolu reste un mauvais résultat.

---

### Identifier le bon problème

Avant d'écrire la moindre ligne de code, il faut répondre à ces questions :

| Question | Exemple |
|----------|---------|
| **Quel est le problème métier ?** | « Nous avons trop de retours clients non traités » |
| **L'IA est-elle la bonne solution ?** | Peut-être — si le volume est élevé et les patterns répétitifs |
| **Quelles données avons-nous ?** | Historique de 50 000 tickets de support |
| **Quel est le niveau de performance attendu ?** | 85 % de classification correcte minimum |
| **Quelles sont les contraintes ?** | Temps réel requis, RGPD, budget limité |
| **Quel est l'impact si on se trompe ?** | Faible (recommandation) ou fort (médical, juridique) |

---

### L'IA n'est pas toujours la bonne réponse

```mermaid
flowchart TD
    A["Problème identifié"] --> B{Volume de données\nsuffisant ?}
    B -- Non --> C["Solution classique\n(règles, SQL, logique métier)"]
    B -- Oui --> D{Les patterns sont-ils\nrépétitifs et apprenables ?}
    D -- Non --> C
    D -- Oui --> E{Budget et compétences\ndisponibles ?}
    E -- Non --> F["Reporter ou\nexternaliser"]
    E -- Oui --> G["✅ Projet IA\njustifié"]
```

---

### Définir les métriques de succès

Il est essentiel de définir **avant** le projet comment on mesurera le succès. Il existe deux types de métriques :

#### Métriques techniques (ce que le modèle mesure)

| Métrique | Utilisation |
|----------|------------|
| **Accuracy** | Classification équilibrée |
| **précision / Recall / F1** | Classification déséquilibrée (fraude, maladie) |
| **AUC-ROC** | Comparaison de classifieurs |
| **RMSE / MAE** | Régression (prédiction de valeurs numériques) |
| **BLEU / ROUGE** | NLP (traduction, résumé) |

#### Métriques métier (ce que le client mesure)

| Métrique | Exemple |
|----------|---------|
| Réduction des coûts | « -30 % de temps de traitement des tickets » |
| Augmentation des revenus | « +5 % de taux de conversion » |
| Satisfaction client | « NPS +10 points » |
| Délai de traitement | « Réponse en < 2 secondes » |

> **Règle d'or** : une métrique technique élevée ne garantit pas un succès métier.

---

### Livrables de la phase 1

- [ ] Document de définition du problème (1 page)
- [ ] Métriques de succès techniques et métier validées par le client
- [ ] Inventaire préliminaire des données disponibles
- [ ] Analyse des risques et contraintes
- [ ] Décision Go / No-Go

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-3"></a>

<details>
<summary><strong>3 — Phase 2 — Collecte et exploration des données</strong></summary>

<br/>

> « En IA, les données sont le carburant. Un bon modèle avec de mauvaises données donnera toujours de mauvais résultats. »

---

### Vue d'ensemble des sources

```mermaid
flowchart TD
    SOURCES["Sources de données pour un projet IA"]

    SOURCES --> K["Kaggle &\ndépôts de datasets"]
    SOURCES --> API["APIs\n(temps réel)"]
    SOURCES --> WS["Web scraping"]
    SOURCES --> OD["Open data\n(données ouvertes)"]
    SOURCES --> DB["Bases de données\ninternes"]
    SOURCES --> IOT["Capteurs\n& IoT"]
    SOURCES --> SYN["Données\nsynthétiques"]

    K --> K1["Compétitions ML\nDatasets publics\nNotebooks"]
    API --> A1["REST APIs\nStreaming APIs\nWebhooks"]
    WS --> W1["HTML scraping\nPDF extraction\nImages"]
    OD --> O1["Gouvernements\nOrganismes publics\nRecherche"]
    DB --> D1["SQL / NoSQL\nData warehouses\nLogs applicatifs"]
    IOT --> I1["Capteurs industriels\nWearables\nStations météo"]
    SYN --> S1["GANs\nLLMs\nSimulations"]
```

| Source | Volume typique | Coût | Fraîcheur | Qualité |
|--------|---------------|------|-----------|---------|
| **Kaggle / dépôts** | Moyen à grand | Gratuit | Variable | Bonne à très bonne |
| **APIs** | Petit à très grand | Gratuit à élevé | Temps réel | Très bonne |
| **Web scraping** | Très grand | Faible | Temps réel | Variable (bruit) |
| **Open data** | Moyen à grand | Gratuit | Variable | Bonne |
| **Bases internes** | Petit à très grand | Nul | Temps réel | Variable |
| **Capteurs / IoT** | Très grand | Infrastructure | Temps réel | Bonne si calibrés |
| **Synthétiques** | Illimité | Faible | N/A | Contrôlée |

---

### Kaggle et dépôts de datasets

**Kaggle** ([kaggle.com](https://www.kaggle.com)) est la plus grande plateforme de data science au monde. Elle regroupe des datasets publics, des compétitions ML et des notebooks partagés par la communauté.

#### Ce que vous trouvez sur Kaggle

| Ressource | Description | Exemple |
|-----------|-------------|---------|
| **Datasets** | Fichiers CSV, JSON, images, textes prêts à l'emploi | Titanic, MNIST, House Prices |
| **Compétitions** | Problèmes réels posés par des entreprises | Détection de fraude, prédiction de maladies |
| **Notebooks** | Code Python commenté par la communauté | Solutions gagnantes des compétitions |
| **Modèles** | Modèles pré-entraînés partageables | Fine-tuned BERT, ResNet custom |

#### Télécharger un dataset Kaggle avec l'API

```python
# Installation
# pip install kaggle

# 1. Configurer les credentials : ~/.kaggle/kaggle.json
# {"username": "votre_username", "key": "votre_api_key"}

import kaggle

# Télécharger un dataset
kaggle.api.dataset_download_files(
    'uciml/iris',          # username/dataset-name
    path='./data/',
    unzip=True
)

# Télécharger les données d'une compétition
kaggle.api.competition_download_files(
    'titanic',
    path='./data/titanic/'
)

# Lister les datasets disponibles sur un sujet
kaggle.api.dataset_list(search='fraud detection')
```

#### Autres dépôts majeurs de datasets

| Dépôt | URL | Spécialité |
|-------|-----|-----------|
| **UCI ML Repository** | archive.ics.uci.edu/ml | Datasets classiques ML (Iris, Wine, Adult...) |
| **Hugging Face Datasets** | huggingface.co/datasets | NLP, LLMs, multimodal |
| **Google Dataset Search** | datasetsearch.research.google.com | Moteur de recherche de datasets |
| **Papers With Code** | paperswithcode.com/datasets | Datasets liés à des articles de recherche |
| **AWS Open Data** | registry.opendata.aws | Données massives sur AWS S3 |
| **GitHub** | github.com | Datasets dans des dépôts publics |
| **Zenodo** | zenodo.org | Données scientifiques et académiques |

```python
# Charger un dataset Hugging Face directement
from datasets import load_dataset

# Dataset de classification de texte
dataset = load_dataset("imdb")
print(dataset["train"][0])

# Dataset multilingue
dataset_fr = load_dataset("wikipedia", "20220301.fr", split="train[:1%]")

# Voir les infos
print(dataset.info)
print(dataset["train"].features)
```

---

### APIs — Collecter des données en temps réel

Une **API** (Application Programming Interface) permet d'accéder à des données en temps réel via des requêtes HTTP. C'est la méthode la plus courante pour collecter des données fraîches et structurées.

#### Types d'APIs

```mermaid
flowchart LR
    subgraph REST["REST API\n(requête / réponse)"]
        R1["GET /data\nRécupérer des données"]
        R2["POST /data\nEnvoyer des données"]
    end
    subgraph STREAM["Streaming API\n(flux continu)"]
        S1["WebSocket\nFlux en temps réel"]
        S2["Server-Sent Events\nNotifications push"]
    end
    subgraph GRAPH["GraphQL\n(requête flexible)"]
        G1["Query\nDemander exactement\nce dont on a besoin"]
    end
```

#### Exemples d'APIs par domaine

| Domaine | API | Données disponibles | Gratuit ? |
|---------|-----|---------------------|-----------|
| **Météo** | OpenWeatherMap | Températures, précipitations, prévisions | Oui (limité) |
| **Finance** | Alpha Vantage, Yahoo Finance | Cours boursiers, indicateurs | Oui (limité) |
| **Réseaux sociaux** | Reddit API, YouTube Data API | Posts, commentaires, vidéos | Oui (limité) |
| **Géographie** | OpenStreetMap, Google Maps | Coordonnées, adresses, itinéraires | Oui / Payant |
| **Actualités** | NewsAPI, GDELT | Articles de presse | Oui (limité) |
| **Santé** | PubMed API, ClinicalTrials | Articles médicaux, essais cliniques | Oui |
| **Transport** | GTFS, SNCF API, Translink API | Horaires, retards, positions | Oui |
| **Gouvernement** | data.gouv.fr API, Statistics Canada | Données publiques officielles | Oui |

#### Collecter des données via une REST API

```python
import requests
import pandas as pd
import time

# Exemple : collecter des données météo pour plusieurs villes
API_KEY = "votre_cle_openweathermap"
BASE_URL = "https://api.openweathermap.org/data/2.5/weather"

villes = ["Montreal", "Paris", "London", "Tokyo", "New York"]
records = []

for ville in villes:
    params = {
        "q": ville,
        "appid": API_KEY,
        "units": "metric",
        "lang": "fr"
    }
    response = requests.get(BASE_URL, params=params)

    if response.status_code == 200:
        data = response.json()
        records.append({
            "ville": ville,
            "temperature": data["main"]["temp"],
            "humidite": data["main"]["humidity"],
            "description": data["weather"][0]["description"],
            "vent_kmh": data["wind"]["speed"] * 3.6
        })
    else:
        print(f"Erreur pour {ville} : {response.status_code}")

    time.sleep(0.5)  # respecter la limite de taux

df = pd.DataFrame(records)
df.to_csv("meteo_villes.csv", index=False)
print(df)
```

#### Collecter des données financières (Yahoo Finance)

```python
import yfinance as yf
import pandas as pd

# Télécharger l'historique de plusieurs actions
tickers = ["AAPL", "GOOGL", "MSFT", "NVDA", "META"]

all_data = []
for ticker in tickers:
    stock = yf.Ticker(ticker)
    hist = stock.history(period="2y")   # 2 ans de données
    hist["ticker"] = ticker
    hist.reset_index(inplace=True)
    all_data.append(hist)

df = pd.concat(all_data, ignore_index=True)
df.to_csv("historique_actions.csv", index=False)
print(f"Collecté : {len(df)} lignes pour {len(tickers)} actions")
```

#### Gestion des limites d'API (Rate Limiting)

```python
import requests
import time
from functools import wraps

def retry_on_rate_limit(max_retries=3, wait_seconds=60):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            for attempt in range(max_retries):
                response = func(*args, **kwargs)
                if response.status_code == 429:  # Too Many Requests
                    print(f"Limite atteinte. Attente de {wait_seconds}s...")
                    time.sleep(wait_seconds)
                elif response.status_code == 200:
                    return response
                else:
                    raise Exception(f"Erreur {response.status_code}")
            raise Exception("Nombre maximum de tentatives atteint")
        return wrapper
    return decorator

@retry_on_rate_limit(max_retries=3, wait_seconds=30)
def appeler_api(url, params):
    return requests.get(url, params=params)
```

---

### Web scraping

Le **web scraping** consiste à extraire automatiquement des données de pages web. C'est utile quand aucune API n'est disponible.

> **Important** : Toujours vérifier les conditions d'utilisation du site (`robots.txt`) et respecter les lois (RGPD, CFAA, etc.) avant de scraper.

#### Vérifier robots.txt

```
# Exemple de robots.txt — toujours le consulter en premier
# https://www.exemple.com/robots.txt

User-agent: *
Disallow: /private/
Disallow: /admin/
Allow: /public/

Crawl-delay: 10   # attendre 10 secondes entre les requêtes
```

```python
import urllib.robotparser

def scraping_autorise(url_site: str, url_cible: str) -> bool:
    rp = urllib.robotparser.RobotFileParser()
    rp.set_url(f"{url_site}/robots.txt")
    rp.read()
    return rp.can_fetch("*", url_cible)

# Vérification avant de scraper
if scraping_autorise("https://www.exemple.com", "https://www.exemple.com/articles/"):
    print("Scraping autorisé")
else:
    print("Scraping interdit — chercher une alternative")
```

#### Web scraping avec BeautifulSoup

```python
import requests
from bs4 import BeautifulSoup
import pandas as pd
import time

def scraper_articles(url_base: str, nb_pages: int = 5) -> pd.DataFrame:
    articles = []

    for page in range(1, nb_pages + 1):
        url = f"{url_base}?page={page}"
        headers = {"User-Agent": "Mozilla/5.0 (compatible; DataCollector/1.0)"}
        response = requests.get(url, headers=headers, timeout=10)

        if response.status_code != 200:
            print(f"Erreur page {page}: {response.status_code}")
            continue

        soup = BeautifulSoup(response.text, "html.parser")

        for article in soup.find_all("article", class_="post"):
            titre = article.find("h2")
            date = article.find("time")
            texte = article.find("p", class_="excerpt")

            if titre and date and texte:
                articles.append({
                    "titre": titre.get_text(strip=True),
                    "date": date.get("datetime", ""),
                    "extrait": texte.get_text(strip=True),
                    "url": article.find("a")["href"] if article.find("a") else ""
                })

        time.sleep(2)   # respecter le serveur
        print(f"Page {page} traitée — {len(articles)} articles collectés")

    return pd.DataFrame(articles)
```

#### Scraping dynamique avec Selenium (JavaScript rendu côté client)

```python
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

options = webdriver.ChromeOptions()
options.add_argument("--headless")   # sans interface graphique
options.add_argument("--no-sandbox")

driver = webdriver.Chrome(options=options)

try:
    driver.get("https://www.exemple.com/tableau-dynamique")
    # Attendre que le tableau soit chargé par JavaScript
    WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.CSS_SELECTOR, "table.data-table"))
    )
    lignes = driver.find_elements(By.CSS_SELECTOR, "table.data-table tbody tr")
    data = []
    for ligne in lignes:
        colonnes = ligne.find_elements(By.TAG_NAME, "td")
        data.append([col.text for col in colonnes])
finally:
    driver.quit()
```

#### Extraction de texte depuis des PDFs

```python
import pdfplumber
import pandas as pd

def extraire_tableaux_pdf(chemin_pdf: str) -> list:
    tous_les_tableaux = []
    with pdfplumber.open(chemin_pdf) as pdf:
        for i, page in enumerate(pdf.pages):
            # Extraire le texte
            texte = page.extract_text()
            # Extraire les tableaux
            tableaux = page.extract_tables()
            for tableau in tableaux:
                df = pd.DataFrame(tableau[1:], columns=tableau[0])
                df["page_source"] = i + 1
                tous_les_tableaux.append(df)
    return tous_les_tableaux

# Utilisation
tableaux = extraire_tableaux_pdf("rapport_annuel.pdf")
for t in tableaux:
    print(t.head())
```

---

### Open data — Données ouvertes

Les **données ouvertes** sont des données publiées par des gouvernements, organismes publics ou institutions de recherche, librement accessibles et réutilisables.

#### Portails open data majeurs

| Portail | URL | Contenu |
|---------|-----|---------|
| **data.gouv.fr** | data.gouv.fr | Données publiques françaises |
| **open.canada.ca** | open.canada.ca | Données fédérales canadiennes |
| **statcan.gc.ca** | statcan.gc.ca | Statistiques Canada |
| **donnees.ville.montreal.qc.ca** | donnees.ville.montreal.qc.ca | Données de la Ville de Montréal |
| **data.europa.eu** | data.europa.eu | Données de l'Union européenne |
| **data.worldbank.org** | data.worldbank.org | Indicateurs économiques mondiaux |
| **ourworldindata.org** | ourworldindata.org | Données mondiales sur la santé, l'énergie, etc. |
| **NASA Open Data** | data.nasa.gov | Données spatiales et environnementales |
| **WHO Data** | who.int/data | Données de santé mondiale |
| **NOAA** | noaa.gov | Données climatiques et océaniques |

#### Télécharger des données de Statistiques Canada

```python
import requests
import pandas as pd
import io

# Télécharger un tableau de Statistiques Canada (format CSV)
# Exemple : Tableau 14-10-0023-01 — Emploi par industrie
TABLE_ID = "1410002301"
URL = f"https://www150.statcan.gc.ca/t1/tbl1/fr/dtbl/csv/{TABLE_ID}.zip"

response = requests.get(URL)
if response.status_code == 200:
    import zipfile
    with zipfile.ZipFile(io.BytesIO(response.content)) as z:
        with z.open(f"{TABLE_ID}.csv") as f:
            df = pd.read_csv(f, encoding="utf-8-sig")
    print(df.head())
    print(f"Forme : {df.shape}")
```

#### Données de la Ville de Montréal (CKAN API)

```python
import requests
import pandas as pd

# API CKAN — standard pour beaucoup de portails open data
CKAN_URL = "https://donnees.montreal.ca/api/3/action/datastore_search"

params = {
    "resource_id": "c7d0546a-a218-479e-bc9f-ce8f13d8818e",  # ID du dataset
    "limit": 1000,
    "offset": 0
}

tous_les_enregistrements = []
while True:
    response = requests.get(CKAN_URL, params=params)
    data = response.json()["result"]
    enregistrements = data["records"]
    tous_les_enregistrements.extend(enregistrements)
    if len(enregistrements) < params["limit"]:
        break
    params["offset"] += params["limit"]

df = pd.DataFrame(tous_les_enregistrements)
print(f"Total collecté : {len(df)} enregistrements")
```

---

### Bases de données internes

Les données internes sont souvent les plus précieuses pour un projet IA — elles reflètent la réalité spécifique de l'organisation.

#### Types de bases de données internes

```mermaid
flowchart TD
    DB["Bases de données\ninternes"]
    DB --> SQL["Bases SQL\n(PostgreSQL, MySQL,\nSQL Server, SQLite)"]
    DB --> NOSQL["Bases NoSQL\n(MongoDB, Redis,\nCassandra, DynamoDB)"]
    DB --> DW["Data Warehouses\n(BigQuery, Snowflake,\nRedshift)"]
    DB --> LOGS["Logs applicatifs\n(fichiers .log,\nElasticsearch)"]
    DB --> FILES["Fichiers\n(CSV, Excel, JSON\nParquet, Avro)"]
    DB --> ERP["ERP / CRM\n(SAP, Salesforce,\nOdoo)"]
```

#### Connecter et extraire des données SQL

```python
import pandas as pd
import sqlalchemy

# Connexion PostgreSQL
engine = sqlalchemy.create_engine(
    "postgresql://user:password@localhost:5432/ma_base"
)

# Extraire des données avec une requête SQL
query = """
    SELECT
        c.client_id,
        c.age,
        c.ville,
        COUNT(t.transaction_id) AS nb_transactions,
        SUM(t.montant) AS total_depenses,
        MAX(t.date_transaction) AS derniere_transaction,
        CASE WHEN MAX(t.date_transaction) > NOW() - INTERVAL '90 days'
             THEN 1 ELSE 0 END AS actif_90j
    FROM clients c
    LEFT JOIN transactions t ON c.client_id = t.client_id
    WHERE t.date_transaction >= '2023-01-01'
    GROUP BY c.client_id, c.age, c.ville
    ORDER BY total_depenses DESC
"""

df = pd.read_sql(query, engine)
print(f"Extrait : {len(df)} clients")
print(df.dtypes)
```

#### Extraire depuis MongoDB (NoSQL)

```python
from pymongo import MongoClient
import pandas as pd

client = MongoClient("mongodb://localhost:27017/")
db = client["ma_base"]
collection = db["logs_utilisateurs"]

# Requête avec filtres et projection
pipeline = [
    {"$match": {
        "date": {"$gte": "2024-01-01"},
        "action": {"$in": ["achat", "panier", "vue_produit"]}
    }},
    {"$group": {
        "_id": "$user_id",
        "nb_actions": {"$sum": 1},
        "nb_achats": {"$sum": {"$cond": [{"$eq": ["$action", "achat"]}, 1, 0]}},
        "total_depenses": {"$sum": "$montant"}
    }},
    {"$sort": {"nb_achats": -1}},
    {"$limit": 10000}
]

resultats = list(collection.aggregate(pipeline))
df = pd.DataFrame(resultats)
df.rename(columns={"_id": "user_id"}, inplace=True)
print(df.head())
```

#### Lire des fichiers logs

```python
import re
import pandas as pd
from pathlib import Path

# Parser des logs Apache/Nginx
LOG_PATTERN = r'(\S+) \S+ \S+ \[(.+?)\] "(\S+) (\S+) \S+" (\d+) (\d+)'

def parser_log(chemin_log: str) -> pd.DataFrame:
    records = []
    with open(chemin_log, "r") as f:
        for ligne in f:
            match = re.match(LOG_PATTERN, ligne)
            if match:
                records.append({
                    "ip": match.group(1),
                    "date": match.group(2),
                    "methode": match.group(3),
                    "url": match.group(4),
                    "status_code": int(match.group(5)),
                    "taille_bytes": int(match.group(6))
                })
    return pd.DataFrame(records)

df_logs = parser_log("/var/log/nginx/access.log")
print(f"Requêtes collectées : {len(df_logs)}")
print(df_logs["status_code"].value_counts())
```

---

### Capteurs et IoT

Les **capteurs** et appareils **IoT** (Internet of Things) génèrent des flux continus de données en temps réel. Ces données sont souvent utilisées pour la maintenance prédictive, la surveillance environnementale ou la santé.

#### Types de capteurs par domaine

| Domaine | Type de capteur | Données générées | Fréquence |
|---------|----------------|-----------------|-----------|
| **Industrie** | Accéléromètres, vibrations | Usure des machines | 100–10 000 Hz |
| **Environnement** | Température, humidité, CO2 | Qualité de l'air | 1 mesure / minute |
| **Santé** | Cardiofréquencemètre, oxymètre | Rythme cardiaque, SpO2 | 1–250 Hz |
| **Transport** | GPS, accéléromètre | Position, vitesse | 1–10 Hz |
| **Agriculture** | Humidité du sol, luminosité | Conditions de culture | 1 mesure / heure |
| **Bâtiment** | Compteurs électriques, présence | Consommation d'énergie | 1 mesure / 15 min |

#### Collecter des données de capteurs avec MQTT

```python
import paho.mqtt.client as mqtt
import json
import pandas as pd
from datetime import datetime

# MQTT est le protocole standard pour l'IoT
mesures = []

def on_connect(client, userdata, flags, rc):
    print(f"Connecté au broker MQTT — code {rc}")
    client.subscribe("capteurs/temperature/#")   # s'abonner à tous les capteurs de T°
    client.subscribe("capteurs/humidite/#")

def on_message(client, userdata, msg):
    try:
        payload = json.loads(msg.payload.decode())
        mesures.append({
            "timestamp": datetime.now().isoformat(),
            "topic": msg.topic,
            "capteur_id": payload.get("id"),
            "valeur": payload.get("valeur"),
            "unite": payload.get("unite"),
            "latitude": payload.get("lat"),
            "longitude": payload.get("lon")
        })
        if len(mesures) % 100 == 0:
            print(f"{len(mesures)} mesures collectées")
    except Exception as e:
        print(f"Erreur parsing: {e}")

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message
client.connect("broker.hivemq.com", 1883, keepalive=60)

# Collecter pendant 10 minutes
client.loop_start()
import time
time.sleep(600)
client.loop_stop()

df = pd.DataFrame(mesures)
df.to_csv("donnees_capteurs.csv", index=False)
print(f"Total collecté : {len(df)} mesures")
```

#### Simuler des données de capteurs pour tests

```python
import numpy as np
import pandas as pd
from datetime import datetime, timedelta

def simuler_capteur_temperature(
    nb_heures: int = 720,    # 30 jours
    freq_minutes: int = 5,
    capteur_id: str = "CAP_001"
) -> pd.DataFrame:

    nb_points = nb_heures * 60 // freq_minutes
    debut = datetime.now() - timedelta(hours=nb_heures)
    timestamps = [debut + timedelta(minutes=i * freq_minutes) for i in range(nb_points)]

    # Simulation réaliste : tendance journalière + bruit + anomalies
    heures = np.array([t.hour for t in timestamps])
    tendance_journaliere = 20 + 8 * np.sin((heures - 6) * np.pi / 12)
    bruit = np.random.normal(0, 0.5, nb_points)

    # Injecter quelques anomalies (5 % des points)
    anomalies = np.zeros(nb_points)
    indices_anomalies = np.random.choice(nb_points, size=int(nb_points * 0.05), replace=False)
    anomalies[indices_anomalies] = np.random.choice([-15, 15], size=len(indices_anomalies))

    temperatures = tendance_journaliere + bruit + anomalies

    return pd.DataFrame({
        "timestamp": timestamps,
        "capteur_id": capteur_id,
        "temperature_c": temperatures.round(2),
        "est_anomalie": anomalies != 0
    })

df_capteur = simuler_capteur_temperature()
print(df_capteur.head(10))
print(f"Anomalies simulées : {df_capteur['est_anomalie'].sum()}")
```

---

### Analyse exploratoire des données (EDA)

L'**EDA** (Exploratory Data Analysis) consiste à comprendre les données avant de modéliser.

```python
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv("dataset.csv")

# Aperçu général
print(df.shape)           # dimensions
print(df.dtypes)          # types de colonnes
print(df.describe())      # statistiques descriptives
print(df.isnull().sum())  # valeurs manquantes

# Distribution d'une variable cible
df["label"].value_counts().plot(kind="bar")
plt.title("Distribution des classes")
plt.show()

# Corrélations
sns.heatmap(df.corr(), annot=True, cmap="coolwarm")
plt.show()
```

---

### Questions à poser lors de l'EDA

| Question | Ce qu'on cherche |
|----------|-----------------|
| Combien de lignes et de colonnes ? | Taille suffisante pour entraîner |
| Y a-t-il des valeurs manquantes ? | Stratégie de traitement |
| Les classes sont-elles équilibrées ? | Risque de biais du modèle |
| Y a-t-il des outliers ? | Données aberrantes à traiter |
| Les features sont-elles corrélées ? | Redondance ou multicolinéarité |
| Les données sont-elles récentes ? | Risque de data drift |

---

### Les problèmes fréquents

```mermaid
mindmap
  root((Problèmes\nde données))
    Quantité
      Trop peu de données
      Déséquilibre des classes
    Qualité
      Valeurs manquantes
      Erreurs de saisie
      Doublons
    Pertinence
      Features non informatives
      Fuite de données (data leakage)
    Légalité
      RGPD et données personnelles
      Biais historiques
```

---

### Analyse exploratoire des données (EDA)

L'**EDA** (Exploratory Data Analysis) consiste à comprendre les données avant de modéliser.

```python
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv("dataset.csv")

# Aperçu général
print(df.shape)           # dimensions
print(df.dtypes)          # types de colonnes
print(df.describe())      # statistiques descriptives
print(df.isnull().sum())  # valeurs manquantes

# Distribution d'une variable cible
df["label"].value_counts().plot(kind="bar")
plt.title("Distribution des classes")
plt.show()

# Corrélations
sns.heatmap(df.corr(), annot=True, cmap="coolwarm")
plt.show()
```

---

### Questions à poser lors de l'EDA

| Question | Ce qu'on cherche |
|----------|-----------------|
| Combien de lignes et de colonnes ? | Taille suffisante pour entraîner |
| Y a-t-il des valeurs manquantes ? | Stratégie de traitement |
| Les classes sont-elles équilibrées ? | Risque de biais du modèle |
| Y a-t-il des outliers ? | Données aberrantes à traiter |
| Les features sont-elles corrélées ? | Redondance ou multicolinéarité |
| Les données sont-elles récentes ? | Risque de data drift |

---

### Les problèmes fréquents

```mermaid
mindmap
  root((Problèmes\nde données))
    Quantité
      Trop peu de données
      Déséquilibre des classes
    Qualité
      Valeurs manquantes
      Erreurs de saisie
      Doublons
    Pertinence
      Features non informatives
      Fuite de données (data leakage)
    Légalité
      RGPD et données personnelles
      Biais historiques
```

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-4"></a>

<details>
<summary><strong>4 — Phase 3 — Préparation et ingénierie des données</strong></summary>

<br/>

> En moyenne, **60 à 80 % du temps** d'un projet IA est consacré à la préparation des données.

---

### Nettoyage des données

| Problème | Traitement courant |
|----------|-------------------|
| Valeurs manquantes | Suppression, imputation (moyenne, médiane, mode, KNN) |
| Doublons | `df.drop_duplicates()` |
| Outliers | Suppression, winsorization, transformation log |
| Types incorrects | `df["col"].astype(int)` |
| Texte brut | Normalisation, suppression des stop words, lemmatisation |
| Dates | Extraction de features (jour, mois, jour de la semaine) |

```python
# Exemple de nettoyage
import pandas as pd
from sklearn.impute import SimpleImputer

df = pd.read_csv("data.csv")

# Supprimer les doublons
df = df.drop_duplicates()

# Imputer les valeurs manquantes numériques par la médiane
imputer = SimpleImputer(strategy="median")
df[["age", "salary"]] = imputer.fit_transform(df[["age", "salary"]])

# Encoder les variables catégorielles
df = pd.get_dummies(df, columns=["city", "category"], drop_first=True)

print(df.shape)
```

---

### Feature engineering

Le **feature engineering** consiste à créer de nouvelles variables à partir des données existantes pour améliorer les performances du modèle.

| Technique | Exemple |
|-----------|---------|
| **Extraction** | Extraire l'heure, le jour, le mois d'une date |
| **Combinaison** | `prix_total = prix_unitaire × quantité` |
| **Transformation** | `log(revenu)` pour réduire l'asymétrie |
| **Encodage** | One-hot encoding, label encoding, target encoding |
| **Normalisation** | MinMaxScaler, StandardScaler |
| **Binning** | Regrouper les âges en tranches (0-18, 18-35, 35-60, 60+) |
| **Embeddings** | Transformer du texte en vecteurs numériques |

---

### Découpage train / validation / test

```mermaid
flowchart LR
    D["Dataset complet\n100 %"] --> TR["Train\n70 %\nEntraîner le modèle"]
    D --> VA["Validation\n15 %\nAjuster les hyperparamètres"]
    D --> TE["Test\n15 %\nÉvaluation finale\n⚠️ Ne jamais toucher avant la fin"]
```

> **Règle absolue** : le jeu de test ne doit **jamais** être utilisé pendant le développement. Il simule les données que le modèle verra en production.

---

### Data leakage — L'erreur la plus dangereuse

Le **data leakage** (fuite de données) survient quand des informations du futur ou de la cible se retrouvent dans les features d'entraînement. Le modèle semble très performant en test, mais échoue complètement en production.

**Exemples de leakage :**
- Inclure la variable cible dans les features
- Normaliser les données **avant** de séparer train/test (le test influence la normalisation)
- Utiliser des données créées **après** l'événement à prédire

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-5"></a>

<details>
<summary><strong>5 — Phase 4 — Modélisation et entraînement</strong></summary>

<br/>

### Choisir le bon algorithme

Le choix de l'algorithme dépend du **type de problème**, de la **taille des données** et des **contraintes** (interprétabilité, vitesse).

```mermaid
flowchart TD
    A["Type de problème ?"] --> B["Classification\n(sortie = catégorie)"]
    A --> C["Régression\n(sortie = nombre)"]
    A --> D["Clustering\n(pas de labels)"]
    A --> E["Génération\n(texte, image, audio)"]

    B --> B1["Logistic Regression\nRandom Forest\nSVM\nXGBoost\nRéseau de neurones"]
    C --> C1["Linear Regression\nRandom Forest\nXGBoost\nRéseau de neurones"]
    D --> D1["K-Means\nDBSCAN\nHierarchical Clustering"]
    E --> E1["LLMs (GPT, Claude)\nGANs\nDiffusion Models"]
```

---

### Tableau de sélection des algorithmes

| Algorithme | Type | Avantages | Inconvénients |
|-----------|------|-----------|---------------|
| **Régression logistique** | Classification | Rapide, interprétable | Limité aux relations linéaires |
| **Random Forest** | Class. / Régr. | Robuste, peu de tuning | Boîte noire, lent sur gros volumes |
| **XGBoost / LightGBM** | Class. / Régr. | Très performant, compétitions Kaggle | Hyperparamètrès complexes |
| **SVM** | Classification | Efficace en haute dimension | Lent sur grands datasets |
| **K-Means** | Clustering | Simple, rapide | Nombre de clusters à fixer à l'avance |
| **Réseau de neurones** | Tout type | Universel, très puissant | Données volumineuses requises, boîte noire |
| **CNN** | Computer Vision | État de l'art pour les images | Requiert GPU, beaucoup de données |
| **Transformer / LLM** | NLP, génératif | État de l'art pour le texte | Très coûteux en ressources |

---

### Entraînement et validation croisée

```python
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import cross_val_score, train_test_split
from sklearn.metrics import classification_report

# Séparation train/test
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# Entraînement
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# Validation croisée sur le train (5 folds)
scores = cross_val_score(model, X_train, y_train, cv=5, scoring="f1_macro")
print(f"F1 moyen (CV) : {scores.mean():.3f} ± {scores.std():.3f}")

# Évaluation finale sur le test
y_pred = model.predict(X_test)
print(classification_report(y_test, y_pred))
```

---

### Hyperparamètrès et optimisation

Les **hyperparamètres** sont les paramètrès que l'on fixe **avant** l'entraînement (contrairement aux paramètrès appris par le modèle).

| Algorithme | Hyperparamètrès courants |
|-----------|--------------------------|
| Random Forest | `n_estimators`, `max_depth`, `min_samples_split` |
| XGBoost | `learning_rate`, `n_estimators`, `max_depth`, `subsample` |
| Réseau de neurones | `learning_rate`, nombre de couches, taille des couches, `dropout` |
| K-Means | `n_clusters`, `init` |

**Techniques d'optimisation :**

```python
from sklearn.model_selection import GridSearchCV

param_grid = {
    "n_estimators": [50, 100, 200],
    "max_depth": [None, 10, 20],
    "min_samples_split": [2, 5, 10]
}

grid_search = GridSearchCV(
    RandomForestClassifier(random_state=42),
    param_grid,
    cv=5,
    scoring="f1_macro",
    n_jobs=-1
)
grid_search.fit(X_train, y_train)
print("Meilleurs paramètrès :", grid_search.best_params_)
```

---

### Fine-tuning — adapter un modèle pré-entraîné

Le **fine-tuning** consiste à prendre un modèle déjà entraîné sur une grande quantité de données (modèle pré-entraîné) et à le **réentraîner partiellement** sur vos propres données spécifiques pour l'adapter à votre tâche.

> C'est l'approche dominante en 2026 : plutôt que d'entraîner un modèle de zéro (coûteux et lent), on part d'un modèle puissant et on l'affine.

---

#### Pourquoi faire du fine-tuning ?

| Situation | Solution recommandée |
|-----------|---------------------|
| Peu de données, tâche standard | **Zero-shot / Few-shot** avec un LLM |
| Données spécifiques à un domaine (médical, juridique...) | **Fine-tuning** |
| Tâche très différente du modèle de base | **Fine-tuning complet** |
| Budget limité, modèle déjà bon | **Prompt engineering** seulement |
| Besoin de style ou format précis | **Fine-tuning** |

---

#### Les 3 niveaux de fine-tuning

```mermaid
flowchart TD
    PT["Modèle pré-entraîné\n(GPT, BERT, ResNet, LLaMA...)"]
    PT --> A["1️⃣ Feature extraction\nGeler toutes les couches\nAjouter une couche de sortie\nEntraîner uniquement la tête"]
    PT --> B["2️⃣ Fine-tuning partiel\nGeler les premières couches\nRéentraîner les dernières couches\n+ la tête"]
    PT --> C["3️⃣ Fine-tuning complet\nRéentraîner tout le modèle\nRequiert plus de données et de GPU"]

    A --> A1["✅ Peu de données\nRapide, moins de risque d'overfitting"]
    B --> B1["✅ Données moyennes\nBon équilibre performance / coût"]
    C --> C1["✅ Beaucoup de données\nMeilleure adaptation possible"]
```

---

#### Fine-tuning d'un modèle de vision (Transfer Learning avec TensorFlow)

```python
import tensorflow as tf
from tensorflow.keras.applications import MobileNetV2
from tensorflow.keras import layers, Model

# 1. Charger le modèle pré-entraîné sans la tête de classification
base_model = MobileNetV2(
    input_shape=(224, 224, 3),
    include_top=False,       # on retire la couche finale
    weights="imagenet"       # poids pré-entraînés sur ImageNet
)

# 2. Geler les couches du modèle de base (feature extraction)
base_model.trainable = False

# 3. ajouter notre propre tête de classification
x = base_model.output
x = layers.GlobalAveragePooling2D()(x)
x = layers.Dense(128, activation="relu")(x)
output = layers.Dense(3, activation="softmax")(x)  # 3 classes

model = Model(inputs=base_model.input, outputs=output)

# 4. Entraîner seulement la tête
model.compile(optimizer="adam", loss="categorical_crossentropy", metrics=["accuracy"])
model.fit(train_ds, validation_data=val_ds, epochs=10)

# 5. Fine-tuning partiel : dégeler les 20 dernières couches
base_model.trainable = True
for layer in base_model.layers[:-20]:
    layer.trainable = False

model.compile(optimizer=tf.keras.optimizers.Adam(1e-5), # lr très petit
              loss="categorical_crossentropy",
              metrics=["accuracy"])
model.fit(train_ds, validation_data=val_ds, epochs=5)
```

---

#### Fine-tuning d'un LLM (avec Hugging Face)

```python
from transformers import AutoModelForSequenceClassification, AutoTokenizer, Trainer, TrainingArguments
from datasets import load_dataset

# 1. Charger le modèle et le tokenizer pré-entraînés
model_name = "bert-base-uncased"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForSequenceClassification.from_pretrained(model_name, num_labels=2)

# 2. Préparer les données
dataset = load_dataset("imdb")

def tokenize(batch):
    return tokenizer(batch["text"], truncation=True, padding="max_length", max_length=512)

tokenized = dataset.map(tokenize, batched=True)

# 3. Configurer l'entraînement
training_args = TrainingArguments(
    output_dir="./results",
    num_train_epochs=3,
    per_device_train_batch_size=16,
    per_device_eval_batch_size=16,
    evaluation_strategy="epoch",
    save_strategy="epoch",
    learning_rate=2e-5,        # très petit pour ne pas détruire les poids pré-entraînés
    load_best_model_at_end=True,
)

# 4. Lancer le fine-tuning
trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=tokenized["train"],
    eval_dataset=tokenized["test"],
)
trainer.train()
```

---

#### PEFT et LoRA — Fine-tuning à faible coût

Pour les très grands modèles (LLaMA, Mistral, GPT...), le fine-tuning complet est **trop coûteux**. On utilise des techniques de **fine-tuning efficace** :

| Technique | Description | Coût |
|-----------|-------------|------|
| **LoRA** (Low-Rank Adaptation) | ajouter de petites matrices d'adaptation sans modifier les poids originaux | Très faible |
| **QLoRA** | LoRA + quantification 4-bit | Encore plus faible — faisable sur 1 GPU grand public |
| **Prefix Tuning** | ajouter des tokens virtuels entraînables en début de séquence | Faible |
| **adapter layers** | Insérer de petites couches entre les couches existantes | Faible |

```python
# Exemple avec PEFT + LoRA (Hugging Face)
from peft import get_peft_model, LoraConfig, TaskType

lora_config = LoraConfig(
    task_type=TaskType.SEQ_CLS,
    r=8,              # rang des matrices LoRA
    lora_alpha=32,
    lora_dropout=0.1,
    target_modules=["query", "value"]
)

peft_model = get_peft_model(model, lora_config)
peft_model.print_trainable_parameters()
# → "trainable params: 294,912 || all params: 109,776,128 || trainable%: 0.27"
# Seulement 0.27% des paramètrès sont entraînés !
```

---

#### Fine-tuning vs Prompt Engineering vs RAG

| Approche | Quand l'utiliser | Coût | Données requises |
|----------|-----------------|------|-----------------|
| **Prompt Engineering** | Le modèle est déjà bon avec des instructions claires | Nul | Aucune |
| **Few-shot prompting** | Quelques exemples suffisent dans le prompt | Nul | 5–20 exemples |
| **RAG** (Retrieval-Augmented génération) | Besoin de connaissances actualisées ou propriétaires | Faible | Documents à indexer |
| **Fine-tuning** | Style, format ou domaine très spécifique | Moyen | 100 à 10 000 exemples |
| **Pré-entraînement from scratch** | Domaine totalement nouveau, budget important | Très élevé | Millions d'exemples |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-6"></a>

<details>
<summary><strong>6 — Phase 5 — Évaluation du modèle</strong></summary>

<br/>

### Métriques d'évaluation

#### Pour la classification

| Métrique | Formule | Quand l'utiliser |
|----------|---------|-----------------|
| **Accuracy** | (TP + TN) / Total | Classes équilibrées |
| **précision** | TP / (TP + FP) | Minimiser les faux positifs (spam, pub) |
| **Recall** | TP / (TP + FN) | Minimiser les faux négatifs (cancer, fraude) |
| **F1-Score** | 2 × (P × R) / (P + R) | Équilibre précision/recall |
| **AUC-ROC** | Aire sous la courbe ROC | Comparaison de modèles |

> **Exemple crucial** : pour détecter une maladie grave, le **recall** est prioritaire (on préfère un faux positif à un faux négatif — mieux vaut une fausse alarme qu'un cas manqué).

#### Pour la régression

| Métrique | Description | Sensible aux outliers |
|----------|-------------|----------------------|
| **MAE** | Erreur absolue moyenne | Non |
| **RMSE** | Racine de l'erreur quadratique moyenne | Oui |
| **R²** | Coefficient de détermination (0 à 1) | Moyen |
| **MAPE** | Erreur en pourcentage | Non |

---

### La matrice de confusion

```
                  Prédit Positif    Prédit Négatif
Réel Positif   |  TP (Vrai Pos.)  |  FN (Faux Nég.)  |
Réel Négatif   |  FP (Faux Pos.)  |  TN (Vrai Nég.)  |
```

```python
from sklearn.metrics import confusion_matrix, ConfusionMatrixDisplay
import matplotlib.pyplot as plt

cm = confusion_matrix(y_test, y_pred)
disp = ConfusionMatrixDisplay(confusion_matrix=cm)
disp.plot(cmap="Blues")
plt.title("Matrice de confusion")
plt.show()
```

---

### Biais, équité et limites

Un modèle peut être techniquement performant mais **injuste ou biaisé**.

| Type de biais | Cause | Exemple |
|--------------|-------|---------|
| **Biais de sélection** | Données non représentatives | Modèle entraîné sur des hommes, testé sur des femmes |
| **Biais historique** | Discrimination encodée dans les données | Modèle de recrutement favorisant un genre |
| **Biais de confirmation** | Features corrélées avec des attributs protégés | Code postal comme proxy de l'origine ethnique |
| **Biais d'étiquetage** | Annotations humaines biaisées | Différences d'annotation selon l'annotateur |

**Questions à poser avant de déployer :**
- Le modèle performe-t-il également sur tous les groupes démographiques ?
- Les features utilisées sont-elles justifiables éthiquement ?
- Qui est responsable si le modèle prend une mauvaise décision ?

---

### Overfitting et underfitting

```mermaid
flowchart LR
    subgraph UF["Underfitting"]
        U1["Perf. train : faible\nPerf. test : faible\nLe modèle n'apprend pas"]
    end
    subgraph OK["Bonne généralisation"]
        O1["Perf. train : bonne\nPerf. test : bonne\n✅ Idéal"]
    end
    subgraph OF["Overfitting"]
        F1["Perf. train : excellente\nPerf. test : faible\nLe modèle mémorise"]
    end

    UF --> OK --> OF
```

| Problème | Cause | Solution |
|---------|-------|---------|
| Underfitting | Modèle trop simple, pas assez de features | Modèle plus complexe, plus de features |
| Overfitting | Modèle trop complexe, trop peu de données | Régularisation, dropout, plus de données, cross-validation |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-7"></a>

<details>
<summary><strong>7 — Phase 6 — Déploiement</strong></summary>

<br/>

> Un modèle non déployé n'a aucune valeur. Le déploiement transforme un notebook en solution réelle.

---

### Stratégies de déploiement

| Stratégie | Description | Risque |
|-----------|-------------|--------|
| **Big bang** | Remplacer l'ancien système d'un coup | Élevé |
| **Canary release** | Déployer pour 5–10 % des utilisateurs d'abord | Faible |
| **Blue/Green** | Deux environnements identiques — basculer le trafic | Faible |
| **Shadow mode** | Le nouveau modèle tourne en parallèle sans impacter | Très faible |
| **A/B testing** | Comparer deux modèles sur des groupes d'utilisateurs | Faible |

```mermaid
flowchart LR
    M["Modèle\nentraîné"] --> S["Sérialisation\n(.pkl, .h5, .onnx)"]
    S --> A["API FastAPI\n(endpoint /predict)"]
    A --> D["Déploiement\n(Docker, Cloud, serveur)"]
    D --> U["Utilisateurs\n(app, web, mobile)"]
```

---

### Déploiement avec FastAPI

Voici un exemple complet pour exposer un modèle scikit-learn via FastAPI :

```python
# main.py
import pickle
from fastapi import FastAPI
from pydantic import BaseModel
import numpy as np

app = FastAPI(title="Modèle de classification", version="1.0")

# Charger le modèle au démarrage
with open("model.pkl", "rb") as f:
    model = pickle.load(f)

# Schéma de la requête
class InputData(BaseModel):
    feature1: float
    feature2: float
    feature3: float
    feature4: float

# Schéma de la réponse
class Prediction(BaseModel):
    prediction: int
    probability: float
    label: str

LABELS = {0: "Classe A", 1: "Classe B", 2: "Classe C"}

@app.get("/")
def root():
    return {"message": "API de prédiction opérationnelle"}

@app.post("/predict", response_model=Prediction)
def predict(data: InputData):
    features = np.array([[
        data.feature1,
        data.feature2,
        data.feature3,
        data.feature4
    ]])
    pred = int(model.predict(features)[0])
    proba = float(model.predict_proba(features)[0][pred])
    return Prediction(
        prediction=pred,
        probability=round(proba, 4),
        label=LABELS[pred]
    )
```

```bash
# Sauvegarder le modèle
import pickle
with open("model.pkl", "wb") as f:
    pickle.dump(model, f)

# Lancer l'API
uvicorn main:app --reload

# Tester
# → http://127.0.0.1:8000/docs
```

---

### Conteneurisation avec Docker

```dockerfile
# Dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

```bash
# Construire et lancer
docker build -t mon-modèle-api .
docker run -p 8000:8000 mon-modèle-api
```

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-8"></a>

<details>
<summary><strong>8 — Phase 7 — Monitoring et maintenance</strong></summary>

<br/>

> Un modèle déployé se **dégrade avec le temps**. Les données du monde réel évoluent — le modèle doit suivre.

---

### Data drift et model drift

| Type | Description | Exemple |
|------|-------------|---------|
| **Data drift** | La distribution des données d'entrée change | Les comportements d'achat changent après le COVID |
| **Concept drift** | La relation entre features et target change | Le sens du mot « viral » avant et après 2020 |
| **Model drift** | Les performances du modèle se dégradent | L'accuracy passe de 92 % à 78 % en 6 mois |

```mermaid
flowchart TD
    P["Modèle\nen production"] --> M["Monitoring\ncontinu"]
    M --> D{Dégradation\ndétectée ?}
    D -- Non --> M
    D -- Oui --> A["Alerte\nà l'équipe"]
    A --> AN["Analyse\nde la cause"]
    AN --> C{Type de\nproblème ?}
    C -- Data drift --> RE["Réentraîner\navec nouvelles données"]
    C -- Bug / Erreur --> FIX["Correction\ndu code"]
    C -- Changement métier --> REP1["Redéfinir\nle problème"]
    RE --> P
    FIX --> P
    REP1 --> P
```

---

### Ce qu'il faut monitorer

| Indicateur | Outil |
|-----------|-------|
| **Performance du modèle** (accuracy, F1...) | MLflow, Weights & Biases |
| **Distribution des données d'entrée** | Evidently AI, Whylogs |
| **Temps de réponse de l'API** | Prometheus, Grafana |
| **Taux d'erreur HTTP** | Logs, Sentry |
| **Volume de requêtes** | Prometheus, Datadog |
| **Valeurs aberrantes en entrée** | Règles de validation Pydantic + alertes |

---

### Réentraînement et versioning

```mermaid
flowchart LR
    V1["Modèle v1.0\nen production"] --> NEW["Nouvelles données\ndisponibles"]
    NEW --> TRAIN["Réentraînement\nmodèle v2.0"]
    TRAIN --> EVAL["Évaluation\ncomparative\nv1 vs v2"]
    EVAL --> D{v2 meilleur\nque v1 ?}
    D -- Oui --> DEPLOY["Déploiement\nv2.0"]
    D -- Non --> KEEP["Garder v1.0\nanalyser les causes"]
```

**Bonnes pratiques de versioning :**
- Utiliser **MLflow** ou **DVC** pour tracer chaque version du modèle
- Toujours conserver l'ancien modèle pendant une période de transition
- Documenter les changements de performance entre versions
- Versionner les données d'entraînement au même titre que le code

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-data-lifecycle"></a>

<details>
<summary><strong>9 — Cycle de vie des données — Rétention, archivage et suppression</strong></summary>

<br/>

> Les données ne sont pas éternelles. Elles naissent, sont utilisées, vieillissent et doivent être gérées — voire supprimées. Ce cycle est **indissociable** du cycle de vie du projet IA.

---

### Diagramme complet du cycle de vie des données

```mermaid
flowchart LR
    subgraph création["1️⃣ Création / Collecte"]
        C1["Capteurs, formulaires\nAPIs, logs, scraping"]
    end
    subgraph STOCKAGE["2️⃣ Stockage"]
        S1["Base de données\nData lake / Data warehouse\nCloud storage"]
    end
    subgraph UTILISATION["3️⃣ Utilisation"]
        U1["EDA\nEntraînement\nFine-tuning\nMonitoring"]
    end
    subgraph ARCHIVAGE["4️⃣ Archivage"]
        A1["Données froides\nStockage long terme\nCompression"]
    end
    subgraph SUPPRESSION["5️⃣ Suppression / Discarding"]
        D1["Suppression définitive\nAnonymisation\nPseudonymisation"]
    end

    création --> STOCKAGE --> UTILISATION --> ARCHIVAGE --> SUPPRESSION
    UTILISATION -- "Données obsolètes\nou inutilisables" --> SUPPRESSION
    ARCHIVAGE -- "Données réutilisables\npour réentraînement" --> UTILISATION
```

---

### Où le cycle de vie des données s'insère-t-il dans le projet IA ?

| Phase du projet IA | Action sur les données |
|-------------------|----------------------|
| **Phase 2 — Collecte** | Création, stockage initial, définition de la politique de rétention |
| **Phase 3 — Préparation** | Nettoyage → suppression des doublons et données inutilisables |
| **Phase 4 — Entraînement** | Utilisation active des données ; versioning du dataset |
| **Phase 7 — Monitoring** | Les nouvelles données de production entrent dans le cycle |
| **Fin de projet / réentraînement** | Archivage des vieux datasets, suppression des données expirées |

---

### Politiques de rétention

Une **politique de rétention** définit combien de temps chaque type de données est conservé et sous quelle forme.

| Type de donnée | Durée de rétention typique | Justification |
|----------------|---------------------------|---------------|
| Données d'entraînement brutes | 1 à 5 ans | Permettre le réentraînement et l'audit |
| Données de production (logs) | 6 mois à 2 ans | Debugging, monitoring, drift détection |
| Données personnelles (RGPD) | Durée minimale nécessaire | Obligation légale — droit à l'oubli |
| Modèles entraînés | Aussi longtemps que déployés + 1 an | Reproductibilité, audit |
| Données médicales | 10 à 20 ans (selon pays) | Obligation réglementaire |
| Données financières | 5 à 7 ans | Obligation légale |
| Données de test / validation | Durée du projet + 1 an | Comparaison future de modèles |

---

### Discarding — Quand et comment supprimer les données

Le **discarding** est la décision de **retirer des données du pipeline** — temporairement ou définitivement.

#### Quand supprimer ?

```mermaid
flowchart TD
    Q["Une donnée doit-elle\nêtre supprimée ?"] --> A{Durée de\nrétention\natteinte ?}
    A -- Oui --> DEL["🗑️ Supprimer"]
    A -- Non --> B{Donnée\npersonnelle\nsans consentement ?}
    B -- Oui --> DEL
    B -- Non --> C{Donnée\ncorrompue ou\ninutilisable ?}
    C -- Oui --> D{Récupérable ?}
    D -- Non --> DEL
    D -- Oui --> FIX["🔧 Corriger et\nréintégrer"]
    C -- Non --> E{Donnée\nobsolète ?\n(concept drift)"}
    E -- Oui --> F["📦 Archiver\nou supprimer"]
    E -- Non --> KEEP["✅ Conserver"]
```

#### Les 3 méthodes de discarding

| Méthode | Description | Cas d'usage |
|---------|-------------|------------|
| **Suppression définitive** | Effacement complet et irréversible | Données personnelles, expiration légale |
| **Anonymisation** | Retirer tous les identifiants — la donnée reste utilisable | Réutiliser des données médicales en recherche |
| **Pseudonymisation** | Remplacer les identifiants par des codes — réversible | RGPD, données clients actifs |

```python
import pandas as pd
import hashlib

df = pd.read_csv("users_data.csv")

# Suppression définitive d'une colonne personnelle
df = df.drop(columns=["nom", "prenom", "email"])

# Pseudonymisation — remplacer l'identifiant par un hash
def pseudonymize(value: str) -> str:
    return hashlib.sha256(value.encode()).hexdigest()[:16]

df["user_id"] = df["user_id"].apply(pseudonymize)

# Anonymisation — supprimer la précision géographique
df["code_postal"] = df["code_postal"].astype(str).str[:2]  # garder seulement la province

df.to_csv("users_anonymized.csv", index=False)
```

---

### Données de mauvaise qualité — Discarding dans le pipeline ML

Lors de la préparation des données, certaines lignes doivent être **écartées** du dataset d'entraînement :

| Raison d'écarter | Exemple | Action |
|-----------------|---------|--------|
| Valeurs aberrantes extrêmes | Âge = 999 ans | Supprimer la ligne |
| Données dupliquées | Même transaction enregistrée 2 fois | Dédupliquer |
| Label incorrect | Image d'un chien étiquetée « chat » | Corriger ou supprimer |
| Données du futur (leakage) | Colonne créée après l'événement cible | Retirer la feature |
| Données trop anciennes | Comportements d'achat d'avant 2015 | Archiver, ne pas entraîner dessus |
| Données sous-représentées | 3 exemples d'une classe rare | Augmenter ou écarter selon le contexte |

```python
# Exemple de pipeline de discarding automatique
def clean_and_discard(df: pd.DataFrame) -> pd.DataFrame:

    initial_size = len(df)

    # 1. Supprimer les doublons
    df = df.drop_duplicates()

    # 2. Supprimer les lignes avec trop de valeurs manquantes (> 50 %)
    df = df.dropna(thresh=int(len(df.columns) * 0.5))

    # 3. Écarter les outliers extrêmes (z-score > 4)
    from scipy import stats
    import numpy as np
    numeric_cols = df.select_dtypes(include=[np.number]).columns
    z_scores = np.abs(stats.zscore(df[numeric_cols].fillna(0)))
    df = df[(z_scores < 4).all(axis=1)]

    # 4. Écarter les données trop anciennes (> 3 ans)
    df["date"] = pd.to_datetime(df["date"])
    cutoff = pd.Timestamp.now() - pd.DateOffset(years=3)
    df = df[df["date"] >= cutoff]

    discarded = initial_size - len(df)
    print(f"Données écartées : {discarded} lignes ({discarded/initial_size*100:.1f} %)")
    return df
```

---

### RGPD et obligations légales

Le **Règlement Général sur la Protection des Données** (RGPD / GDPR) impose des règles strictes sur les données personnelles utilisées en IA.

| Principe RGPD | Impact sur le projet IA |
|--------------|------------------------|
| **Minimisation des données** | Collecter uniquement ce qui est nécessaire à la tâche |
| **Limitation de la finalité** | Ne pas réutiliser les données pour un autre usage sans consentement |
| **Limitation de la conservation** | Définir et respecter une durée de rétention |
| **Droit à l'effacement** | Pouvoir supprimer toutes les données d'un utilisateur à sa demande |
| **Portabilité** | Pouvoir exporter les données d'un utilisateur |
| **Transparence** | Expliquer comment les données sont utilisées dans le modèle |

> **En pratique** : avant tout projet IA avec des données personnelles, une **analyse d'impact (AIPD / DPIA)** est souvent obligatoire.

#### Checklist RGPD pour un projet IA

- [ ] Les données personnelles sont-elles nécessaires ou peut-on utiliser des données anonymes ?
- [ ] Le consentement des utilisateurs a-t-il été obtenu ?
- [ ] Une durée de rétention est-elle définie pour chaque type de donnée ?
- [ ] Le droit à l'effacement est-il techniquement possible ?
- [ ] Les données sont-elles stockées dans l'UE ou dans un pays adéquat ?
- [ ] Le modèle prend-il des décisions automatiques impactant des individus ? (Art. 22 RGPD)

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-9"></a>

<details>
<summary><strong>10 — MLOps — Automatiser le cycle de vie</strong></summary>

<br/>

Le **MLOps** (Machine Learning Operations) est l'ensemble des pratiques visant à **automatiser, fiabiliser et industrialiser** le cycle de vie des projets IA, en s'inspirant du DevOps.

```mermaid
flowchart LR
    subgraph DEV["Développement"]
        D1["Code"] --> D2["Données"]
        D2 --> D3["Entraînement"]
    end
    subgraph CI["CI/CD"]
        C1["Tests\nautomatiques"] --> C2["Validation\ndu modèle"]
        C2 --> C3["Packaging\n(Docker)"]
    end
    subgraph PROD["Production"]
        P1["Déploiement\nautomatique"] --> P2["Monitoring"]
        P2 --> P3["Alertes &\nréentraînement"]
    end
    DEV --> CI --> PROD --> DEV
```

---

### Les niveaux de maturité MLOps

| Niveau | Description |
|--------|-------------|
| **Niveau 0** | Tout manuel — notebooks, déploiement à la main |
| **Niveau 1** | Pipeline ML automatisé — réentraînement automatique |
| **Niveau 2** | CI/CD complet — tests, validation et déploiement automatiques |

---

### Outils MLOps courants

| Catégorie | Outil | Usage |
|-----------|-------|-------|
| **Tracking expériences** | MLflow, Weights & Biases | Enregistrer les runs, métriques, modèles |
| **Versioning données** | DVC, LakeFS | Versionner les datasets comme du code |
| **Pipelines ML** | Kubeflow, Metaflow, Airflow | Orchestrer les étapes du pipeline |
| **Registry de modèles** | MLflow Registry, Hugging Face Hub | Stocker et gérer les versions de modèles |
| **Serving** | FastAPI, TF Serving, BentoML | Exposer les modèles comme APIs |
| **Monitoring** | Evidently, Grafana, Prometheus | Surveiller les performances en production |
| **Conteneurs** | Docker, Kubernetes | Packager et scaler les Déploiements |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-10"></a>

<details>
<summary><strong>10 — Étude de cas — Projet complet de A à Z</strong></summary>

<br/>

### Contexte

Une banque veut détecter les transactions frauduleuses en temps réel. Voici comment appliquer les 7 phases.

---

### Phase 1 — Définition du problème

| Élément | Détail |
|---------|--------|
| **Problème métier** | 0,1 % des transactions sont frauduleuses → perte de 5 M$/an |
| **Objectif IA** | Classifier chaque transaction : légitime ou frauduleuse |
| **Métrique clé** | Recall ≥ 95 % sur la classe fraude (on ne veut pas manquer de fraudes) |
| **Contrainte** | Temps de réponse < 100 ms, RGPD, pas d'accès aux noms clients |
| **Décision** | ✅ Projet IA justifié |

---

### Phase 2 — Collecte des données

- 5 millions de transactions sur 2 ans
- Features : montant, heure, pays, type de marchand, historique client
- 0,1 % de fraudes → **classes très déséquilibrées**

---

### Phase 3 — Préparation

- Suppression des doublons
- Imputation de 2 % de valeurs manquantes
- Encodage des pays et types de marchands
- Création de features : `écart_par_rapport_à_la_moyenne_client`, `transactions_dans_les_10_minutes`
- Rééchantillonnage : SMOTE pour équilibrer les classes

---

### Phase 4 — Modélisation

- Modèles testés : Logistic Regression, Random Forest, XGBoost
- **XGBoost** sélectionné : meilleur F1 et recall sur la classe fraude
- GridSearchCV pour optimiser les hyperparamètres

---

### Phase 5 — Évaluation

| Modèle | Accuracy | Recall (fraude) | F1 (fraude) |
|--------|----------|-----------------|-------------|
| Logistic Regression | 97,2 % | 71 % | 0,68 |
| Random Forest | 99,1 % | 88 % | 0,85 |
| **XGBoost** | **99,4 %** | **96 %** | **0,91** |

✅ Critère de recall ≥ 95 % atteint.

---

### Phase 6 — Déploiement

- Modèle sérialisé avec `pickle`
- API FastAPI : endpoint `POST /predict`
- Conteneurisé avec Docker
- Déployé sur AWS ECS
- Canary release : 5 % du trafic d'abord

---

### Phase 7 — Monitoring

- Dashboard Grafana : temps de réponse, taux de fraude détectée
- Alerte si recall < 90 % sur une fenêtre de 7 jours
- Réentraînement mensuel avec les nouvelles transactions

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-11"></a>

<details>
<summary><strong>11 — Travail pratique — Planifier un projet IA</strong></summary>

<br/>

### Objectif

Appliquer les 7 phases du cycle de vie à un **projet IA de votre choix**, sans coder — uniquement en planifiant et en documentant chaque étape.

---

### Sujets proposés (ou proposez le vôtre)

| # | Sujet | Type de problème |
|---|-------|-----------------|
| A | Prédire si un étudiant va décrocher avant la fin du semestre | Classification |
| B | Estimer le prix d'un appartement à Montréal | Régression |
| C | Recommander des cours à un étudiant selon son profil | Recommandation |
| D | Détecter des commentaires toxiques sur une plateforme scolaire | NLP / Classification |
| E | Classer automatiquement des images de maladies de plantes | Computer Vision |
| F | Prédire la consommation énergétique d'un bâtiment | Régression |

---

### Livrables à remettre

Remplissez le **gabarit ci-dessous** pour votre projet choisi.

```
========================================
PLAN DE PROJET IA — GABARIT
========================================

Nom du projet : _______________
Étudiant(e) : _______________
Date : _______________

PHASE 1 — DÉFINITION DU PROBLÈME
- Problème métier : 
- Objectif IA (type de tâche) : 
- Métrique(s) de succès technique(s) : 
- Métrique(s) de succès métier : 
- Contraintes identifiées : 

PHASE 2 — COLLECTE DES DONNÉES
- Sources de données envisagées : 
- Volume estimé : 
- Format des données (CSV, images, texte...) : 
- Problèmes anticipés (déséquilibre, bruit, RGPD...) : 

PHASE 3 — PRÉPARATION DES DONNÉES
- Nettoyage prévu : 
- Features à créer (feature engineering) : 
- Découpages train/validation/test (%) : 

PHASE 4 — MODÉLISATION
- Algorithme(s) envisagé(s) : 
- Justification du choix : 
- Hyperparamètrès à explorer : 

PHASE 5 — ÉVALUATION
- Métriques choisies et justification : 
- Risques de biais identifiés : 

PHASE 6 — DÉPLOIEMENT
- Format de déploiement (API, app, pipeline...) : 
- Stratégie de déploiement : 
- Stack technique envisagée : 

PHASE 7 — MONITORING
- Ce que vous monitorez : 
- Fréquence de réentraînement envisagée : 
- Critère de déclenchement du réentraînement : 

RISQUES GLOBAUX DU PROJET
1. 
2. 
3. 
========================================
```

---

### Critères d'évaluation

| Critère | Points |
|---------|--------|
| Cohérence entre le problème et les choix techniques | 35 % |
| Justification des métriques choisies | 25 % |
| Anticipation des risques et biais | 20 % |
| Clarté et complétude du gabarit | 20 % |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>
