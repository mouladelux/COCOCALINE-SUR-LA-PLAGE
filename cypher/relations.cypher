// A executé en 2eme (après nodes.cypher)


// 1. UTILISATEURS -> MACHINES (USES & ADMIN_OF)

MATCH (u:User {name: "Alice"}), (m:Machine {name: "PC-ALICE"}) CREATE (u)-[:USES]->(m);
MATCH (u:User {name: "Bob"}), (m:Machine {name: "PC-BOB"}) CREATE (u)-[:USES]->(m);
MATCH (u:User {name: "Thomas"}), (m:Machine {name: "PC-TOM"}) CREATE (u)-[:USES]->(m);
MATCH (u:User {name: "Paul"}), (m:Machine {name: "PC-PAUL"}) CREATE (u)-[:USES]->(m);

MATCH (u:User {name: "Charlie"}), (m:Machine {name: "DC-01"}) CREATE (u)-[:ADMIN_OF]->(m);
MATCH (u:User {name: "Charlie"}), (m:Machine {name: "FW-01"}) CREATE (u)-[:ADMIN_OF]->(m);


// 2. UTILISATEURS -> GROUPES (MEMBER_OF)

MATCH (u:User {name: "Alice"}), (g:Group {name: "RH"}) CREATE (u)-[:MEMBER_OF]->(g);
MATCH (u:User {name: "Bob"}), (g:Group {name: "DEV"}) CREATE (u)-[:MEMBER_OF]->(g);
MATCH (u:User {name: "Charlie"}), (g:Group {name: "ADMINS"}) CREATE (u)-[:MEMBER_OF]->(g);
MATCH (u:User {name: "Diana"}), (g:Group {name: "SECURITY"}) CREATE (u)-[:MEMBER_OF]->(g);
MATCH (u:User {name: "Thomas"}), (g:Group {name: "SECURITY"}) CREATE (u)-[:MEMBER_OF]->(g);
MATCH (u:User {name: "Paul"}), (g:Group {name: "EXTERNE"}) CREATE (u)-[:MEMBER_OF]->(g);


// 3. GROUPES -> MACHINES (HAS_ACCESS_TO)

MATCH (g:Group {name: "RH"}), (m:Machine {name: "SRV-WEB"}) CREATE (g)-[:HAS_ACCESS_TO]->(m);
MATCH (g:Group {name: "DEV"}), (m:Machine {name: "SRV-DB"}) CREATE (g)-[:HAS_ACCESS_TO]->(m);
MATCH (g:Group {name: "ADMINS"}), (m:Machine {name: "DC-01"}) CREATE (g)-[:HAS_ACCESS_TO]->(m);
MATCH (g:Group {name: "ADMINS"}), (m:Machine {name: "NAS-BACKUP"}) CREATE (g)-[:HAS_ACCESS_TO]->(m);
MATCH (g:Group {name: "EXTERNE"}), (m:Machine {name: "SRV-VPN"}) CREATE (g)-[:HAS_ACCESS_TO]->(m);


// 4. CONNEXIONS RESEAU (CONNECTED_TO) -> LES CHEMINS D'ATTAQUE

// Chemin classique (compromission de depart)
MATCH (a:Machine {name: "PC-ALICE"}), (b:Machine {name: "SRV-WEB"}) CREATE (a)-[:CONNECTED_TO]->(b);
MATCH (a:Machine {name: "PC-BOB"}), (b:Machine {name: "SRV-WEB"}) CREATE (a)-[:CONNECTED_TO]->(b);
MATCH (a:Machine {name: "SRV-WEB"}), (b:Machine {name: "SRV-DB"}) CREATE (a)-[:CONNECTED_TO]->(b);
MATCH (a:Machine {name: "SRV-DB"}), (b:Machine {name: "DC-01"}) CREATE (a)-[:CONNECTED_TO]->(b);
MATCH (a:Machine {name: "SRV-DB"}), (b:Machine {name: "NAS-BACKUP"}) CREATE (a)-[:CONNECTED_TO]->(b);

