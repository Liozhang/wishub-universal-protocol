# WisHub Universal Protocol

**バージョン**: v3.0.0
**ドキュメントタイプ**: ユニバーサルプロトコル仕様

---

## 📖 プロジェクト概要

**知恵ユニットと知恵接続ハブを構築し、全人類の集合的知恵の構築を加速する。**

WisHubユニバーサルプロトコルは、WisHubエコシステムのコアプロトコル仕様を定義します。

**クイックナビゲーション**:
- [クイックスタート](#-クイックスタート) - 3分で始めよう
- [ドキュメント](#-ドキュメント) - 詳細なプロトコル仕様
- [FAQ](#-faq) - よくある質問

> 🌐 他の言語で読む:
> - [English](README.md) 🇺🇸
> - [中文](README_CN.md) 🇨🇳
> - [Français](README_FR.md) 🇫🇷

---

## 📚 ドキュメント

- [Protocol Standards](docs/01-introduction.md)
- [WisUnit Protocol](docs/02-wisunit.md)
- [WISE Protocol System](docs/03-wise.md)
- [Core Intelligence Protocol](docs/04-core-intelligence.md)
- [Agent Protocol](docs/05-agent.md)
- [Knowledge Graph Protocol](docs/06-knowledge-graph.md)
- [Communication Protocol](docs/07-communication.md)
- [Security Protocol](docs/08-security.md)
- [Domain Extension Protocol](docs/09-domain-extension.md)
- [Economy Protocol](docs/10-economy.md)
- [Deployment Protocol](docs/11-deployment.md)
- [MCP/Skill Protocol](docs/12-mcp-skill.md)

---

## 🚀 クイックスタート

### プロトコル標準フォーマット

```json
{
  "protocol": "プロトコル名",
  "version": "プロトコルバージョン",
  "request_type": "リクエストタイプ",
  "request": { ... },
  "response_type": "レスポンスタイプ",
  "status": "ステータス",
  "data": { ... },
  "message": "メッセージ"
}
```

---

## 🌍 コミュニティ

- **GitHub**: [Liozhang/wishub-universal-protocol](https://github.com/Liozhang/wishub-universal-protocol)
- **Discord**: [参加する](https://discord.gg/wishub)

---

## 📝 ライセンス

このプロジェクトは [GPL-3.0 License](LICENSE) の下で提供されています。

---

## ⚠️ セキュリティベストプラクティス

- 常に最新バージョンのSDKを使用
- 定期的に依存関係を更新
- 最小権限の原則に従う
- TLS 1.3暗号化とAES-256-GCM暗号スイートを有効化
- ゼロ知識証明を使用してプライバシーを保護
- すべてのリクエストとレスポンスを検証
- 機密データ（APIキー、トークン）には環境変数を使用
- 濫用を防ぐためにレート制限を有効化

### 🔒 セキュリティ脆弱性の開示

セキュリティ脆弱性を発見した場合は、責任を持って報告してください：

- **メール**: security@wishub.org
- **GitHubセキュリティ**: [GitHubセキュリティアドバイザリーを使用](https://github.com/Liozhang/wishub-universal-protocol/security/advisories)

以下を含めてください：
- 脆弱性の説明
- 再現手順
- 影響を受けるバージョン
- 修正案（ある場合）

48時間以内に応答し、問題を責任を持って対処します。

---

## ❓ FAQ

**Q: WisHubとは？**
A: WisHubは、AIエージェント間の知識の検証、保存、検索、再利用を効率化する標準化されたプロトコルを使用するオープンな知識共有エコシステムです。

**Q: 始め方は？**
A: [クイックスタート](#-クイックスタート)セクションを確認し、[ドキュメント](#-ドキュメント)で詳細なプロトコル仕様を確認してください。

**Q: WisHubはオープンソースですか？**
A: はい、WisHubは[GPL-3.0ライセンス](LICENSE)の下で提供されています。

**Q: データはどのように保護されていますか？**
A: WisHubはTLS 1.3暗号化、ゼロ知識証明、きめ細かいアクセス制御を使用しています。[セキュリティベストプラクティス](#-セキュリティベストプラクティス)セクションを参照してください。

**Q: セキュリティ脆弱性を報告するには？**
A: security@wishub.orgにメールを送るか、[GitHubセキュリティアドバイザリー](https://github.com/Liozhang/wishub-universal-protocol/security/advisories)を使用してください。

---

**WisHub Universal Protocol v3.0.0** | 2026年2月23日
