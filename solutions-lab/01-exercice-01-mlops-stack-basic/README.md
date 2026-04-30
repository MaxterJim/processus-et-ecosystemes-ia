# Stack MLOps — Fiche mémo des commandes

> Toutes les commandes doivent être exécutées depuis le dossier `chap06-mlops-stack/`, c’est-à-dire le dossier qui contient le fichier `docker-compose.yml`.

---

## URLs après `docker compose up -d`

### Depuis le navigateur de votre machine hôte Windows / macOS / Linux

| Service | URL |
| ------- | --- |
| Streamlit | http://localhost:8501 |
| FastAPI | http://localhost:8000 |
| Documentation FastAPI Swagger | http://localhost:8000/docs |
| Vérification de santé FastAPI | http://localhost:8000/health |
| Interface MLflow | http://localhost:5000 |

> Ici, `localhost` et `127.0.0.1` sont équivalents.

### Depuis une autre machine sur le réseau local LAN

Remplacez `<HOST-IP>` par l’adresse IP de votre machine. Vous pouvez la trouver avec `ipconfig` sur Windows ou `ip a` sur Linux.

| Service | URL |
| ------- | --- |
| Streamlit | http://&lt;HOST-IP&gt;:8501 |
| FastAPI | http://&lt;HOST-IP&gt;:8000/docs |
| Interface MLflow | http://&lt;HOST-IP&gt;:5000 |

### Depuis l’intérieur d’un conteneur communication service à service

Utilisez le **nom du service**, jamais `localhost`.

| Appelant | Cible | URL à utiliser dans le réseau Docker |
| -------- | ----- | ------------------------------------ |
| Streamlit | FastAPI | http://fastapi:8000 |
| FastAPI | MLflow | http://mlflow:5000 |
| n’importe quel service | Streamlit | http://streamlit:8501 |

Tester depuis l’intérieur d’un conteneur :

```bash
docker compose exec streamlit sh -c "wget -qO- http://fastapi:8000/health"
docker compose exec fastapi   sh -c "wget -qO- http://mlflow:5000/"
````

### Trouver l’adresse IP interne de chaque conteneur

```bash
docker inspect -f "{{.Name}} -> {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" mlflow fastapi streamlit
docker network inspect chap06-mlops-stack_mlops-net
```

> [!NOTE]
> Les adresses IP internes des conteneurs, souvent sous la forme `172.x.x.x`, **changent** à chaque exécution de `docker compose up`. Il faut donc toujours privilégier le **nom du service** plutôt que l’adresse IP.

### Voir rapidement les ports publiés

```bash
docker compose ps
docker compose port mlflow 5000
docker compose port fastapi 8000
docker compose port streamlit 8501
```

---

## Démarrer

```bash
docker compose up --build          # construire les images et démarrer les services au premier plan
docker compose up -d --build       # construire les images et démarrer les services en arrière-plan
docker compose up -d               # démarrer sans reconstruire les images
```

## Arrêter

```bash
# si les services tournent au premier plan : Ctrl+C, puis :
docker compose down                # arrêter et supprimer les conteneurs + le réseau, les volumes sont conservés
docker compose down -v             # supprimer aussi les volumes, les données MLflow seront perdues
docker compose down --rmi all      # supprimer aussi les images construites
docker compose down -v --rmi all   # remise à zéro complète : conteneurs + réseau + volumes + images
```

## État des services et journaux

```bash
docker compose ps                  # afficher l’état des services
docker compose logs                # afficher tous les journaux
docker compose logs -f             # suivre tous les journaux en temps réel
docker compose logs -f mlflow      # suivre les journaux d’un seul service
docker compose logs -f fastapi
docker compose logs -f streamlit
```

## Entrer dans un conteneur en cours d’exécution

```bash
docker compose exec mlflow bash
docker compose exec fastapi bash
docker compose exec streamlit bash
# quitter avec : exit
```

Si `bash` n’est pas disponible dans l’image minimale :

```bash
docker compose exec fastapi sh
```

Exécuter une commande ponctuelle sans entrer dans le conteneur :

```bash
docker compose exec fastapi python -c "import mlflow; print(mlflow.__version__)"
docker compose exec mlflow ls /mlflow/database
docker compose exec mlflow ls /mlflow/mlruns
```

## Redémarrer ou reconstruire un seul service

```bash
docker compose restart fastapi
docker compose build fastapi
docker compose up -d --build fastapi
```

## Volumes persistance de MLflow

```bash
docker volume ls
docker volume inspect chap06-mlops-stack_mlflow-db
docker volume inspect chap06-mlops-stack_mlflow-artifacts
docker volume rm chap06-mlops-stack_mlflow-db chap06-mlops-stack_mlflow-artifacts
```

## Images

```bash
docker images                                  # lister les images locales
docker rmi mlops/fastapi:latest                # supprimer une image
docker rmi mlops/mlflow:latest mlops/fastapi:latest mlops/streamlit:latest
docker image prune                             # supprimer les images inutilisées intermédiaires
docker image prune -a                          # supprimer toutes les images non utilisées
```

## Conteneurs

```bash
docker ps                          # afficher les conteneurs en cours d’exécution
docker ps -a                       # afficher tous les conteneurs, y compris les conteneurs arrêtés
docker stop mlflow fastapi streamlit
docker rm   mlflow fastapi streamlit
docker container prune             # supprimer tous les conteneurs arrêtés
```

## Utilisation disque et nettoyage

```bash
docker system df                   # afficher l’utilisation disque par catégorie
docker system prune                # supprimer les conteneurs, réseaux et images intermédiaires inutilisés
docker system prune -a             # supprimer aussi les images non utilisées
docker system prune -a --volumes   # nettoyage complet : supprimer aussi les volumes inutilisés
docker builder prune               # supprimer uniquement le cache de construction
```

## Réinitialisation complète repartir de zéro

```bash
docker compose down -v --rmi all
docker system prune -a --volumes -f
docker compose up --build
```

---

## Vérifications rapides de santé

```bash
curl http://localhost:5000/                       # MLflow
curl http://localhost:8000/health                 # FastAPI
curl -X POST http://localhost:8000/log-run -H "Content-Type: application/json" -d "{\"features\":[1,2,3]}"
```
