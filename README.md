Au sujet des fichier CSV et CYPHER


`import/` : Contient les 6 fichiers `.csv` (données brutes sans accents, formatées pour Neo4j).
`cypher/` : Contient les scripts d'initialisation et de création des relations.

J'ai ajouté un vecteur d'attaque externe inédit (un prestataire, un Firewall, et un serveur VPN avec une faille critique de fuite d'identifiants) pour complexifier l'analyse cyber !

Comment lancer le projet:

1. Démarrer Neo4j :
   Lancez le conteneur Docker via la commande `docker-compose up -d`.

2. Placement des fichiers de données :
   Assurez-vous que le dossier `import/` de ce dépôt est bien monté et lié au dossier `/var/lib/neo4j/import` du conteneur Docker. Il faut bien respecter cette arborescence pour que que Neo4j puisse aller recupérer les fichier CSC

3. Exécution des scripts :
   Connectez-vous au Neo4j Browser et exécutez les scripts suivants dans cet ordre:
   * Ouvrez `cypher/nodes.cypher` et exécutez le code pour créer tous les nœuds depuis les CSV.
   * Ouvrez `cypher/relations.cypher` et exécutez le code pour tisser le maillage du réseau (utilisateurs, machines, failles).

4. Vérification :
   Tapez `MATCH (n) RETURN n;` pour visualiser le réseau complet de CyberCorp.

 Phase d'Analyse 

La base de données est prête à être exploitée. Deux points d'entrée principaux ont été modélisés pour tes chemins d'attaque :
1. L'attaque interne: Depuis la compromission initiale du `PC-ALICE`.
2. L'attaque externe: Depuis le compte du prestataire `Paul`, en exploitant la faille du `SRV-VPN`.
