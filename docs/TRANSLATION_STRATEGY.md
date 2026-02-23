# WisHub Protocol Documents - Multilingual Translation Strategy

## 📋 Overview

This document outlines the strategy for translating WisHub protocol documents from English to multiple languages (Chinese, Japanese, French, etc.) to support the global developer community.

---

## 🏗️ 1. Naming Convention

**Consistent with README.md:**

- **English version (source)**: `02-wisunit.md`
- **Chinese version**: `02-wisunit_CN.md`
- **Japanese version**: `02-wisunit_JA.md`
- **French version**: `02-wisunit_FR.md`

**Benefits:**
- ✅ Consistent with README naming (`README_CN.md`, `README_JA.md`, `README_FR.md`)
- ✅ Easy to identify language versions
- ✅ Simple file management
- ✅ Clear source document identification (no suffix = English)

---

## 📊 2. Translation Priority

Based on document importance and expected readership:

### P0 - Must Translate (High Priority)

| Document | Lines | Size | Priority | Target Languages |
|----------|-------|------|----------|------------------|
| **01-introduction.md** | 107 | 2.7KB | P0 | CN, JA, FR |
| **02-wisunit.md** | 1528 | 47KB | P0 | CN, JA, FR |
| **03-wise.md** | 351 | 8.5KB | P0 | CN, JA, FR |
| **05-agent.md** | 254 | 5.8KB | P0 | CN, JA, FR |
| **07-communication.md** | 150 | 3.1KB | P0 | CN, JA, FR |

### P1 - Important Translate

| Document | Lines | Size | Priority | Target Languages |
|----------|-------|------|----------|------------------|
| **04-core-intelligence.md** | 211 | 5.2KB | P1 | CN |
| **06-knowledge-graph.md** | 103 | 2.4KB | P1 | CN |
| **08-security.md** | 217 | 4.8KB | P1 | CN |
| **10-economy.md** | 165 | 3.6KB | P1 | CN |
| **11-deployment.md** | 230 | 5.3KB | P1 | CN |
| **12-mcp-skill.md** | 788 | 20KB | P1 | CN |

### P2 - Optional Translate

| Document | Lines | Size | Priority | Target Languages |
|----------|-------|------|----------|------------------|
| **09-domain-extension.md** | 930 | 29KB | P2 | CN |

---

## 🌐 3. Target Languages

### Phase 1 - Primary Languages (Now)
- **Chinese (CN)** - User primary requirement, largest user base
- **Japanese (JA)** - Important Asian market
- **French (FR)** - European market

### Phase 2 - Secondary Languages (Future)
- **Spanish (ES)**
- **German (DE)**
- **Korean (KO)**
- **Portuguese (PT)**
- **Russian (RU)**

---

## 🔧 4. Translation Strategy

### 4.1 Hybrid Approach

**Recommended: AI-assisted + Human Review**

1. **Initial Translation (AI)**: Use Claude, GPT-4, or DeepL API for initial translation
2. **Technical Review**: Technical experts review terminology and accuracy
3. **Community Review**: Community contributors review and suggest improvements
4. **Final Approval**: Project maintainer approves and merges

**Why this approach?**
- ✅ Fast initial translation (AI can handle bulk work)
- ✅ Technical accuracy (human review ensures correct terminology)
- ✅ Community engagement (open to contributions)
- ✅ Quality assurance (multi-stage review)

### 4.2 Translation Tools

**AI Translation:**
- **Claude API** - High quality technical translation
- **GPT-4 API** - Strong technical understanding
- **DeepL API** - Professional translation service

**Quality Assurance:**
- **Glossary** - Maintain consistent terminology
- **Style Guide** - Ensure consistent voice and format
- **Comparison Tool** - Compare translations for consistency

---

## 📚 5. Glossary and Terminology

### 5.1 Core Terminology

| English | Chinese | Japanese | French |
|---------|----------|-----------|---------|
| WisUnit | WisUnit | WisUnit | WisUnit |
| WISE Protocol | WISE协议 | WISEプロトコル | Protocole WISE |
| Agent | Agent | エージェント | Agent |
| Knowledge Graph | 知识图谱 | ナレッジグラフ | Graphe de connaissances |
| MCP (Model Context Protocol) | MCP (模型上下文协议) | MCP (モデルコンテキストプロトコル) | MCP (Protocole de contexte de modèle) |
| Skill | Skill | スキル | Skill |
| CRUD | CRUD | CRUD | CRUD |
| API | API | API | API |
| SDK | SDK | SDK | SDK |

### 5.2 Maintain Glossary

Create `docs/glossary.md` for each language:
- `docs/glossary.md` - English (source)
- `docs/glossary_CN.md` - Chinese
- `docs/glossary_JA.md` - Japanese
- `docs/glossary_FR.md` - French