// Nouveau chemin via le VPN (attaque externe)
MATCH (a:Machine {name: "PC-PAUL"}), (b:Machine {name: "FW-01"}) CREATE (a)-[:CONNECTED_TO]->(b);
MATCH (a:Machine {name: "FW-01"}), (b:Machine {name: "SRV-VPN"}) CREATE (a)-[:CONNECTED_TO]->(b);
MATCH (a:Machine {name: "SRV-VPN"}), (b:Machine {name: "SRV-DB"}) CREATE (a)-[:CONNECTED_TO]->(b); // Le VPN permet d'acceder a la base de donnees


// 5. MACHINES -> SERVICES EXPOSES (EXPOSES)

MATCH (m:Machine {name: "SRV-WEB"}), (s:Service {name: "HTTP"}) CREATE (m)-[:EXPOSES]->(s);
MATCH (m:Machine {name: "SRV-WEB"}), (s:Service {name: "HTTPS"}) CREATE (m)-[:EXPOSES]->(s);
MATCH (m:Machine {name: "SRV-DB"}), (s:Service {name: "MongoDB"}) CREATE (m)-[:EXPOSES]->(s);
MATCH (m:Machine {name: "DC-01"}), (s:Service {name: "SMB"}) CREATE (m)-[:EXPOSES]->(s);
MATCH (m:Machine {name: "PC-BOB"}), (s:Service {name: "RDP"}) CREATE (m)-[:EXPOSES]->(s);
MATCH (m:Machine {name: "SRV-VPN"}), (s:Service {name: "OpenVPN"}) CREATE (m)-[:EXPOSES]->(s);


// 6. MACHINES -> VULNERABILITES (HAS_VULNERABILITY)

MATCH (m:Machine {name: "SRV-WEB"}), (v:Vulnerability {cve: "CVE-2021-44228"}) CREATE (m)-[:HAS_VULNERABILITY]->(v);
MATCH (m:Machine {name: "SRV-WEB"}), (v:Vulnerability {cve: "CVE-2022-22965"}) CREATE (m)-[:HAS_VULNERABILITY]->(v);
MATCH (m:Machine {name: "PC-BOB"}), (v:Vulnerability {cve: "CVE-2019-0708"}) CREATE (m)-[:HAS_VULNERABILITY]->(v);
MATCH (m:Machine {name: "DC-01"}), (v:Vulnerability {cve: "CVE-2020-1472"}) CREATE (m)-[:HAS_VULNERABILITY]->(v);
MATCH (m:Machine {name: "NAS-BACKUP"}), (v:Vulnerability {cve: "CVE-2023-0001"}) CREATE (m)-[:HAS_VULNERABILITY]->(v);
MATCH (m:Machine {name: "SRV-VPN"}), (v:Vulnerability {cve: "CVE-2018-13379"}) CREATE (m)-[:HAS_VULNERABILITY]->(v);


// 7. MACHINES -> RESSOURCES HEBERGEES (HOSTS)

MATCH (m:Machine {name: "SRV-DB"}), (r:Resource {name: "Base clients"}) CREATE (m)-[:HOSTS]->(r);
MATCH (m:Machine {name: "SRV-DB"}), (r:Resource {name: "Secrets applicatifs"}) CREATE (m)-[:HOSTS]->(r);
MATCH (m:Machine {name: "SRV-DB"}), (r:Resource {name: "Code source"}) CREATE (m)-[:HOSTS]->(r);
MATCH (m:Machine {name: "DC-01"}), (r:Resource {name: "Active Directory"}) CREATE (m)-[:HOSTS]->(r);
MATCH (m:Machine {name: "NAS-BACKUP"}), (r:Resource {name: "Sauvegardes"}) CREATE (m)-[:HOSTS]->(r);
MATCH (m:Machine {name: "SRV-WEB"}), (r:Resource {name: "Donnees RH"}) CREATE (m)-[:HOSTS]->(r);