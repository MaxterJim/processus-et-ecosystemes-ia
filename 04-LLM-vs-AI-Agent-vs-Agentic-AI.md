<a id="top"></a>

# LLM vs AI Agent vs Agentic AI

## Table des matières

| # | Section |
|---|---------|
| 1 | [Vue d'ensemble — Les 3 concepts en un coup d'oeil](#section-1) |
| 2 | [LLM — Large Language Model](#section-2) |
| 2a | &nbsp;&nbsp;&nbsp;↳ [Définition et fonctionnement](#section-2) |
| 2b | &nbsp;&nbsp;&nbsp;↳ [Ce qu'un LLM fait et ne fait pas](#section-2) |
| 2c | &nbsp;&nbsp;&nbsp;↳ [Exemples de LLMs majeurs](#section-2) |
| 3 | [AI Agent — Agent IA](#section-3) |
| 3a | &nbsp;&nbsp;&nbsp;↳ [Définition et architecture](#section-3) |
| 3b | &nbsp;&nbsp;&nbsp;↳ [Les composants d'un agent](#section-3) |
| 3c | &nbsp;&nbsp;&nbsp;↳ [Types d'agents](#section-3) |
| 4 | [Agentic AI — IA agentique](#section-4) |
| 4a | &nbsp;&nbsp;&nbsp;↳ [Définition](#section-4) |
| 4b | &nbsp;&nbsp;&nbsp;↳ [Ce qui distingue l'agentic AI](#section-4) |
| 4c | &nbsp;&nbsp;&nbsp;↳ [Multi-agent systems](#section-4) |
| 5 | [Comparaison directe — LLM vs Agent vs Agentic AI](#section-5) |
| 6 | [Comment ils s'articulent ensemble](#section-6) |
| 7 | [Limites et risques](#section-7) |
| 8 | [Cas d'usage concrets par type](#section-8) |
| 9 | [Quiz de consolidation](#section-9) |

---

<a id="section-1"></a>

<details>
<summary><strong>1 — Vue d'ensemble — Les 3 concepts en un coup d'oeil</strong></summary>

<br/>

Ces trois termes sont souvent confondus ou utilisés de manière interchangeable. Ils désignent pourtant des niveaux d'abstraction différents.

```mermaid
flowchart TD
    LLM["LLM\nLarge Language Model\n\nModele de langage entraine\nsur de grandes quantites de texte.\nPredit le prochain token.\nRepond a une entree."]

    AGENT["AI Agent\nAgent IA\n\nSysteme qui utilise un LLM\ncomme moteur de raisonnement\net peut appeler des outils\npour agir dans le monde."]

    AGENTIC["Agentic AI\nIA agentique\n\nParadigme ou plusieurs agents\ntravaillent en autonomie,\nse coordonnent, planifient\net executent des missions complexes."]

    LLM -->|"devient le cerveau de"| AGENT
    AGENT -->|"compose un systeme"| AGENTIC
```

| Concept | Analogie humaine |
|---------|-----------------|
| **LLM** | Un expert tres instruit qui repond a des questions |
| **AI Agent** | Un assistant qui peut aussi utiliser un ordinateur, chercher sur le web et envoyer des emails |
| **Agentic AI** | Une equipe d'assistants specialises qui collaborent pour accomplir un projet |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-2"></a>

<details>
<summary><strong>2 — LLM — Large Language Model</strong></summary>

<br/>

### Definition et fonctionnement

Un **LLM** (Large Language Model) est un modele de langage entraine sur des milliards de mots de texte pour apprendre les patterns statistiques du langage. Il fonctionne en **predisant le prochain token** (mot ou sous-mot) le plus probable etant donne le contexte precedent.

```mermaid
flowchart LR
    I["Entree (prompt)\n'La capitale de la France est'"]
    T["Tokenisation\n['La', 'cap', 'itale', 'de', 'la', 'France', 'est']"]
    M["Modele Transformer\nAttention + Feedforward\n(milliards de parametres)"]
    O["Sortie (completion)\n'Paris'"]

    I --> T --> M --> O
```

#### Comment un LLM est-il entraine ?

| Etape | Description |
|-------|-------------|
| **Pre-entrainement** | Entrainement sur des milliards de documents — le modele apprend la langue, les faits, la logique |
| **Fine-tuning supervise** | Entrainement sur des exemples de bonne qualite (questions/reponses) |
| **RLHF** | Reinforcement Learning from Human Feedback — les humains notent les reponses, le modele s'aligne |

---

### Ce qu'un LLM fait et ne fait pas

| Un LLM FAIT | Un LLM ne FAIT PAS |
|------------|---------------------|
| Generer du texte coherent | Agir de maniere autonome |
| Resumer, traduire, expliquer | Naviguer sur le web (sans outils) |
| Repondre a des questions | Se souvenir entre deux sessions (sans memoire externe) |
| Ecrire du code | Executer ce code (sans outil) |
| Raisonner sur un probleme | Initier une action de lui-meme |
| Comprendre des images (si multimodal) | Prendre des decisions persistantes |

> Un LLM est **reactif** — il repond quand on lui parle. Il n'agit pas de lui-meme.

---

### Architecture interne — Le Transformer

```mermaid
flowchart TD
    subgraph TRANSFORMER["Architecture Transformer (simplifie)"]
        EMB["Embedding\n(tokens -> vecteurs)"]
        PE["Positional Encoding\n(position dans la sequence)"]
        ATT["Multi-Head Attention\n(quels tokens sont importants\npar rapport aux autres)"]
        FF["Feedforward Network\n(transformation non lineaire)"]
        NORM["Layer Normalization"]
        OUT["Output Layer\n(probabilite sur le vocabulaire)"]

        EMB --> PE --> ATT --> NORM --> FF --> NORM --> OUT
    end
```

Le mecanisme cle est l'**attention** : le modele apprend quels mots du contexte sont les plus pertinents pour predire le prochain token. C'est ce qui permet de traiter des phrases longues et des dependances a longue distance.

---

### Exemples de LLMs majeurs en 2026

| Modele | Createur | Points forts |
|--------|---------|--------------|
| **GPT-4o / o3** | OpenAI | Multimodal, raisonnement avance |
| **Claude 3.5 / Claude 4** | Anthropic | Fenetre de contexte large, surete |
| **Gemini Ultra** | Google DeepMind | Integration Google, multimodal |
| **LLaMA 3** | Meta | Open source, deployable localement |
| **Mistral Large** | Mistral AI | Europeen, open source competitif |
| **DeepSeek V3** | DeepSeek | Tres performant, couts reduits |
| **Qwen** | Alibaba | Multilangue, open source |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-3"></a>

<details>
<summary><strong>3 — AI Agent — Agent IA</strong></summary>

<br/>

### Definition et architecture

Un **AI Agent** est un systeme qui utilise un LLM comme moteur de raisonnement et qui est capable d'**utiliser des outils**, de **planifier des etapes** et d'**agir dans son environnement** pour accomplir un objectif donne.

La difference fondamentale avec un LLM seul : l'agent **fait des choses** dans le monde, pas seulement des mots.

```mermaid
flowchart TD
    OBJ["Objectif donne par l'utilisateur"]
    OBJ --> BRAIN["LLM\n(cerveau de l'agent)\nRaisonnement et planification"]

    BRAIN --> PLAN["Plan d'action\n(decomposition en etapes)"]

    PLAN --> TOOL{Quel outil\nutiliser ?}

    TOOL --> T1["Recherche web\n(Bing, Google)"]
    TOOL --> T2["Execution de code\n(Python, terminal)"]
    TOOL --> T3["Appel d'API\n(meteo, base de donnees)"]
    TOOL --> T4["Lecture/ecriture\nde fichiers"]
    TOOL --> T5["Envoi d'email\nou message"]

    T1 & T2 & T3 & T4 & T5 --> OBS["Observation\n(resultat de l'action)"]
    OBS --> BRAIN

    BRAIN --> FIN{Objectif\natteint ?}
    FIN -- Oui --> REP["Reponse finale\na l'utilisateur"]
    FIN -- Non --> PLAN
```

---

### Les composants d'un agent

| Composant | Role | Exemple |
|-----------|------|---------|
| **LLM (cerveau)** | Raisonne, planifie, decide | GPT-4, Claude, Mistral |
| **Outils (tools)** | Actions que l'agent peut effectuer | Recherche web, calculatrice, API |
| **Memoire** | Retient le contexte et l'historique | Memoire court terme (contexte), long terme (base vectorielle) |
| **Planificateur** | Decompose les objectifs en sous-taches | ReAct, Chain-of-Thought |
| **Observateur** | Analyse les resultats des actions | Feedback loop |

#### Les deux types de memoire d'un agent

```mermaid
flowchart LR
    subgraph CT["Memoire court terme"]
        C1["Fenetre de contexte\ndu LLM\nConversation en cours\n(4K a 1M tokens)"]
    end
    subgraph LT["Memoire long terme"]
        L1["Base de donnees vectorielle\n(Chroma, Pinecone, Weaviate)\nInformations persistantes\nentre les sessions"]
    end
    subgraph EXT["Memoire externe"]
        E1["Fichiers, bases de donnees\nNotes, documents"]
    end

    CT <--> LT
    CT <--> EXT
```

---

### Types d'agents

| Type | Description | Exemple |
|------|-------------|---------|
| **Agent ReAct** | Raisonne (Reason) puis agit (Act) en boucle | Agent de recherche qui cherche et synthetise |
| **Agent planificateur** | Cree un plan complet avant d'agir | Planification de projet |
| **Agent executeur de code** | Ecrit et execute du code Python pour resoudre des problemes | Data analyst agent |
| **Agent conversationnel** | Maintient une conversation avec memoire | Assistant personnel |
| **Agent RAG** | Recupere des documents pertinents avant de repondre | Chatbot sur documentation interne |

#### Le pattern ReAct (Reason + Act)

```
Pensee  : Je dois trouver la population de Montreal en 2026.
Action  : recherche_web("population Montreal 2026")
Observation : "La population de Montreal est estimee a 2,1 millions en 2026."
Pensee  : J'ai l'information. Je peux repondre.
Reponse : La population de Montreal est d'environ 2,1 millions d'habitants en 2026.
```

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-4"></a>

<details>
<summary><strong>4 — Agentic AI — IA agentique</strong></summary>

<br/>

### Definition

L'**Agentic AI** (IA agentique) designe un **paradigme** — une facon de concevoir des systemes IA — ou un ou plusieurs agents operent avec un **haut degre d'autonomie**, sur des **taches longues et complexes**, en boucle, avec peu ou pas d'intervention humaine a chaque etape.

Ce n'est pas un produit specifique. C'est une architecture de systeme.

---

### Ce qui distingue l'Agentic AI

| Caracteristique | Agent IA simple | Agentic AI |
|----------------|----------------|------------|
| **Duree de la tache** | Quelques echanges | Heures, jours, semaines |
| **Autonomie** | Moderee — l'humain supervise | Elevee — l'agent decide seul de nombreuses etapes |
| **Nombre d'agents** | Un seul | Plusieurs agents coordonnes |
| **Memoire** | Court terme (contexte) | Long terme, persistante entre sessions |
| **Planification** | Simple | Multi-niveaux, avec revision du plan |
| **Gestion des erreurs** | Limitee | L'agent detecte et corrige ses erreurs |
| **Interaction humaine** | Apres chaque etape | Seulement aux points de decision critiques (HITL) |

---

### La boucle agentique

```mermaid
flowchart TD
    MISSION["Mission a long terme\ndonnee par l'humain"]
    MISSION --> DECOMP["Decomposition\nen sous-objectifs"]
    DECOMP --> ASSIGN["Attribution\naux agents specialises"]

    subgraph BOUCLE["Boucle agentique autonome"]
        EXEC["Execution\nd'une sous-tache"]
        EVAL["Evaluation\ndu resultat"]
        REPLAN["Replanification\nsi necessaire"]
        EXEC --> EVAL --> REPLAN --> EXEC
    end

    ASSIGN --> BOUCLE

    BOUCLE --> HITL{Point de\ndecision critique ?}
    HITL -- Oui --> HUMAN["Validation\nhumaine (HITL)"]
    HUMAN --> BOUCLE
    HITL -- Non --> NEXT["Sous-tache\nsuivante"]
    NEXT --> DONE{Mission\nterminee ?}
    DONE -- Non --> ASSIGN
    DONE -- Oui --> RESULT["Livrable final"]
```

> **HITL** = Human In The Loop — l'humain intervient uniquement aux etapes critiques.

---

### Multi-agent systems — Systemes multi-agents

Dans l'Agentic AI, plusieurs agents specialises collaborent comme une equipe.

```mermaid
flowchart TD
    ORCH["Agent orchestrateur\nChef de projet — coordonne les autres"]

    ORCH --> A1["Agent chercheur\nRecherche et collecte\nd'informations"]
    ORCH --> A2["Agent codeur\nEcrit et teste\ndu code"]
    ORCH --> A3["Agent critique\nEvalue la qualite\ndu travail des autres"]
    ORCH --> A4["Agent redacteur\nRedige le livrable final"]

    A1 -->|"Informations collectees"| ORCH
    A2 -->|"Code produit"| ORCH
    A3 -->|"Retours et corrections"| ORCH
    A4 -->|"Document final"| ORCH
```

#### Exemples de frameworks multi-agents

| Framework | Createur | Description |
|-----------|---------|-------------|
| **CrewAI** | CrewAI | Orchestration d'agents avec roles et objectifs definis |
| **AutoGen** | Microsoft | Agents qui se parlent entre eux pour resoudre des problemes |
| **LangGraph** | LangChain | Graphe d'etats pour des workflows agentiques complexes |
| **OpenAI Swarm** | OpenAI | Framework leger pour systemes multi-agents |
| **Agency Swarm** | Communaute | Agents avec memoire et communication structuree |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-5"></a>

<details>
<summary><strong>5 — Comparaison directe — LLM vs Agent vs Agentic AI</strong></summary>

<br/>

### Tableau comparatif complet

| Critere | LLM | AI Agent | Agentic AI |
|---------|-----|----------|------------|
| **Definition** | Modele de langage qui predit des tokens | Systeme base sur un LLM + outils | Paradigme de systemes autonomes a long terme |
| **Initiative** | Aucune — repond uniquement | Peut planifier des etapes | Opere de maniere independante sur de longues missions |
| **Outils externes** | Non (sauf plugins) | Oui | Oui — plusieurs types d'outils |
| **Nombre d'agents** | 1 modele | 1 agent | Plusieurs agents coordonnes |
| **Memoire** | Fenetre de contexte uniquement | Contexte + memoire externe | Memoire persistante multi-sessions |
| **Duree d'execution** | Secondes | Minutes | Heures a jours |
| **Supervision humaine** | A chaque echange | Moderee | Minimale (HITL aux points cles) |
| **Gestion des erreurs** | Aucune | Limitee | Correction autonome |
| **Exemple** | ChatGPT en mode chat | Agent de recherche Perplexity | Devin (agent de dev logiciel autonome) |

---

### Diagramme de positionnement

```mermaid
quadrantChart
    title Autonomie vs Complexite des taches
    x-axis Tache simple --> Tache complexe
    y-axis Supervision humaine totale --> Autonomie totale
    quadrant-1 Agentic AI
    quadrant-2 Supervision directe
    quadrant-3 Outils simples
    quadrant-4 AI Agent
    LLM simple: [0.15, 0.1]
    Chatbot avec outils: [0.3, 0.25]
    AI Agent ReAct: [0.55, 0.45]
    Agent multi-etapes: [0.65, 0.6]
    Systeme multi-agents: [0.8, 0.75]
    Agentic AI autonome: [0.9, 0.88]
```

---

### Analogie avec une equipe de travail

| Concept IA | Analogie |
|-----------|---------|
| **LLM** | Un expert tres qualifie qu'on consulte en face a face — il repond, mais ne fait rien si on ne lui demande pas |
| **AI Agent** | Un assistant personnel avec acces a un ordinateur, internet et votre agenda — il peut agir, mais reste sous supervision |
| **Agentic AI** | Une equipe entiere d'assistants specialises qui travaille sur un projet de plusieurs semaines, se coordonne et ne vous contacte que pour les decisions importantes |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-6"></a>

<details>
<summary><strong>6 — Comment ils s'articulent ensemble</strong></summary>

<br/>

LLM, AI Agent et Agentic AI ne sont pas des alternatives — ils s'imbriquent l'un dans l'autre.

```mermaid
flowchart TD
    subgraph AGENTIC_SYS["Systeme Agentic AI"]
        subgraph AGENT1["Agent 1 — Chercheur"]
            LLM1["LLM\n(GPT-4o)"] --> TOOLS1["Outils\n(web search, API)"]
        end
        subgraph AGENT2["Agent 2 — Codeur"]
            LLM2["LLM\n(Claude)"] --> TOOLS2["Outils\n(Python executor, GitHub)"]
        end
        subgraph AGENT3["Agent 3 — Critique"]
            LLM3["LLM\n(Mistral)"] --> TOOLS3["Outils\n(linter, tests)"]
        end
        ORCH2["Orchestrateur\n(LangGraph / CrewAI)"]
        MEM["Memoire partagee\n(base vectorielle)"]

        ORCH2 --> AGENT1
        ORCH2 --> AGENT2
        ORCH2 --> AGENT3
        AGENT1 & AGENT2 & AGENT3 <--> MEM
    end

    USER["Utilisateur"] --> AGENTIC_SYS
    AGENTIC_SYS --> RESULT2["Livrable final"]
```

---

### La progression naturelle

```mermaid
flowchart LR
    S1["Niveau 1\nLLM seul\nQ&R simples\nResume, traduction"]
    S2["Niveau 2\nLLM + outils\nRecherche web\nCalculatrice, API"]
    S3["Niveau 3\nAI Agent\nPlanification\nBoucle ReAct"]
    S4["Niveau 4\nAgent autonome\nTaches longues\nCorrection d'erreurs"]
    S5["Niveau 5\nAgentic AI\nMulti-agents\nMissions complexes"]

    S1 --> S2 --> S3 --> S4 --> S5
```

> A mesure que le niveau augmente : plus de puissance, mais aussi plus de risques, plus de couts et plus de complexite de supervision.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-7"></a>

<details>
<summary><strong>7 — Limites et risques</strong></summary>

<br/>

### Limites des LLMs

| Limite | Description |
|--------|-------------|
| **Hallucinations** | Le modele genere des informations fausses avec confiance |
| **Coupure temporelle** | Pas de connaissance des evenements apres la date de training |
| **Absence de memoire** | Oublie tout entre deux conversations (sans memoire externe) |
| **Pas de raisonnement causal** | Correlations statistiques, pas de comprehension reelle |
| **Sensible aux biais** | Reproduit les biais presents dans les donnees d'entrainement |
| **Couts** | Chaque token genere a un cout financier et energetique |

---

### Risques specifiques aux agents et a l'Agentic AI

```mermaid
flowchart TD
    RISQUES["Risques de l'Agentic AI"]

    RISQUES --> R1["Prompt injection\nUn contenu malveillant detourne\nles actions de l'agent"]
    RISQUES --> R2["Escalade de privileges\nL'agent obtient plus de permissions\nque prevu"]
    RISQUES --> R3["Boucle infinie\nL'agent tourne sans\natteindre l'objectif"]
    RISQUES --> R4["Actions irreversibles\nSuppression de fichiers,\nenvoi d'emails, transactions"]
    RISQUES --> R5["Cout exponentiel\nLes boucles longues\nconsomment beaucoup de tokens"]
    RISQUES --> R6["Opacite\nDifficile de savoir pourquoi\nl'agent a pris une decision"]
```

---

### Tableau des risques et mitigation

| Risque | Mitigation |
|--------|-----------|
| **Hallucinations** | RAG, grounding sur des sources verifiees, validation humaine |
| **Prompt injection** | Validation des entrees, sandboxing des outils |
| **Actions irreversibles** | Mode simulation avant action, validation HITL |
| **Boucle infinie** | Limite de tokens et d'iterations |
| **Couts eleves** | Monitoring des couts, modeles plus petits pour les sous-taches simples |
| **Opacite** | Logging de chaque etape, traces d'execution |

---

### La question de la confiance et du controle

Plus un systeme est agentique, plus la question du controle humain est critique.

| Niveau d'autonomie | Modele de supervision |
|-------------------|----------------------|
| LLM seul | L'humain lit et valide chaque reponse |
| AI Agent | L'humain supervise le plan et les etapes cles |
| Agentic AI | HITL aux decisions critiques — le reste est autonome |
| Super-agentic (futur) | Supervision difficile — risque systemique |

> La plupart des experts recommandent de maintenir un **humain dans la boucle** pour toute action ayant des consequences reelles et irreversibles.

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-8"></a>

<details>
<summary><strong>8 — Cas d'usage concrets par type</strong></summary>

<br/>

### Quand utiliser un LLM seul ?

| Cas d'usage | Pourquoi un LLM suffit |
|-------------|----------------------|
| Resumer un document | Tache discrete, une seule entree |
| Traduire un texte | Pas besoin d'action externe |
| Repondre a des FAQ | Les reponses sont dans le contexte ou le modele |
| Generer du code a partir d'une description | L'humain copie-colle et execute lui-meme |
| Classifier un email | Entree unique, sortie unique |

---

### Quand utiliser un AI Agent ?

| Cas d'usage | Ce que l'agent apporte |
|-------------|----------------------|
| Rechercher et synthetiser des informations recentes | Acces au web en temps reel |
| Analyser un fichier CSV et produire un rapport | Execution de code Python |
| Reserver un vol selon des criteres | Appel d'APIs externes |
| Monitorer un site web et alerter en cas de changement | Boucle d'execution periodique |
| Repondre a des questions sur une base documentaire interne | RAG + recherche semantique |

---

### Quand utiliser l'Agentic AI ?

| Cas d'usage | Pourquoi l'Agentic AI est necessaire |
|-------------|-------------------------------------|
| Developper une fonctionnalite logicielle de A a Z | Necessite recherche, code, tests, revue — plusieurs agents |
| Conduire une analyse de marche complete | Collecte de donnees, analyse, redaction — taches paralleles |
| Automatiser un pipeline de recrutement | Tri de CV, entretiens preliminaires, rapports — agents specialises |
| Gerer un projet de contenu editorial | Recherche, redaction, relecture, publication — workflow long |
| Supporter le cycle de vie d'un projet IA | Collecte, nettoyage, entrainement, evaluation, deploiement — automatise |

---

### Exemples de produits reels en 2026

| Produit | Type | Ce qu'il fait |
|---------|------|---------------|
| **ChatGPT** (sans plugins) | LLM | Conversation, generation de texte et code |
| **Perplexity AI** | AI Agent | Recherche web + synthese |
| **GitHub Copilot** | AI Agent | Completion et generation de code avec contexte du repo |
| **Devin** (Cognition) | Agentic AI | Developpement logiciel autonome de bout en bout |
| **Operator** (OpenAI) | Agentic AI | Navigation web autonome, remplissage de formulaires |
| **Claude Computer Use** | Agentic AI | Controle d'un ordinateur comme un humain |
| **Microsoft Copilot Agents** | Agentic AI | Workflows automatises dans Office 365 |

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>

---

<a id="section-9"></a>

<details>
<summary><strong>9 — Quiz de consolidation</strong></summary>

<br/>

Pour chaque question, choisissez la meilleure reponse puis ouvrez l'explication.

---

**Question 1** — Un etudiant ouvre ChatGPT, pose une question sur Python et obtient une reponse. Quel type de systeme utilise-t-il ?

A) Un AI Agent  
B) Un LLM  
C) Un systeme Agentic AI  
D) Un systeme multi-agents

<details>
<summary>Reponse et explication</summary>

**Reponse : B — Un LLM**

ChatGPT en mode conversation standard est un LLM. Il repond a une entree sans initier d'actions, sans outils externes (sauf si des plugins sont actives) et sans planification multi-etapes. C'est le niveau le plus simple.

</details>

---

**Question 2** — Perplexity AI recoit une question, effectue plusieurs recherches web, consulte des sources, les synthetise et produit une reponse avec citations. Quel type de systeme est-ce ?

A) Un LLM seul  
B) Un AI Agent  
C) Un systeme Agentic AI  
D) Un modele de diffusion

<details>
<summary>Reponse et explication</summary>

**Reponse : B — Un AI Agent**

Perplexity utilise un LLM comme moteur de raisonnement, mais ajoute des outils de recherche web. Il planifie des etapes (chercher, lire, synthetiser) et agit dans son environnement (internet). C'est la definition d'un AI Agent.

</details>

---

**Question 3** — Devin recoit comme mission "cree une API REST pour gerer des utilisateurs, avec tests et documentation", travaille pendant 2 heures en ecrivant du code, en executant des tests, en corrigeant ses erreurs, et livre un projet fonctionnel. Quel type de systeme est-ce ?

A) Un LLM  
B) Un AI Agent simple  
C) Un systeme Agentic AI  
D) Un systeme expert

<details>
<summary>Reponse et explication</summary>

**Reponse : C — Un systeme Agentic AI**

Devin opere de maniere autonome sur une mission longue, planifie de nombreuses sous-taches, utilise plusieurs outils (editeur de code, terminal, navigateur), detecte et corrige ses propres erreurs sans intervention humaine a chaque etape. C'est le paradigme Agentic AI.

</details>

---

**Question 4** — Quelle est la difference principale entre un AI Agent et un LLM ?

A) Un AI Agent utilise un modele plus grand  
B) Un AI Agent peut agir dans son environnement grace a des outils  
C) Un AI Agent ne peut pas generer de texte  
D) Un LLM est plus autonome qu'un AI Agent

<details>
<summary>Reponse et explication</summary>

**Reponse : B**

La difference fondamentale est la capacite d'**action**. Un LLM genere du texte en reponse a une entree. Un AI Agent utilise ce LLM comme cerveau mais peut en plus appeler des outils (web, code, APIs, fichiers) pour agir dans le monde reel. L'AI Agent est construit **autour** du LLM.

</details>

---

**Question 5** — Dans un systeme Agentic AI, qu'est-ce que le HITL ?

A) Un type de modele de langage  
B) Un outil de recherche web  
C) Le moment ou un humain intervient pour valider une decision critique  
D) Une technique d'entrainement

<details>
<summary>Reponse et explication</summary>

**Reponse : C**

**HITL** (Human In The Loop) designe les points dans le workflow agentique ou l'intervention humaine est requise avant de continuer. Par exemple, avant qu'un agent envoie un email important, supprime des fichiers ou effectue une transaction financiere. C'est le mecanisme de controle qui permet de garder l'humain responsable des decisions critiques.

</details>

</details>

<p align="right"><a href="#top">↑ Retour en haut</a></p>