---

## 🔄 6. Workflow: English Update → Multilingual Sync

### 6.1 Update Process

```
1. Update English Document (02-wisunit.md)
   ↓
2. Create Pull Request
   ↓
3. Review and Merge to main
   ↓
4. Trigger Translation Task
   ↓
5. AI-assisted Initial Translation
   ↓
6. Technical Review
   ↓
7. Community Review (optional)
   ↓
8. Merge Multilingual Versions
```

### 6.2 Automation Tools

**GitHub Actions:**
```yaml
# .github/workflows/translate.yml
on:
  push:
    paths:
      - 'docs/*.md'
    branches: [main]

jobs:
  translate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Detect changed docs
        run: |
          # Detect which docs changed
          # Trigger translation workflow
      - name: AI Translation
        run: |
          # Use Claude/GPT-4 API to translate
      - name: Create PR
        run: |
          # Create PR for multilingual versions
```

**Manual Trigger:**
```bash
# Translation script
./scripts/translate.sh 02-wisunit.md CN,JA,FR
```

---

## 📁 7. Directory Structure

```
wisub-universal-protocol/
├── docs/
│   ├── 01-introduction.md              # English (source)
│   ├── 01-introduction_CN.md          # Chinese
│   ├── 01-introduction_JA.md          # Japanese
│   ├── 01-introduction_FR.md          # French
│   ├── 02-wisunit.md                 # English (source)
│   ├── 02-wisunit_CN.md             # Chinese
│   ├── 02-wisunit_JA.md             # Japanese
│   ├── 02-wisunit_FR.md             # French
│   ├── ...
│   ├── glossary.md                   # English glossary
│   ├── glossary_CN.md               # Chinese glossary
│   ├── glossary_JA.md               # Japanese glossary
│   ├── glossary_FR.md               # French glossary
│   └── TRANSLATION_STRATEGY.md       # This file
├── README.md                         # English (source)
├── README_CN.md                     # Chinese
├── README_JA.md                     # Japanese
├── README_FR.md                     # French
└── .github/
    └── workflows/
        └── translate.yml            # Automated translation
```

---

## 🚀 8. Implementation Plan

### Phase 1: Quick Start (P0 Documents)

**Week 1:**
- Create glossary for all languages
- Translate 01-introduction.md (CN, JA, FR)
- Translate 02-wisunit.md (CN only)

**Week 2:**
- Translate 03-wise.md (CN, JA, FR)
- Translate 05-agent.md (CN, JA, FR)
- Translate 07-communication.md (CN, JA, FR)

### Phase 2: Expand (P1 Documents)

**Week 3-4:**
- Translate remaining P1 documents to Chinese
- Review and refine all translations

### Phase 3: Complete (P2 + Polish)

**Week 5+:**
- Translate 09-domain-extension.md (CN)
- Polish all translations
- Set up automated translation workflow

---

## 👥 9. Community Contributions

### 9.1 How to Contribute

1. **Fork the repository**
2. **Translate a document**: Use glossary as reference
3. **Create PR**: Submit your translation for review
4. **Review**: Maintainers will review and merge

### 9.2 Translation Guidelines

- ✅ Use official glossary terminology
- ✅ Maintain original markdown structure
- ✅ Preserve code examples (do not translate code)
- ✅ Translate comments and explanations
- ✅ Keep technical accuracy

### 9.3 Review Process

1. **Automated Check**: Ensure markdown syntax is correct
2. **Technical Review**: Verify technical terminology
3. **Consistency Check**: Compare with glossary
4. **Community Review**: Open to community feedback

---

## 📝 10. Quality Assurance

### 10.1 Translation Quality Checklist

- [ ] All terminology matches glossary
- [ ] Technical accuracy verified
- [ ] Markdown format preserved
- [ ] Code examples not translated
- [ ] Links work correctly
- [ ] No missing sections
- [ ] Consistent voice and style

### 10.2 Continuous Improvement

- **Collect Feedback**: Users report translation issues
- **Update Glossary**: Add new terms as protocol evolves
- **Regular Review**: Review and update translations periodically
- **Community Testing**: Let community test translations

---

## 🎯 11. Success Metrics

- ✅ All P0 documents translated to CN, JA, FR
- ✅ All P1 documents translated to CN
- ✅ Glossary created and maintained
- ✅ Automated translation workflow set up
- ✅ Community contributes to translations
- ✅ Translation quality score > 90%

---

## 📞 12. Contact

For translation questions or contributions:
- **GitHub Issues**: https://github.com/Liozhang/wishub-universal-protocol/issues
- **Discussions**: https://github.com/Liozhang/wishub-universal-protocol/discussions

---

**Last Updated**: 2026-02-23
**Version**: 1.0.0
