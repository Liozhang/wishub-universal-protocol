# WisHub Universal Protocol

**Version**: v3.0.0
**Type de document**: Spécification du protocole universel

---

## 📖 Aperçu du projet

**Construire des unités de sagesse et un centre de connexion pour accélérer la construction de la sagesse collective de l'humanité.**

Le protocole universel WisHub définit les spécifications du protocole de base pour l'écosystème WisHub.

**Navigation rapide**:
- [Démarrage rapide](#-démarrage-rapide) - Commencer en 3 minutes
- [Documentation](#-documentation) - Spécifications de protocole détaillées
- [FAQ](#-faq) - Questions fréquentes

> 🌐 Lire dans d'autres langues:
> - [English](README.md) 🇺🇸
> - [中文](README_CN.md) 🇨🇳
> - [日本語](README_JA.md) 🇯🇵

---

## 📚 Documentation

- [Normes de protocole](docs/01-introduction.md) - Normes de protocole
- [Protocole WisUnit](docs/02-wisunit.md) - Protocole WisUnit
- [Système de protocole WISE](docs/03-wise.md) - Système de protocole WISE
- [Protocole d'intelligence de base](docs/04-core-intelligence.md) - Protocole d'intelligence de base
- [Protocole Agent](docs/05-agent.md) - Protocole Agent
- [Protocole de graphe de connaissances](docs/06-knowledge-graph.md) - Protocole de graphe de connaissances
- [Protocole de communication](docs/07-communication.md) - Protocole de communication
- [Protocole de sécurité](docs/08-security.md) - Protocole de sécurité
- [Protocole d'extension de domaine](docs/09-domain-extension.md) - Protocole d'extension de domaine
- [Protocole économique](docs/10-economy.md) - Protocole économique
- [Protocole de déploiement](docs/11-deployment.md) - Protocole de déploiement
- [Protocole MCP/Skill](docs/12-mcp-skill.md) - Protocole MCP/Skill

---

## 🚀 Démarrage rapide

### Format standard de protocole

```json
{
  "protocol": "Nom du protocole",
  "version": "Version du protocole",
  "request_type": "Type de requête",
  "request": { ... },
  "response_type": "Type de réponse",
  "status": "Statut",
  "data": { ... },
  "message": "Message"
}
```

---

## 🌍 Communauté

- **GitHub**: [Liozhang/wishub-universal-protocol](https://github.com/Liozhang/wishub-universal-protocol)
- **Discord**: [Rejoindre](https://discord.gg/wishub)

---

## 📝 Licence

Ce projet est sous licence [GPL-3.0 License](LICENSE).

---

## ⚠️ Meilleures pratiques de sécurité

- Toujours utiliser la dernière version du SDK
- Mettre à jour régulièrement les dépendances
- Suivre le principe du moindre privilège
- Activer le chiffrement TLS 1.3 avec le chiffrement AES-256-GCM
- Utiliser des preuves zéro-connaissance pour protéger la confidentialité
- Valider toutes les requêtes et réponses
- Utiliser des variables d'environnement pour les données sensibles (clés API, jetons)
- Activer la limitation de débit pour prévenir les abus

### 🔒 Divulgation de vulnérabilités de sécurité

Si vous découvrez une vulnérabilité de sécurité, veuillez la signaler de manière responsable:

- **Email**: security@wishub.org
- **Sécurité GitHub**: [Utiliser les avis de sécurité GitHub](https://github.com/Liozhang/wishub-universal-protocol/security/advisories)

Veuillez inclure:
- Description de la vulnérabilité
- Étapes pour reproduire
- Versions affectées
- Correction suggérée (si disponible)

Nous répondrons dans les 48 heures et travaillerons avec vous pour résoudre le problème de manière responsable.

---

## ❓ FAQ

**Q: Qu'est-ce que WisHub?**
A: WisHub est un écosystème de partage de connaissances ouvert qui utilise des protocoles standardisés pour permettre une validation, un stockage, une récupération et une réutilisation efficaces des connaissances entre les agents IA.

**Q: Comment commencer?**
A: Consultez la section [Démarrage rapide](#-démarrage-rapide), puis explorez la [Documentation](#-documentation) pour les spécifications de protocole détaillées.

**Q: WisHub est-il open source?**
A: Oui, WisHub est sous licence [GPL-3.0](LICENSE).

**Q: Comment les données sont-elles protégées?**
A: WisHub utilise le chiffrement TLS 1.3, des preuves zéro-connaissance et des contrôles d'accès granulaires. Consultez la section [Meilleures pratiques de sécurité](#-meilleures-pratiques-de-sécurité).

**Q: Comment signaler une vulnérabilité de sécurité?**
A: Envoyez un email à security@wishub.org ou utilisez les [avis de sécurité GitHub](https://github.com/Liozhang/wishub-universal-protocol/security/advisories).

---

**WisHub Universal Protocol v3.0.0** | 23 février 2026
