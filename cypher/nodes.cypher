//A exécuté en premier (avant le fichier relations.cypher)


// 1. Nettoyage de la base 
MATCH (n) DETACH DELETE n;

// 2. Importation des Utilisateurs
LOAD CSV WITH HEADERS FROM 'file:///users.csv' AS row
CREATE (:User {name: row.nom, role: row.role});

// 3. Importation des Machines
LOAD CSV WITH HEADERS FROM 'file:///machines.csv' AS row
CREATE (:Machine {name: row.nom, type: row.type, criticality: row.criticite});

// 4. Importation des Groupes
LOAD CSV WITH HEADERS FROM 'file:///groupes.csv' AS row
CREATE (:Group {name: row.nom, description: row.description});

// 5. Importation des Services
LOAD CSV WITH HEADERS FROM 'file:///services.csv' AS row
CREATE (:Service {name: row.nom, port: toInteger(row.port)});

// 6. Importation des Vulnerabilites
LOAD CSV WITH HEADERS FROM 'file:///vulnerabilites.csv' AS row
CREATE (:Vulnerability {cve: row.cve, name: row.nom, score: toFloat(row.score), description: row.description});

// 7. Importation des Ressources
LOAD CSV WITH HEADERS FROM 'file:///ressources.csv' AS row
CREATE (:Resource {name: row.nom, sensitivity: row.sensibilite});