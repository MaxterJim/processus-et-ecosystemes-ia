<a id="top"></a>

# Cours — CPU, GPU et ressources matérielles pour un projet d’intelligence artificielle

## Table des matières

| # | Section |
|---|---------|
| 1 | [Introduction générale](#section-1) |
| 2 | [Pourquoi le choix du matériel est important en IA ?](#section-2) |
| 3 | [Différence entre entraînement et inférence](#section-3) |
| 4 | [Le CPU : le processeur généraliste](#section-4) |
| 5 | [Le GPU : l’accélérateur des calculs IA](#section-5) |
| 6 | [Pourquoi les GPU sont importants pour l’intelligence artificielle ?](#section-6) |
| 7 | [Quand un CPU est suffisant pour un projet IA ?](#section-7) |
| 8 | [Quand un GPU devient nécessaire ?](#section-8) |
| 9 | [Les cartes Jetson : IA embarquée avec GPU intégré](#section-9) |
| 10 | [Raspberry Pi, Arduino et microcontrôleurs](#section-10) |
| 11 | [Cloud, serveur local ou appareil embarqué ?](#section-11) |
| 12 | [Ce que les entreprises utilisent réellement](#section-12) |
| 13 | [Tableau comparatif des solutions matérielles](#section-13) |
| 14 | [Exemples concrets de choix matériel](#section-14) |
| 15 | [Erreurs fréquentes dans le choix du matériel IA](#section-15) |
| 16 | [Activité formative](#section-16) |
| 17 | [Synthèse à retenir](#section-17) |

---

<a id="section-1"></a>

<details open>
<summary><strong>1 — Introduction générale</strong></summary>

<br/>

Un projet d’intelligence artificielle ne dépend pas seulement du modèle utilisé. Il dépend aussi de la machine sur laquelle le modèle va être entraîné, testé et utilisé.

Dans un projet IA, on entend souvent parler de CPU, GPU, carte graphique, serveur, cloud, Jetson, Raspberry Pi ou Arduino. Ces mots peuvent sembler techniques au départ, mais ils répondent tous à une question très simple :

**Sur quelle machine le projet IA va-t-il fonctionner ?**

Tous les projets IA n’ont pas besoin du même matériel. Un petit modèle de classification sur un fichier CSV peut fonctionner sur un ordinateur classique avec un CPU. Un modèle de vision par ordinateur qui analyse des milliers d’images peut avoir besoin d’un GPU. Un robot ou une caméra intelligente peut utiliser une carte Jetson. Un petit capteur intelligent peut utiliser Arduino ou un microcontrôleur avec TinyML.

Il faut donc apprendre à choisir le bon matériel selon le besoin. Le meilleur choix n’est pas toujours le plus puissant. Le meilleur choix est celui qui correspond au projet, au budget, au volume de données, au modèle utilisé, au temps disponible et à l’environnement de déploiement.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-2"></a>

<details>
<summary><strong>2 — Pourquoi le choix du matériel est important en IA ?</strong></summary>

<br/>

Le choix du matériel influence directement la vitesse, le coût, la faisabilité et la qualité d’un projet IA.

Si le matériel est trop faible, le modèle peut prendre beaucoup trop de temps à s’entraîner. Par exemple, entraîner un réseau de neurones sur des images peut prendre plusieurs jours sur CPU, alors que le même traitement peut être beaucoup plus rapide sur GPU.

Si le matériel est trop puissant pour un petit projet, l’entreprise peut gaspiller de l’argent. Par exemple, louer une machine cloud très coûteuse avec plusieurs GPU pour entraîner un petit modèle scikit-learn sur un fichier CSV n’est pas forcément nécessaire.

Le matériel influence aussi le déploiement. Un modèle qui fonctionne dans un notebook sur un ordinateur puissant ne peut pas forcément fonctionner sur une petite carte embarquée. Il faut donc penser dès le début à l’endroit où le modèle sera utilisé.

### Exemple simple

Une entreprise veut créer un modèle qui prédit si un client risque de quitter un service. Les données sont dans un fichier CSV avec quelques milliers de lignes. Dans ce cas, un ordinateur standard avec CPU peut suffire.

Une autre entreprise veut entraîner un modèle qui reconnaît des défauts sur des images industrielles. Le dataset contient des dizaines de milliers d’images. Dans ce cas, un GPU devient beaucoup plus important.

Une troisième entreprise veut installer une caméra intelligente dans une usine pour détecter des objets en temps réel. Dans ce cas, il peut être intéressant d’utiliser une carte Jetson, car elle permet d’exécuter l’IA directement près de la caméra.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-3"></a>

<details>
<summary><strong>3 — Différence entre entraînement et inférence</strong></summary>

<br/>

Avant de comparer CPU, GPU, Jetson, Raspberry Pi et Arduino, il faut comprendre deux mots essentiels : **entraînement** et **inférence**.

L’entraînement est la phase pendant laquelle le modèle apprend. On lui donne des données, il ajuste ses paramètres, il fait des erreurs, il corrige ses erreurs et il améliore progressivement ses prédictions.

L’inférence est la phase pendant laquelle le modèle déjà entraîné est utilisé pour produire une réponse. Par exemple, on donne une image au modèle, et il répond : « cette image contient un chien ». Ou on donne une phrase à un modèle de langage, et il génère une réponse.

| Étape | Question simple | Exemple | Besoin matériel |
|---|---|---|---|
| **Entraînement** | Le modèle apprend-il ? | Apprendre à reconnaître des chats et des chiens à partir de milliers d’images. | Souvent lourd, parfois besoin de GPU. |
| **Inférence** | Le modèle déjà entraîné est-il utilisé ? | Donner une nouvelle image et demander au modèle de prédire. | Peut parfois fonctionner sur CPU, Jetson, Raspberry Pi ou microcontrôleur. |

### Idée importante

Un projet peut nécessiter un GPU pour entraîner le modèle, mais pas forcément pour l’utiliser ensuite.

Par exemple, une équipe peut entraîner un modèle de vision sur un serveur GPU dans le cloud, puis déployer une version optimisée du modèle sur une carte Jetson près d’une caméra.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-4"></a>

<details>
<summary><strong>4 — Le CPU : le processeur généraliste</strong></summary>

<br/>

Le CPU, ou Central Processing Unit, est le processeur principal d’un ordinateur. Il exécute les instructions générales du système. Il lance les programmes, gère le système d’exploitation, exécute Python, manipule les fichiers, prépare les données et fait beaucoup de calculs standards.

On peut comparer le CPU à un travailleur très polyvalent. Il sait faire beaucoup de tâches différentes, mais il ne fait pas forcément des milliers de calculs identiques en même temps.

Dans un projet IA, le CPU est très utile pour :

| Utilisation du CPU | Exemple |
|---|---|
| Préparer les données | Lire un fichier CSV, nettoyer les valeurs manquantes, transformer les colonnes. |
| Faire de l’analyse de données | Utiliser Pandas, NumPy, Matplotlib. |
| Entraîner des modèles classiques | Régression linéaire, arbre de décision, Random Forest, XGBoost, SVM sur petits ou moyens datasets. |
| Exécuter une API IA | Utiliser FastAPI pour exposer un modèle simple. |
| Faire de l’inférence légère | Utiliser un petit modèle déjà entraîné. |

### Exemple vulgarisé

Si le GPU est une autoroute avec beaucoup de voies pour faire des calculs en parallèle, le CPU est plutôt une voiture très intelligente qui sait prendre beaucoup de routes différentes.

Le CPU est excellent pour les tâches générales. Il devient moins efficace quand il faut faire énormément de calculs mathématiques répétitifs, comme dans les grands réseaux de neurones.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-5"></a>

<details>
<summary><strong>5 — Le GPU : l’accélérateur des calculs IA</strong></summary>

<br/>

Le GPU, ou Graphics Processing Unit, est une puce conçue au départ pour les calculs graphiques. Il sert à afficher des images, des jeux vidéo, des animations et des vidéos. Mais avec le temps, les GPU sont devenus essentiels en intelligence artificielle.

Pourquoi ? Parce que l’intelligence artificielle moderne utilise beaucoup de calculs matriciels. Les réseaux de neurones manipulent de grands tableaux de nombres. Ces calculs sont souvent répétitifs et peuvent être parallélisés.

Le GPU est très fort pour effectuer beaucoup de calculs simples en même temps. C’est exactement ce dont le deep learning a besoin.

| Utilisation du GPU | Exemple |
|---|---|
| Entraînement de réseaux de neurones | CNN, Transformer, modèles de vision, modèles de langage. |
| Vision par ordinateur | Détection d’objets, segmentation d’images, analyse vidéo. |
| IA générative | LLM, génération d’images, modèles multimodaux. |
| Inférence rapide | Servir un modèle à plusieurs utilisateurs en même temps. |
| Calcul scientifique | Simulation, traitement massif de données, HPC. |

Les GPU modernes comme les NVIDIA H100 sont conçus pour accélérer les charges IA lourdes, notamment grâce aux Tensor Cores et aux moteurs optimisés pour les Transformers. NVIDIA indique par exemple que le H100 intègre des Tensor Cores de quatrième génération et un Transformer Engine optimisé pour les grands modèles. :contentReference[oaicite:1]{index=1}

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-6"></a>

<details>
<summary><strong>6 — Pourquoi les GPU sont importants pour l’intelligence artificielle ?</strong></summary>

<br/>

Les GPU sont importants en IA parce qu’ils peuvent faire beaucoup de calculs en parallèle. Dans un réseau de neurones, il faut multiplier des matrices, calculer des gradients, ajuster des poids et répéter ces opérations un grand nombre de fois.

Un CPU peut faire ces calculs, mais souvent plus lentement. Un GPU peut les faire beaucoup plus rapidement lorsque le modèle et les données sont adaptés au calcul parallèle.

### Exemple très simple

Imaginons qu’il faut corriger 10 000 copies.

Un CPU ressemble à quelques correcteurs très intelligents qui corrigent les copies une par une.

Un GPU ressemble à une grande salle avec des milliers de petits correcteurs qui corrigent beaucoup de copies en même temps.

Chaque petit correcteur n’est pas forcément très polyvalent, mais ensemble ils sont très efficaces pour les tâches répétitives.

### Pourquoi cela change tout en IA ?

Dans le deep learning, on ne fait pas seulement quelques calculs. On fait parfois des milliards ou des trillions d’opérations. Sans GPU ou accélérateur spécialisé, certains entraînements deviennent trop longs ou trop coûteux.

C’est pour cette raison que les grandes entreprises utilisent des GPU, des TPU ou des accélérateurs spécialisés pour les grands modèles IA. Google présente par exemple ses TPU comme des accélérateurs conçus pour les charges IA, incluant les grands modèles de langage, la génération de code, la vision, la recommandation et la personnalisation. :contentReference[oaicite:2]{index=2}

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-7"></a>

<details>
<summary><strong>7 — Quand un CPU est suffisant pour un projet IA ?</strong></summary>

<br/>

Un CPU peut être largement suffisant pour beaucoup de projets IA, surtout au début de l’apprentissage ou pour des projets pédagogiques.

Il ne faut pas croire que tout projet IA nécessite immédiatement un GPU. Beaucoup de projets de machine learning classique peuvent fonctionner correctement sur CPU.

### CPU suffisant dans les cas suivants

| Situation | CPU suffisant ? | Explication |
|---|---:|---|
| Petit fichier CSV | Oui | Les données sont légères et faciles à charger. |
| Régression linéaire | Oui | Modèle simple, calculs raisonnables. |
| Arbre de décision | Oui | Très faisable sur ordinateur standard. |
| Random Forest sur dataset moyen | Souvent oui | Peut être plus lent, mais reste possible. |
| XGBoost sur dataset raisonnable | Souvent oui | Fonctionne sur CPU, même si GPU peut accélérer certains cas. |
| Analyse avec Pandas | Oui | Le CPU est adapté à la préparation des données. |
| Petit chatbot avec API externe | Oui | Le calcul lourd est fait par le fournisseur du modèle. |
| Inférence d’un petit modèle | Oui | Un modèle léger peut tourner sur CPU. |

### Exemple concret

Un étudiant travaille sur un projet de prédiction des prix de maisons avec un fichier CSV. Il utilise Pandas, scikit-learn et un modèle Random Forest.

Dans ce cas, un ordinateur portable classique peut suffire. Il n’a pas besoin d’une carte NVIDIA H100 ni d’un serveur cloud coûteux.

### Phrase à retenir

Le CPU est souvent suffisant pour apprendre le machine learning, faire de l’analyse de données, entraîner des modèles classiques et créer des prototypes simples.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-8"></a>

<details>
<summary><strong>8 — Quand un GPU devient nécessaire ?</strong></summary>

<br/>

Un GPU devient important lorsque le projet utilise des modèles lourds, beaucoup de données ou des calculs parallèles intensifs.

Le GPU n’est pas obligatoire pour tous les projets IA, mais il devient presque indispensable dans plusieurs cas modernes.

### GPU recommandé ou nécessaire dans les cas suivants

| Situation | GPU recommandé ? | Explication |
|---|---:|---|
| Entraîner un réseau de neurones profond | Oui | Les calculs matriciels sont nombreux. |
| Entraîner un modèle de vision par ordinateur | Oui | Les images demandent beaucoup de calculs. |
| Analyser de la vidéo en temps réel | Oui | Beaucoup d’images par seconde doivent être traitées. |
| Fine-tuning d’un modèle de langage | Oui | Les LLM demandent beaucoup de mémoire et de calculs. |
| Génération d’images | Oui | Les modèles de diffusion sont lourds. |
| Servir un grand modèle à plusieurs utilisateurs | Oui | L’inférence doit être rapide et scalable. |
| Projet IA générative avancé | Oui | GPU ou accélérateur spécialisé recommandé. |

### Exemple concret

Une équipe veut entraîner un modèle capable de détecter des défauts dans des images de pièces industrielles.

Chaque image contient beaucoup de pixels. Le modèle doit analyser des milliers d’images. À chaque époque d’entraînement, le modèle répète énormément de calculs.

Dans ce cas, le GPU permet de réduire fortement le temps d’entraînement.

### Attention

Avoir un GPU ne suffit pas. Il faut aussi :

| Élément | Pourquoi c’est important |
|---|---|
| Mémoire GPU suffisante | Les grands modèles peuvent ne pas entrer en mémoire. |
| Bibliothèques compatibles | PyTorch ou TensorFlow doivent détecter le GPU. |
| Pilotes corrects | CUDA, drivers NVIDIA ou environnement cloud bien configuré. |
| Bon format de données | Les données doivent être chargées efficacement. |
| Budget maîtrisé | Les GPU cloud peuvent coûter cher. |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-9"></a>

<details>
<summary><strong>9 — Les cartes Jetson : IA embarquée avec GPU intégré</strong></summary>

<br/>

Les cartes NVIDIA Jetson sont des petites machines conçues pour faire fonctionner de l’intelligence artificielle directement sur le terrain. On parle souvent d’**IA embarquée** ou d’**Edge AI**.

Une carte Jetson n’est pas un simple Arduino. C’est une petite plateforme avec CPU, GPU, mémoire et système Linux. Elle peut exécuter des modèles de vision, de détection d’objets, de robotique ou d’analyse vidéo.

La Jetson est intéressante quand on veut rapprocher l’IA de l’objet réel : caméra, robot, drone, capteur industriel, système de surveillance, machine autonome.

NVIDIA présente par exemple le Jetson Orin Nano Super Developer Kit comme une plateforme compacte pour l’IA embarquée, avec une performance annoncée jusqu’à 67 TOPS après mise à jour logicielle. :contentReference[oaicite:3]{index=3}

### Jetson est utile pour :

| Projet | Pourquoi Jetson est adaptée |
|---|---|
| Caméra intelligente | Traitement local des images sans envoyer toutes les vidéos au cloud. |
| Robot mobile | Analyse en temps réel des capteurs et de la caméra. |
| Détection d’objets | Exécution locale de modèles optimisés. |
| Projet industriel | Latence faible et fonctionnement près de la machine. |
| Prototype Edge AI | Bon compromis entre puissance, taille et consommation. |

### Jetson n’est pas idéale pour :

| Situation | Pourquoi |
|---|---|
| Entraîner un très grand modèle | La puissance reste limitée par rapport à un serveur GPU. |
| Héberger un gros LLM pour beaucoup d’utilisateurs | Mémoire et puissance limitées. |
| Faire du traitement massif de données | Un serveur ou le cloud est plus adapté. |
| Remplacer un cluster GPU | Jetson est faite pour l’edge, pas pour l’entraînement massif. |

### Phrase à retenir

Jetson est surtout une bonne solution pour **utiliser un modèle IA près du terrain**, pas pour entraîner de très grands modèles.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-10"></a>

<details>
<summary><strong>10 — Raspberry Pi, Arduino et microcontrôleurs</strong></summary>

<br/>

Raspberry Pi et Arduino sont souvent utilisés dans des projets éducatifs, IoT, robotique ou prototypes embarqués. Mais ils ne jouent pas le même rôle.

### Raspberry Pi

Le Raspberry Pi est un petit ordinateur. Il peut exécuter Linux, Python, des scripts, des serveurs web légers, des caméras, des capteurs et certains modèles IA optimisés.

Le Raspberry Pi 5 utilise un processeur Arm Cortex-A76 quad-core à 2,4 GHz, avec des variantes de mémoire allant jusqu’à 16 Go selon la documentation officielle du fabricant. :contentReference[oaicite:4]{index=4}

Le Raspberry Pi peut être utile pour :

| Projet | Faisabilité |
|---|---|
| Lire des capteurs | Très faisable |
| Contrôler une caméra | Faisable |
| Exécuter un petit modèle IA | Faisable |
| Faire de l’inférence légère | Faisable |
| Créer une mini API locale | Faisable |
| Entraîner un gros modèle IA | Peu adapté |
| Exécuter un grand LLM localement | Très limité |

### Arduino

Arduino est plutôt un microcontrôleur. Il ne fonctionne pas comme un ordinateur complet avec Linux. Il est utilisé pour lire des capteurs, contrôler des moteurs, mesurer des signaux, déclencher des actions et faire des traitements très légers.

Arduino peut aussi faire du TinyML. TinyML signifie que l’on exécute de très petits modèles IA directement sur des microcontrôleurs.

Arduino indique que la carte Nano 33 BLE Sense Rev2 peut servir à commencer avec l’apprentissage automatique embarqué, grâce à TinyML et TensorFlow Lite, avec des capteurs intégrés pour le mouvement, l’audio, la couleur, la proximité, la température et l’humidité. :contentReference[oaicite:5]{index=5}

Google indique aussi que LiteRT for Microcontrollers est conçu pour faire fonctionner des modèles ML sur des microcontrôleurs avec seulement quelques kilo-octets de mémoire. :contentReference[oaicite:6]{index=6}

### Différence simple

| Élément | Raspberry Pi | Arduino |
|---|---|---|
| Type | Petit ordinateur | Microcontrôleur |
| Système d’exploitation | Oui, souvent Linux | Non, programme embarqué |
| Python | Oui | Limité ou indirect |
| Capteurs | Oui | Oui, très adapté |
| IA légère | Oui | Oui, mais très limitée |
| Caméra IA | Possible | Très limité |
| Grand modèle IA | Non adapté | Non adapté |
| Usage principal | Edge computing léger | Contrôle de capteurs et TinyML |

### Phrase à retenir

Raspberry Pi est un petit ordinateur. Arduino est un microcontrôleur. Les deux peuvent être utiles en IA, mais surtout pour des projets légers, embarqués ou éducatifs.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-11"></a>

<details>
<summary><strong>11 — Cloud, serveur local ou appareil embarqué ?</strong></summary>

<br/>

Dans un projet IA, il faut choisir où les calculs seront exécutés.

Il y a trois grandes options : le cloud, le serveur local et l’appareil embarqué.

### Le cloud

Le cloud permet de louer des machines puissantes à distance. On peut utiliser des CPU, des GPU, du stockage, des bases de données et des services IA prêts à l’emploi.

AWS propose par exemple des instances EC2 P5 avec jusqu’à 8 GPU NVIDIA H100, et des variantes P5e/P5en avec jusqu’à 8 GPU NVIDIA H200 selon sa documentation officielle. :contentReference[oaicite:7]{index=7}

Microsoft Azure propose aussi des machines GPU spécialisées, comme les séries ND H100 v5 conçues pour l’entraînement deep learning haut de gamme, l’IA générative et les charges HPC. :contentReference[oaicite:8]{index=8}

### Le serveur local

Un serveur local est une machine physique appartenant à l’entreprise. Il peut contenir des CPU puissants, beaucoup de RAM, du stockage et parfois plusieurs GPU.

Cette option est intéressante quand l’entreprise veut garder les données en interne, contrôler l’infrastructure ou réduire certains coûts à long terme.

### L’appareil embarqué

Un appareil embarqué est une petite machine installée près du terrain : Jetson, Raspberry Pi, Arduino, capteur intelligent, robot, caméra, machine industrielle.

Cette option est intéressante quand il faut une réponse rapide, une faible latence, moins de dépendance au réseau ou plus de confidentialité.

| Option | Avantage | Limite |
|---|---|---|
| **Cloud** | Puissant, flexible, disponible à la demande | Coût récurrent, dépendance réseau, sécurité à gérer |
| **Serveur local** | Contrôle, données internes, puissance dédiée | Achat coûteux, maintenance, mises à jour |
| **Jetson / Edge** | IA près du terrain, faible latence | Puissance limitée |
| **Raspberry Pi** | Peu coûteux, éducatif, flexible | IA lourde limitée |
| **Arduino** | Très faible consommation, capteurs | IA très légère seulement |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-12"></a>

<details>
<summary><strong>12 — Ce que les entreprises utilisent réellement</strong></summary>

<br/>

Les entreprises ne choisissent pas toutes la même ressource. Le choix dépend du type de projet.

Une entreprise qui fait de l’analyse de données classique peut utiliser principalement des CPU. Une entreprise qui entraîne des modèles de vision ou des LLM utilise souvent des GPU. Une entreprise qui déploie des modèles dans des caméras, robots ou machines industrielles peut utiliser des cartes edge comme Jetson. Une entreprise qui travaille avec des capteurs très simples peut utiliser des microcontrôleurs.

### Exemples de ressources utilisées en entreprise

| Type d’entreprise ou projet | Ressources souvent utilisées |
|---|---|
| Banque, assurance, marketing analytique | CPU, serveurs, bases de données, parfois GPU pour certains modèles. |
| Vision par ordinateur industrielle | GPU pour entraînement, Jetson ou serveur GPU pour inférence. |
| IA générative et LLM | GPU cloud, clusters GPU, TPU ou accélérateurs spécialisés. |
| Recommandation à grande échelle | CPU + GPU/TPU selon le volume et l’architecture. |
| Robotique | Jetson, capteurs, parfois Raspberry Pi pour prototype. |
| IoT intelligent | Arduino, ESP32, microcontrôleurs, TinyML. |
| Startup IA | Cloud GPU au début, puis optimisation selon les coûts. |
| Grande entreprise tech | Clusters GPU, TPU, accélérateurs maison, infrastructure cloud ou privée. |

### Exemples concrets

Google utilise des TPU pour plusieurs charges IA, et sa documentation indique que les TPU alimentent notamment Gemini ainsi que des applications Google comme Search, Photos et Maps. :contentReference[oaicite:9]{index=9}

AWS propose des instances GPU pour l’entraînement et l’inférence IA, notamment les instances P5 avec GPU NVIDIA H100/H200 selon les variantes. :contentReference[oaicite:10]{index=10}

Microsoft Azure propose des machines GPU ND H100 v5 pour les charges deep learning, IA générative et HPC. :contentReference[oaicite:11]{index=11}

### Phrase importante

Les grandes entreprises n’utilisent pas uniquement des GPU. Elles utilisent un mélange de CPU, GPU, TPU, stockage, réseau, cloud, serveurs locaux et appareils edge selon le besoin.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-13"></a>

<details>
<summary><strong>13 — Tableau comparatif des solutions matérielles</strong></summary>

<br/>

Le tableau suivant permet de comparer les principales solutions matérielles utilisées dans les projets IA.

| Solution | Type | Puissance IA | Coût | Usage principal | Exemple de projet |
|---|---|---:|---:|---|---|
| **CPU ordinateur portable** | Processeur généraliste | Faible à moyenne | Faible à moyen | Apprentissage, analyse, ML classique | Modèle scikit-learn sur CSV |
| **GPU ordinateur personnel** | Carte graphique locale | Moyenne à élevée | Moyen à élevé | Deep learning local, prototypes | Vision par ordinateur |
| **GPU cloud** | Ressource louée | Élevée à très élevée | Variable, peut être élevé | Entraînement lourd, LLM, IA générative | Fine-tuning, entraînement massif |
| **Serveur GPU local** | Infrastructure interne | Élevée | Très élevé au départ | Entreprise, recherche, production | Cluster IA privé |
| **Google TPU** | Accélérateur spécialisé | Très élevée | Cloud / spécialisé | Deep learning à grande échelle | LLM, recommandation, vision |
| **NVIDIA Jetson** | Edge AI | Moyenne pour l’edge | Moyen | Caméras, robots, IA embarquée | Détection d’objets locale |
| **Raspberry Pi** | Petit ordinateur | Faible à moyenne | Faible | Prototypes, capteurs, mini-serveur | Caméra intelligente légère |
| **Arduino / microcontrôleur** | Microcontrôleur | Très faible | Très faible | Capteurs, TinyML | Détection de geste ou son simple |

### Lecture simple du tableau

Si le projet est petit et pédagogique, un CPU suffit souvent.

Si le projet contient beaucoup d’images, de vidéos ou de deep learning, un GPU devient utile.

Si le projet doit fonctionner dans une caméra ou un robot, Jetson peut être un bon choix.

Si le projet utilise seulement des capteurs simples, Arduino ou un microcontrôleur peut suffire.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-14"></a>

<details>
<summary><strong>14 — Exemples concrets de choix matériel</strong></summary>

<br/>

### Exemple 1 — Classification de clients avec un fichier CSV

Une entreprise veut prédire si un client risque de quitter son abonnement.

Les données sont dans un fichier CSV avec 20 colonnes et 10 000 lignes.

Le modèle utilisé est une régression logistique, un arbre de décision ou un Random Forest.

| Élément | Choix recommandé |
|---|---|
| Matériel | Ordinateur avec CPU |
| GPU nécessaire ? | Non |
| Outils | Python, Pandas, scikit-learn |
| Déploiement | API simple avec FastAPI |
| Justification | Le dataset est petit et le modèle est classique. |

### Exemple 2 — Détection de défauts sur images industrielles

Une usine veut détecter automatiquement des défauts sur des pièces à partir d’images.

Le dataset contient 50 000 images.

Le modèle utilisé est un réseau de neurones convolutionnel.

| Élément | Choix recommandé |
|---|---|
| Matériel | GPU local ou GPU cloud |
| GPU nécessaire ? | Oui, fortement recommandé |
| Outils | PyTorch ou TensorFlow |
| Déploiement | Serveur GPU ou Jetson selon le contexte |
| Justification | Les images demandent beaucoup de calculs. |

### Exemple 3 — Caméra intelligente dans un entrepôt

Une entreprise veut installer une caméra qui détecte automatiquement la présence d’objets dans une zone.

Le modèle est déjà entraîné.

Il faut faire de l’inférence en temps réel près de la caméra.

| Élément | Choix recommandé |
|---|---|
| Matériel | NVIDIA Jetson |
| GPU nécessaire ? | Oui, mais local et embarqué |
| Outils | TensorRT, OpenCV, PyTorch exporté |
| Déploiement | Directement près de la caméra |
| Justification | Faible latence et traitement local. |

### Exemple 4 — Capteur intelligent de mouvement

Un petit appareil doit reconnaître un geste simple à partir d’un accéléromètre.

Le modèle est très petit.

| Élément | Choix recommandé |
|---|---|
| Matériel | Arduino Nano 33 BLE Sense ou microcontrôleur compatible TinyML |
| GPU nécessaire ? | Non |
| Outils | TensorFlow Lite Micro, Edge Impulse |
| Déploiement | Directement sur le microcontrôleur |
| Justification | Le modèle est très léger et proche du capteur. |

### Exemple 5 — Assistant IA interne avec documents d’entreprise

Une entreprise veut créer un assistant qui répond aux questions des employés à partir de documents internes.

Si elle utilise une API externe de LLM, l’ordinateur local n’a pas besoin de GPU. Le calcul lourd est fait par le fournisseur du modèle.

Si elle veut héberger un grand modèle localement, elle aura besoin d’un serveur GPU ou d’une infrastructure cloud adaptée.

| Option | Ressource recommandée |
|---|---|
| API externe | CPU suffisant côté application |
| Petit modèle local | CPU puissant ou petit GPU |
| LLM moyen local | GPU avec mémoire suffisante |
| LLM entreprise à grande échelle | Cluster GPU ou cloud spécialisé |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-15"></a>

<details>
<summary><strong>15 — Erreurs fréquentes dans le choix du matériel IA</strong></summary>

<br/>

La première erreur consiste à croire que tout projet IA nécessite un GPU. Ce n’est pas vrai. Beaucoup de projets de machine learning classique fonctionnent très bien sur CPU.

La deuxième erreur consiste à croire qu’un Raspberry Pi peut remplacer un vrai serveur GPU. Le Raspberry Pi est excellent pour des prototypes, des capteurs, des mini-serveurs et de l’inférence légère, mais il n’est pas conçu pour entraîner de grands modèles.

La troisième erreur consiste à croire qu’un Arduino peut exécuter n’importe quel modèle IA. Arduino peut faire du TinyML, mais uniquement avec des modèles très petits et optimisés.

La quatrième erreur consiste à acheter du matériel avant de comprendre le besoin. Il faut d’abord analyser le projet, les données, le modèle, le temps de réponse attendu et le budget.

La cinquième erreur consiste à oublier la mémoire. En IA, la mémoire GPU ou la RAM peut être aussi importante que la puissance brute. Un modèle peut être impossible à charger si la mémoire est insuffisante.

| Erreur fréquente | Pourquoi c’est un problème | Bonne pratique |
|---|---|---|
| Acheter un GPU sans besoin clair | Coût inutile | Commencer par analyser le projet |
| Utiliser CPU pour un gros modèle vision | Entraînement trop lent | Utiliser GPU ou cloud |
| Utiliser Raspberry Pi pour entraîner un modèle lourd | Matériel non adapté | Entraîner ailleurs, déployer léger |
| Utiliser Arduino pour un modèle trop gros | Mémoire insuffisante | Utiliser TinyML uniquement |
| Oublier le coût cloud | Facture élevée | Limiter les sessions GPU et suivre les coûts |
| Oublier le déploiement | Le modèle reste bloqué dans le notebook | Penser production dès le départ |

### Phrase importante

Le meilleur matériel n’est pas toujours le plus puissant. Le meilleur matériel est celui qui correspond au besoin réel du projet.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-16"></a>

<details>
<summary><strong>16 — Activité formative : choisir les ressources matérielles d’un projet IA</strong></summary>

<br/>

### Mise en situation

Une entreprise veut développer trois projets IA différents.

Le premier projet consiste à prédire les ventes du mois prochain à partir d’un fichier CSV contenant l’historique des ventes.

Le deuxième projet consiste à détecter des défauts dans des images de produits industriels.

Le troisième projet consiste à installer une petite caméra intelligente dans un atelier pour détecter la présence d’un objet en temps réel.

Vous devez analyser les besoins matériels pour chaque projet.

### Travail demandé

Pour chaque projet, vous devez indiquer :

| # | Question |
|---|---|
| 1 | Le projet nécessite-t-il surtout un CPU, un GPU, une carte Jetson, un Raspberry Pi ou un Arduino ? |
| 2 | Le projet concerne-t-il l’entraînement ou l’inférence ? |
| 3 | Le GPU est-il obligatoire, recommandé ou inutile ? |
| 4 | Le projet doit-il être exécuté dans le cloud, sur un serveur local ou sur un appareil embarqué ? |
| 5 | Quels risques techniques faut-il prévoir ? |
| 6 | Quelle solution matérielle recommandez-vous et pourquoi ? |

### Exemple de réponse attendue

Pour le projet de prédiction des ventes, un CPU est probablement suffisant. Les données sont sous forme de fichier CSV, et le modèle peut être un modèle classique de machine learning comme une régression, un arbre de décision ou un Random Forest. Le GPU n’est pas nécessaire au départ. Le projet peut être développé sur un ordinateur portable ou sur un serveur standard.

Pour le projet de détection de défauts dans des images, un GPU est recommandé. Les images demandent beaucoup de calculs, surtout si l’équipe utilise un réseau de neurones profond. L’entraînement peut être fait sur un GPU local ou dans le cloud. Le déploiement peut ensuite se faire sur serveur ou sur une carte edge si le modèle est optimisé.

Pour le projet de caméra intelligente, une carte Jetson peut être un bon choix. Le modèle peut être entraîné ailleurs, puis exécuté localement près de la caméra. Cela permet de réduire la latence et d’éviter d’envoyer toutes les images vers le cloud.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-17"></a>

<details>
<summary><strong>17 — Synthèse à retenir</strong></summary>

<br/>

Un projet IA doit être associé au bon matériel.

Le CPU est adapté aux tâches générales, à l’analyse de données, au machine learning classique et aux petits projets.

Le GPU est adapté aux calculs lourds, au deep learning, à la vision par ordinateur, à la vidéo, aux LLM et à l’IA générative.

La carte Jetson est adaptée à l’IA embarquée, notamment pour les caméras intelligentes, les robots et les systèmes qui doivent fonctionner près du terrain.

Le Raspberry Pi est un petit ordinateur utile pour les prototypes, les capteurs, les mini-serveurs et l’inférence légère.

Arduino est un microcontrôleur utile pour les capteurs, les objets connectés et les modèles TinyML très simples.

Le cloud permet d’accéder rapidement à des ressources puissantes sans acheter de machines, mais il faut surveiller le coût.

Un serveur local donne plus de contrôle, mais demande un investissement initial et de la maintenance.

### Règle simple de décision

| Si le projet est... | Ressource recommandée |
|---|---|
| Analyse de données simple | CPU |
| Machine learning classique | CPU |
| Deep learning sur images | GPU |
| LLM ou IA générative lourde | GPU cloud, TPU ou cluster spécialisé |
| Caméra intelligente | Jetson |
| Prototype IoT léger | Raspberry Pi |
| Capteur intelligent très simple | Arduino / TinyML |
| Projet d’entreprise scalable | Cloud, serveur GPU ou architecture hybride |

### Phrase finale

Pour réussir un projet IA, il ne faut pas seulement demander : « Quel modèle allons-nous utiliser ? ». Il faut aussi demander : « Où le modèle va-t-il apprendre, où va-t-il fonctionner, avec quelle puissance, quel coût et quelles limites ? ».

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>
