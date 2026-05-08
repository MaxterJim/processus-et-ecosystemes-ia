<a id="top"></a>

# Correction complète du Mini-lab 1 - Application de visualisation de données CSV avec Streamlit

## Cas utilisé : fichier CSV Yahoo Finance

## Table des matières

| #  | Section                                                              |
| -- | -------------------------------------------------------------------- |
| 1  | [Objectif de la correction](#section-1)                              |
| 2  | [Structure attendue du fichier Yahoo Finance](#section-2)            |
| 3  | [Structure finale des fichiers à remettre](#section-3)               |
| 4  | [Code complet du fichier `app.py`](#section-4)                       |
| 5  | [Code du fichier `requirements.txt`](#section-5)                     |
| 6  | [Explication complète du code](#section-6)                           |
| 7  | [Fonctionnalités validées par la correction](#section-7)             |
| 8  | [Gestion des erreurs](#section-8)                                    |
| 9  | [Commande pour lancer l’application](#section-9)                     |
| 10 | [Version locale avec environnement virtuel Python 3.12](#section-10) |
| 11 | [Version Docker avec Dockerfile](#section-11)                        |
| 12 | [Version Docker Compose](#section-12)                                |
| 13 | [Structure finale complète du projet](#section-13)                   |
| 14 | [Version simple sans amélioration Yahoo Finance](#section-14)        |
| 15 | [Résumé final](#section-15)                                          |

---

<a id="section-1"></a>

<details open>
<summary><strong>1 — Objectif de la correction</strong></summary>

<br/>

Cette correction présente une version complète et fonctionnelle de l’application demandée dans le mini-lab 2. L’application est développée avec **Streamlit** et permet de charger un fichier CSV, d’afficher les données et de générer un graphique à partir d’une colonne numérique.

La correction est adaptée à un fichier CSV provenant de **Yahoo Finance**. Ce type de fichier contient généralement des données boursières avec des colonnes comme `Date`, `Open`, `High`, `Low`, `Close`, `Adj Close` et `Volume`.

L’application doit permettre à l’utilisateur de charger le fichier CSV depuis la barre latérale, de voir le contenu du fichier, de sélectionner une colonne numérique et d’afficher un graphique en ligne. Elle doit également gérer les erreurs courantes, par exemple lorsqu’aucun fichier n’est chargé, lorsque le fichier est vide, lorsque le fichier est mal formaté ou lorsqu’il ne contient aucune colonne numérique.

L’objectif de cette correction n’est pas seulement de fournir un code qui fonctionne. L’objectif est aussi de montrer une manière propre, claire et professionnelle d’organiser une petite application Streamlit.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-2"></a>

<details>
<summary><strong>2 — Structure attendue du fichier Yahoo Finance</strong></summary>

<br/>

Un fichier CSV exporté depuis Yahoo Finance contient généralement des données historiques d’un actif financier. Chaque ligne représente une journée, une semaine ou une période de cotation. Chaque colonne représente une information financière.

La structure habituelle est la suivante :

| Colonne       | Signification                                                                         |
| ------------- | ------------------------------------------------------------------------------------- |
| **Date**      | Date de la donnée financière.                                                         |
| **Open**      | Prix d’ouverture de l’actif au début de la période.                                   |
| **High**      | Prix le plus élevé atteint pendant la période.                                        |
| **Low**       | Prix le plus bas atteint pendant la période.                                          |
| **Close**     | Prix de clôture à la fin de la période.                                               |
| **Adj Close** | Prix de clôture ajusté, généralement corrigé selon les dividendes ou fractionnements. |
| **Volume**    | Nombre d’actions ou d’unités échangées pendant la période.                            |

Dans ce mini-lab, les colonnes numériques utilisables pour le graphique sont généralement :

```text
Open
High
Low
Close
Adj Close
Volume
```

La colonne `Date` n’est pas une colonne numérique. Elle sert plutôt d’axe temporel. Dans la correction améliorée, cette colonne est convertie en format date et utilisée comme index du graphique. Cela permet d’obtenir une visualisation plus logique, car le graphique suit l’évolution des valeurs dans le temps.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-3"></a>

<details>
<summary><strong>3 — Structure finale des fichiers à remettre</strong></summary>

<br/>

La structure recommandée pour le projet est la suivante :

```text
mini_lab_2_streamlit_yahoo_finance/
│
├── app.py
├── requirements.txt
└── README.md        facultatif
```

Le fichier le plus important est `app.py`. Il contient le code principal de l’application Streamlit.

Le fichier `requirements.txt` contient les bibliothèques nécessaires pour exécuter l’application. Pour cette correction, les deux bibliothèques principales sont `streamlit` et `pandas`.

Le fichier `README.md` est facultatif, mais il peut être ajouté pour expliquer comment lancer l’application.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-4"></a>

<details>
<summary><strong>4 — Code complet du fichier <code>app.py</code></strong></summary>

<br/>

Voici la correction complète du fichier `app.py`.

```python
import streamlit as st
import pandas as pd

# ------------------------------------------------------------
# Configuration générale de la page Streamlit
# ------------------------------------------------------------
st.set_page_config(
    page_title="Visualisation de données CSV",
    page_icon="📊",
    layout="wide"
)

# ------------------------------------------------------------
# Titre principal de l'application
# ------------------------------------------------------------
st.title("Application de Visualisation de Données CSV")

st.write(
    "Cette application permet de charger un fichier CSV, "
    "d'afficher les données et de générer un graphique à partir "
    "d'une colonne numérique."
)

# ------------------------------------------------------------
# Chargement du fichier CSV depuis la barre latérale
# ------------------------------------------------------------
st.sidebar.header("Chargement du fichier")

uploaded_file = st.sidebar.file_uploader(
    "Veuillez charger un fichier CSV",
    type=["csv"]
)

# ------------------------------------------------------------
# Message affiché si aucun fichier n'est chargé
# ------------------------------------------------------------
if uploaded_file is None:
    st.info("Veuillez charger un fichier CSV depuis la barre latérale pour commencer.")

# ------------------------------------------------------------
# Traitement du fichier si un fichier CSV est chargé
# ------------------------------------------------------------
else:
    try:
        # ------------------------------------------------------------
        # Lecture du fichier CSV avec Pandas
        # ------------------------------------------------------------
        df = pd.read_csv(uploaded_file)

        # ------------------------------------------------------------
        # Vérification si le fichier est vide
        # ------------------------------------------------------------
        if df.empty:
            st.warning("Le fichier CSV est vide. Veuillez charger un fichier contenant des données.")

        else:
            # ------------------------------------------------------------
            # Affichage d'informations générales sur le fichier
            # ------------------------------------------------------------
            st.success("Le fichier CSV a été chargé avec succès.")

            st.subheader("Aperçu des données")
            st.dataframe(df)

            st.subheader("Informations générales")

            col1, col2, col3 = st.columns(3)

            with col1:
                st.metric("Nombre de lignes", df.shape[0])

            with col2:
                st.metric("Nombre de colonnes", df.shape[1])

            with col3:
                st.metric("Colonnes numériques", df.select_dtypes(include=["number"]).shape[1])

            # ------------------------------------------------------------
            # Traitement particulier pour les fichiers Yahoo Finance
            # ------------------------------------------------------------
            # Si une colonne Date existe, on tente de la convertir en date.
            # Cela permet d'utiliser les dates comme axe du graphique.
            # ------------------------------------------------------------
            if "Date" in df.columns:
                df["Date"] = pd.to_datetime(df["Date"], errors="coerce")
                df = df.dropna(subset=["Date"])
                df = df.sort_values("Date")
                df = df.set_index("Date")

                st.info(
                    "La colonne 'Date' a été détectée. "
                    "Elle sera utilisée comme axe temporel pour le graphique."
                )

            # ------------------------------------------------------------
            # Sélection des colonnes numériques
            # ------------------------------------------------------------
            numeric_columns = df.select_dtypes(include=["number"]).columns.tolist()

            # ------------------------------------------------------------
            # Vérification : aucune colonne numérique trouvée
            # ------------------------------------------------------------
            if len(numeric_columns) == 0:
                st.warning(
                    "Le fichier CSV ne contient aucune colonne numérique. "
                    "Il est donc impossible de générer un graphique en ligne."
                )

            else:
                # ------------------------------------------------------------
                # Sélection de la colonne numérique à visualiser
                # ------------------------------------------------------------
                st.subheader("Sélection de la colonne à visualiser")

                selected_column = st.selectbox(
                    "Choisissez une colonne numérique pour générer le graphique :",
                    numeric_columns
                )

                # ------------------------------------------------------------
                # Affichage du graphique
                # ------------------------------------------------------------
                st.subheader(f"Graphique de la colonne : {selected_column}")
                st.line_chart(df[selected_column])

                # ------------------------------------------------------------
                # Statistiques simples sur la colonne sélectionnée
                # ------------------------------------------------------------
                st.subheader("Statistiques de la colonne sélectionnée")

                stat1, stat2, stat3, stat4 = st.columns(4)

                with stat1:
                    st.metric("Minimum", round(df[selected_column].min(), 2))

                with stat2:
                    st.metric("Maximum", round(df[selected_column].max(), 2))

                with stat3:
                    st.metric("Moyenne", round(df[selected_column].mean(), 2))

                with stat4:
                    st.metric("Valeurs manquantes", int(df[selected_column].isna().sum()))

    # ------------------------------------------------------------
    # Gestion des erreurs lors de la lecture ou du traitement du CSV
    # ------------------------------------------------------------
    except pd.errors.EmptyDataError:
        st.error("Le fichier chargé est vide ou ne contient aucune donnée lisible.")

    except pd.errors.ParserError:
        st.error("Le fichier chargé ne semble pas être un CSV correctement structuré.")

    except Exception as error:
        st.error("Une erreur est survenue lors du traitement du fichier CSV.")
        st.write("Détail de l'erreur :", error)
```

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-5"></a>

<details>
<summary><strong>5 — Code du fichier <code>requirements.txt</code></strong></summary>

<br/>

Le fichier `requirements.txt` doit contenir les bibliothèques nécessaires pour exécuter l’application.

```text
streamlit
pandas
```

Ce fichier permet d’installer rapidement les dépendances du projet avec la commande suivante :

```bash
pip install -r requirements.txt
```

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-6"></a>

<details>
<summary><strong>6 — Explication complète du code</strong></summary>

<br/>

Le programme commence par importer les deux bibliothèques nécessaires. La bibliothèque `streamlit` sert à créer l’interface web. La bibliothèque `pandas` sert à lire et manipuler le fichier CSV.

```python
import streamlit as st
import pandas as pd
```

La fonction `st.set_page_config` permet de configurer l’apparence générale de la page. Elle permet de définir le titre de l’onglet, l’icône et la largeur de l’affichage.

```python
st.set_page_config(
    page_title="Visualisation de données CSV",
    page_icon="📊",
    layout="wide"
)
```

La fonction `st.title` affiche le titre principal de l’application. Ce titre permet à l’utilisateur de comprendre immédiatement le but de l’application.

```python
st.title("Application de Visualisation de Données CSV")
```

Le fichier CSV est chargé avec `st.sidebar.file_uploader`. L’utilisation de `st.sidebar` place le bouton de chargement dans la barre latérale. Cela rend l’interface plus propre, car la partie centrale de la page reste disponible pour afficher les données et le graphique.

```python
uploaded_file = st.sidebar.file_uploader(
    "Veuillez charger un fichier CSV",
    type=["csv"]
)
```

Le paramètre `type=["csv"]` limite le chargement aux fichiers CSV. Cela évite que l’utilisateur charge un fichier qui n’est pas adapté à l’application.

Ensuite, le programme vérifie si un fichier a été chargé. Si aucun fichier n’est chargé, l’application affiche un message d’information.

```python
if uploaded_file is None:
    st.info("Veuillez charger un fichier CSV depuis la barre latérale pour commencer.")
```

Si un fichier est chargé, le programme essaie de le lire avec `pd.read_csv`. Cette opération est placée dans un bloc `try/except`, car la lecture peut échouer si le fichier est vide, mal structuré ou incorrect.

```python
try:
    df = pd.read_csv(uploaded_file)
```

Après la lecture, le programme vérifie si le tableau est vide. Un fichier vide ne peut pas être utilisé pour afficher des données ou générer un graphique.

```python
if df.empty:
    st.warning("Le fichier CSV est vide. Veuillez charger un fichier contenant des données.")
```

Si le fichier contient des données, l’application affiche un message de succès et présente le tableau avec `st.dataframe`.

```python
st.success("Le fichier CSV a été chargé avec succès.")
st.dataframe(df)
```

Le programme affiche aussi quelques informations générales : nombre de lignes, nombre de colonnes et nombre de colonnes numériques. Ces informations aident l’utilisateur à comprendre rapidement la structure du fichier chargé.

Pour les fichiers Yahoo Finance, la colonne `Date` est très importante. Elle représente l’axe temporel. Si cette colonne existe, le programme la convertit en type date, trie les données et l’utilise comme index.

```python
if "Date" in df.columns:
    df["Date"] = pd.to_datetime(df["Date"], errors="coerce")
    df = df.dropna(subset=["Date"])
    df = df.sort_values("Date")
    df = df.set_index("Date")
```

Cette partie rend le graphique plus logique, car les valeurs seront affichées selon les dates du fichier.

Ensuite, le programme sélectionne les colonnes numériques avec `select_dtypes`. Cette méthode permet de garder uniquement les colonnes contenant des nombres.

```python
numeric_columns = df.select_dtypes(include=["number"]).columns.tolist()
```

Si aucune colonne numérique n’est trouvée, le programme affiche un message d’avertissement. Cela évite que l’application plante ou affiche une liste vide.

```python
if len(numeric_columns) == 0:
    st.warning("Le fichier CSV ne contient aucune colonne numérique.")
```

Si des colonnes numériques existent, l’utilisateur peut choisir une colonne dans une liste déroulante.

```python
selected_column = st.selectbox(
    "Choisissez une colonne numérique pour générer le graphique :",
    numeric_columns
)
```

Le graphique est ensuite généré avec `st.line_chart`. Cette fonction crée automatiquement un graphique en ligne à partir de la colonne sélectionnée.

```python
st.line_chart(df[selected_column])
```

Enfin, le programme affiche quelques statistiques simples sur la colonne sélectionnée : minimum, maximum, moyenne et nombre de valeurs manquantes. Ces statistiques ne sont pas obligatoires dans l’énoncé de base, mais elles améliorent l’application et montrent une meilleure compréhension des données.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-7"></a>

<details>
<summary><strong>7 — Fonctionnalités validées par la correction</strong></summary>

<br/>

La correction valide toutes les fonctionnalités demandées dans l’énoncé du mini-lab.

| Fonctionnalité demandée                                      | Présente dans la correction | Explication                                                  |
| ------------------------------------------------------------ | --------------------------- | ------------------------------------------------------------ |
| **Afficher un titre**                                        | Oui                         | Le titre est affiché avec `st.title`.                        |
| **Charger un fichier CSV**                                   | Oui                         | Le fichier est chargé avec `st.sidebar.file_uploader`.       |
| **Limiter le type de fichier à CSV**                         | Oui                         | Le paramètre `type=["csv"]` est utilisé.                     |
| **Lire le fichier CSV**                                      | Oui                         | Le fichier est lu avec `pd.read_csv`.                        |
| **Afficher les données**                                     | Oui                         | Les données sont affichées avec `st.dataframe`.              |
| **Détecter les colonnes numériques**                         | Oui                         | Les colonnes numériques sont détectées avec `select_dtypes`. |
| **Sélectionner une colonne numérique**                       | Oui                         | La sélection se fait avec `st.selectbox`.                    |
| **Générer un graphique en ligne**                            | Oui                         | Le graphique est généré avec `st.line_chart`.                |
| **Afficher un message si aucun fichier n’est chargé**        | Oui                         | Un message `st.info` est affiché.                            |
| **Gérer les erreurs de lecture**                             | Oui                         | Le code utilise `try/except`.                                |
| **Afficher un message si aucune colonne numérique n’existe** | Oui                         | Un message `st.warning` est affiché.                         |
| **Bonus : chargement depuis la barre latérale**              | Oui                         | Le fichier est chargé depuis `st.sidebar`.                   |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-8"></a>

<details>
<summary><strong>8 — Gestion des erreurs</strong></summary>

<br/>

La gestion des erreurs est une partie importante de cette correction. Une application Streamlit ne doit pas afficher une erreur technique difficile à comprendre pour l’utilisateur. Elle doit plutôt afficher un message clair.

| Cas particulier              | Traitement dans la correction                                                                    |
| ---------------------------- | ------------------------------------------------------------------------------------------------ |
| **Aucun fichier chargé**     | L’application affiche un message demandant de charger un fichier CSV.                            |
| **Fichier vide**             | L’application affiche un avertissement indiquant que le fichier est vide.                        |
| **Fichier mal structuré**    | L’application affiche un message d’erreur indiquant que le CSV n’est pas correctement structuré. |
| **Aucune colonne numérique** | L’application explique qu’il est impossible de générer un graphique.                             |
| **Erreur inattendue**        | L’application affiche un message d’erreur général et le détail de l’erreur.                      |

Le bloc `try/except` est utilisé pour empêcher l’application de planter. Cela permet de garder une interface propre même si le fichier chargé pose problème.

```python
try:
    df = pd.read_csv(uploaded_file)
except Exception as error:
    st.error("Une erreur est survenue lors du traitement du fichier CSV.")
    st.write("Détail de l'erreur :", error)
```

Dans une application professionnelle, il est important de guider l’utilisateur. Un message clair aide l’utilisateur à comprendre le problème et à le corriger.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-9"></a>

<details>
<summary><strong>9 — Commande pour lancer l’application</strong></summary>

<br/>

Pour lancer l’application, il faut ouvrir un terminal dans le dossier du projet et exécuter la commande suivante :

```bash
streamlit run app.py
```

Si les bibliothèques ne sont pas encore installées, il faut d’abord exécuter :

```bash
pip install -r requirements.txt
```

Une fois l’application lancée, Streamlit ouvre une page web locale. L’utilisateur peut alors charger son fichier CSV depuis la barre latérale.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-10"></a>

<details>
<summary><strong>10 — Version locale avec environnement virtuel Python 3.12</strong></summary>

<br/>

Cette version explique comment exécuter l’application localement avec un environnement virtuel Python 3.12. Cette méthode est utile lorsque l’on veut développer, tester et corriger l’application directement sur son ordinateur, sans passer par Docker.

L’environnement virtuel permet d’isoler les bibliothèques du projet. Cela évite d’installer Streamlit et Pandas dans l’environnement Python global de la machine. Chaque projet peut ainsi avoir ses propres dépendances, sans créer de conflit avec d’autres projets Python.

### Structure attendue pour la version locale

```text
mini_lab_2_streamlit_yahoo_finance/
│
├── app.py
├── requirements.txt
└── README.md        facultatif
```

### Fichier `requirements.txt`

Le fichier `requirements.txt` doit contenir les bibliothèques nécessaires au projet.

```text
streamlit
pandas
```

### Création de l’environnement virtuel avec Python 3.12

Sur Windows, ouvrez PowerShell dans le dossier du projet, puis exécutez la commande suivante :

```powershell
py -3.12 -m venv .venv
```

Cette commande crée un dossier `.venv`. Ce dossier contient l’environnement Python isolé du projet.

### Activation de l’environnement virtuel sur Windows PowerShell

Toujours dans PowerShell, activez l’environnement virtuel avec la commande suivante :

```powershell
./.venv/Scripts/Activate.ps1
```

Lorsque l’environnement est activé, le terminal affiche généralement `(.venv)` au début de la ligne. Cela signifie que les commandes Python et pip utilisent maintenant l’environnement du projet.

### Correction possible si PowerShell bloque l’activation

Si PowerShell refuse d’exécuter le script d’activation, il peut afficher un message lié à la politique d’exécution. Dans ce cas, vous pouvez autoriser temporairement l’exécution des scripts pour la session courante.

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

Ensuite, relancez l’activation :

```powershell
./.venv/Scripts/Activate.ps1
```

Cette modification est temporaire. Elle s’applique seulement à la fenêtre PowerShell actuelle.

### Installation des dépendances

Une fois l’environnement virtuel activé, installez les bibliothèques du projet :

```powershell
python -m pip install --upgrade pip
pip install -r requirements.txt
```

Cette commande installe Streamlit et Pandas dans l’environnement virtuel du projet.

### Lancement de l’application

Pour lancer l’application Streamlit, utilisez la commande suivante :

```powershell
streamlit run app.py
```

Après l’exécution de cette commande, Streamlit ouvre généralement l’application dans le navigateur. Si le navigateur ne s’ouvre pas automatiquement, l’adresse locale est souvent affichée dans le terminal.

```text
http://localhost:8501
```

### Arrêt de l’application

Pour arrêter l’application, retournez dans le terminal et utilisez :

```powershell
CTRL + C
```

### Désactivation de l’environnement virtuel

Lorsque vous avez terminé, vous pouvez désactiver l’environnement virtuel avec :

```powershell
deactivate
```

### Résumé des commandes Windows PowerShell

```powershell
# 1. Créer l'environnement virtuel avec Python 3.12
py -3.12 -m venv .venv

# 2. Autoriser temporairement l'activation si PowerShell bloque le script
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# 3. Activer l'environnement virtuel
./.venv/Scripts/Activate.ps1

# 4. Mettre pip à jour
python -m pip install --upgrade pip

# 5. Installer les dépendances
pip install -r requirements.txt

# 6. Lancer l'application
streamlit run app.py

# 7. Arrêter l'application avec CTRL + C

# 8. Désactiver l'environnement virtuel
deactivate
```

### Résumé des commandes macOS ou Linux

```bash
# 1. Créer l'environnement virtuel avec Python 3.12
python3.12 -m venv .venv

# 2. Activer l'environnement virtuel
source .venv/bin/activate

# 3. Mettre pip à jour
python -m pip install --upgrade pip

# 4. Installer les dépendances
pip install -r requirements.txt

# 5. Lancer l'application
streamlit run app.py

# 6. Arrêter l'application avec CTRL + C

# 7. Désactiver l'environnement virtuel
deactivate
```

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-11"></a>

<details>
<summary><strong>11 — Version Docker avec Dockerfile</strong></summary>

<br/>

La version Docker permet d’exécuter l’application dans un conteneur. Cette méthode est utile lorsque l’on veut éviter les problèmes liés aux différences entre les machines. Par exemple, l’application peut fonctionner sur l’ordinateur d’un étudiant, sur l’ordinateur de l’enseignant ou sur un serveur avec le même environnement.

Avec Docker, on décrit l’environnement dans un fichier appelé `Dockerfile`. Ce fichier indique quelle version de Python utiliser, quelles dépendances installer et quelle commande exécuter pour lancer l’application.

### Structure attendue pour la version Docker

```text
mini_lab_2_streamlit_yahoo_finance/
│
├── app.py
├── requirements.txt
├── Dockerfile
└── .dockerignore
```

### Fichier `Dockerfile`

Créez un fichier nommé exactement `Dockerfile`, sans extension.

```dockerfile
# Image officielle Python 3.12 en version légère
FROM python:3.12-slim

# Empêche Python de créer des fichiers .pyc inutiles
ENV PYTHONDONTWRITEBYTECODE=1

# Force l'affichage immédiat des logs dans le terminal
ENV PYTHONUNBUFFERED=1

# Définit le dossier de travail dans le conteneur
WORKDIR /app

# Copie le fichier des dépendances dans le conteneur
COPY requirements.txt .

# Met pip à jour et installe les dépendances du projet
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copie le code de l'application dans le conteneur
COPY app.py .

# Streamlit utilise le port 8501 par défaut
EXPOSE 8501

# Commande exécutée au démarrage du conteneur
CMD ["streamlit", "run", "app.py", "--server.address=0.0.0.0", "--server.port=8501"]
```

### Fichier `.dockerignore`

Le fichier `.dockerignore` permet d’éviter de copier des fichiers inutiles dans l’image Docker.

```text
.venv
__pycache__
*.pyc
*.pyo
*.pyd
.git
.gitignore
README.md
.env
.DS_Store
```

### Construction de l’image Docker

Dans le dossier du projet, exécutez la commande suivante :

```bash
docker build -t mini-lab-2-streamlit .
```

Cette commande construit une image Docker nommée `mini-lab-2-streamlit`.

### Lancement du conteneur

Après la construction de l’image, lancez le conteneur avec :

```bash
docker run --rm -p 8501:8501 mini-lab-2-streamlit
```

Le paramètre `-p 8501:8501` relie le port 8501 du conteneur au port 8501 de votre machine. Cela permet d’ouvrir l’application dans le navigateur.

L’application est ensuite accessible à l’adresse suivante :

```text
http://localhost:8501
```

### Arrêt du conteneur

Pour arrêter l’application, retournez dans le terminal et utilisez :

```bash
CTRL + C
```

Comme la commande utilise `--rm`, le conteneur est supprimé automatiquement après son arrêt. L’image Docker reste disponible et peut être réutilisée.

### Résumé des commandes Docker

```bash
# 1. Construire l'image Docker
docker build -t mini-lab-2-streamlit .

# 2. Lancer le conteneur
docker run --rm -p 8501:8501 mini-lab-2-streamlit

# 3. Ouvrir l'application dans le navigateur
# http://localhost:8501

# 4. Arrêter avec CTRL + C
```

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-12"></a>

<details>
<summary><strong>12 — Version Docker Compose</strong></summary>

<br/>

Docker Compose permet de lancer l’application avec un fichier de configuration appelé `docker-compose.yml`. Cette méthode est pratique, car elle évite d’écrire une longue commande `docker run` à chaque lancement.

Dans ce mini-lab, Docker Compose sert à construire l’image à partir du `Dockerfile`, à lancer le conteneur et à exposer le port 8501.

### Structure attendue pour la version Docker Compose

```text
mini_lab_2_streamlit_yahoo_finance/
│
├── app.py
├── requirements.txt
├── Dockerfile
├── docker-compose.yml
└── .dockerignore
```

### Fichier `docker-compose.yml`

Créez un fichier nommé `docker-compose.yml`.

```yaml
services:
  streamlit-app:
    build: .
    container_name: mini-lab-2-streamlit
    ports:
      - "8501:8501"
    volumes:
      - .:/app
    command: streamlit run app.py --server.address=0.0.0.0 --server.port=8501
```

### Explication du fichier Docker Compose

| Élément          | Explication                                                                                                                         |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `services`       | Définit les services à lancer. Ici, il y a un seul service : l’application Streamlit.                                               |
| `streamlit-app`  | Nom du service dans Docker Compose.                                                                                                 |
| `build: .`       | Demande à Docker Compose de construire l’image à partir du `Dockerfile` présent dans le dossier courant.                            |
| `container_name` | Donne un nom clair au conteneur.                                                                                                    |
| `ports`          | Expose le port 8501 pour accéder à Streamlit depuis le navigateur.                                                                  |
| `volumes`        | Synchronise le dossier local avec le dossier `/app` dans le conteneur. Cela permet de voir les changements du code plus facilement. |
| `command`        | Lance Streamlit dans le conteneur.                                                                                                  |

### Lancement avec Docker Compose

Dans le dossier du projet, exécutez :

```bash
docker compose up --build
```

Cette commande construit l’image si nécessaire, puis lance l’application.

L’application est accessible à l’adresse suivante :

```text
http://localhost:8501
```

### Lancement en arrière-plan

Pour lancer l’application en arrière-plan, utilisez :

```bash
docker compose up -d --build
```

Le paramètre `-d` signifie que le conteneur continue à fonctionner en arrière-plan.

### Arrêt avec Docker Compose

Pour arrêter l’application, exécutez :

```bash
docker compose down
```

Cette commande arrête et supprime le conteneur, mais elle ne supprime pas les fichiers du projet.

### Voir les logs de l’application

Si l’application tourne en arrière-plan, vous pouvez afficher les logs avec :

```bash
docker compose logs -f
```

### Résumé des commandes Docker Compose

```bash
# 1. Construire et lancer l'application
docker compose up --build

# 2. Ouvrir l'application
# http://localhost:8501

# 3. Lancer en arrière-plan
docker compose up -d --build

# 4. Voir les logs
docker compose logs -f

# 5. Arrêter et supprimer le conteneur
docker compose down
```

### Remarque importante

Si vous modifiez le fichier `requirements.txt` ou le `Dockerfile`, il faut reconstruire l’image avec `--build`.

```bash
docker compose up --build
```

Si vous modifiez seulement `app.py`, le volume `.:/app` permet généralement de voir les changements sans reconstruire complètement l’image. Il peut cependant être nécessaire d’arrêter et de relancer le conteneur selon le comportement observé.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-13"></a>

<details>
<summary><strong>13 — Structure finale complète du projet</strong></summary>

<br/>

Voici la structure finale recommandée si vous voulez fournir les deux versions : la version locale avec environnement virtuel Python 3.12 et la version Docker.

```text
mini_lab_2_streamlit_yahoo_finance/
│
├── app.py
├── requirements.txt
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
└── README.md
```

### Rôle de chaque fichier

| Fichier              | Rôle                                                           |
| -------------------- | -------------------------------------------------------------- |
| `app.py`             | Contient le code principal de l’application Streamlit.         |
| `requirements.txt`   | Contient les bibliothèques Python nécessaires.                 |
| `Dockerfile`         | Décrit comment construire l’image Docker de l’application.     |
| `docker-compose.yml` | Permet de lancer l’application avec Docker Compose.            |
| `.dockerignore`      | Exclut les fichiers inutiles de l’image Docker.                |
| `README.md`          | Explique comment lancer l’application en local ou avec Docker. |

### Exemple de contenu pour `README.md`

```text
# Mini-lab 2 — Application Streamlit CSV

Cette application permet de charger un fichier CSV, d'afficher les données et de générer un graphique à partir d'une colonne numérique.

## Version locale avec Python 3.12

py -3.12 -m venv .venv
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
./.venv/Scripts/Activate.ps1
python -m pip install --upgrade pip
pip install -r requirements.txt
streamlit run app.py

## Version Docker

docker build -t mini-lab-2-streamlit .
docker run --rm -p 8501:8501 mini-lab-2-streamlit

## Version Docker Compose

docker compose up --build

Application disponible sur :
http://localhost:8501
```

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-14"></a>

<details>
<summary><strong>14 — Version simple sans amélioration Yahoo Finance</strong></summary>

<br/>

La version précédente est améliorée pour les fichiers Yahoo Finance, car elle utilise la colonne `Date` comme axe temporel. Voici une version plus simple, qui répond aussi à l’énoncé, mais sans traitement particulier de la colonne `Date`.

```python
import streamlit as st
import pandas as pd

st.title("Application de Visualisation de Données CSV")

uploaded_file = st.sidebar.file_uploader(
    "Veuillez charger un fichier CSV",
    type=["csv"]
)

if uploaded_file is None:
    st.info("Veuillez charger un fichier CSV pour commencer.")

else:
    try:
        df = pd.read_csv(uploaded_file)

        st.subheader("Aperçu des données")
        st.dataframe(df)

        numeric_columns = df.select_dtypes(include=["number"]).columns.tolist()

        if len(numeric_columns) == 0:
            st.warning("Le fichier ne contient aucune colonne numérique.")
        else:
            selected_column = st.selectbox(
                "Sélectionnez une colonne numérique :",
                numeric_columns
            )

            st.subheader(f"Graphique de la colonne : {selected_column}")
            st.line_chart(df[selected_column])

    except Exception:
        st.error("Une erreur est survenue lors de la lecture du fichier CSV.")
```

Cette version est plus courte et respecte les exigences de base. Cependant, pour un fichier Yahoo Finance, la version complète est meilleure, car elle utilise correctement la colonne `Date`.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-15"></a>

<details>
<summary><strong>15 — Résumé final</strong></summary>

<br/>

Cette correction fournit une application Streamlit complète pour visualiser un fichier CSV. Elle est adaptée aux fichiers financiers provenant de Yahoo Finance, qui contiennent généralement les colonnes `Date`, `Open`, `High`, `Low`, `Close`, `Adj Close` et `Volume`.

L’application permet de charger un fichier CSV, d’afficher les données, de détecter les colonnes numériques, de sélectionner une colonne et de générer un graphique en ligne. Elle utilise aussi la colonne `Date` comme axe temporel lorsque cette colonne est présente.

La correction inclut également une gestion propre des erreurs. L’application affiche des messages clairs si aucun fichier n’est chargé, si le fichier est vide, si le fichier est incorrect ou s’il ne contient aucune colonne numérique.

Le bonus demandé dans l’énoncé est aussi inclus, car le fichier CSV est chargé depuis la barre latérale avec `st.sidebar.file_uploader`.

### Phrase finale

Une bonne correction ne doit pas seulement produire un graphique. Elle doit aussi charger correctement les données, vérifier leur structure, guider l’utilisateur et éviter que l’application plante en cas de problème.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>
