# アニメ・エンターテイメントサイト - 開発ガイド

## 🚀 Makefile による効率的な開発フロー

このプロジェクトでは、開発効率を最大化するために Makefile を導入しています。

### 📋 主要コマンド

#### 基本操作

- `make help` - 利用可能なコマンド一覧
- `make setup` - 初期セットアップ（Node.js 確認 + npm install）
- `make dev` - 開発モードでサーバー起動（ホットリロード）
- `make start` - 本番モードでサーバー起動

#### サーバー管理

- `make start-bg` - バックグラウンドでサーバー起動
- `make stop` - バックグラウンドサーバー停止
- `make restart` - サーバー再起動
- `make status` - サーバー状態確認
- `make logs` - サーバーログ表示

#### 開発支援

- `make open` - ブラウザでサイトを開く
- `make quick` - クイック起動（install→start-bg→open）
- `make clean` - 一時ファイル削除
- `make info` - プロジェクト情報表示

#### 品質管理

- `make test` - テスト実行
- `make lint` - コード品質チェック
- `make format` - コードフォーマット
- `make build` - 本番用ビルド

### 🔄 推奨開発フロー

#### 初回セットアップ

```bash
git clone [repository]
cd site
make setup        # Node.js確認 + 依存関係インストール
make dev          # 開発サーバー起動
```

#### 日常開発

```bash
# 朝の開発開始
make start-bg     # バックグラウンド起動
make open         # ブラウザオープン

# 作業中のサーバー確認
make status       # 状態確認
make logs         # ログ確認

# 問題発生時
make restart      # 再起動

# 終業時
make stop         # サーバー停止
```

#### デモ・プレゼン

```bash
make quick        # すべて一括実行（最速）
```

### 🐳 Docker サポート

#### 開発環境

```bash
make docker-build           # イメージビルド
docker-compose --profile dev up    # 開発環境起動
```

#### 本番環境

```bash
docker-compose --profile production up
```

### 🛠️ 代替スクリプト

Makefile が利用できない環境では、`dev-script.sh` を使用：

```bash
./dev-script.sh setup    # 初期セットアップ
./dev-script.sh start    # 開発開始
./dev-script.sh quick    # クイック起動
```

### 📊 パフォーマンス最適化

- `make optimize` - CSS/JS 最適化
- `make build` - 本番用ビルド
- `make deploy-check` - デプロイ前チェック

### 🔧 トラブルシューティング

#### サーバーが起動しない

```bash
make clean        # 一時ファイル削除
make setup        # 再セットアップ
make dev          # 開発モード起動
```

#### 完全リセット

```bash
make clean-all    # 完全クリーンアップ
make setup        # 再セットアップ
```

#### ポート競合

```bash
make stop         # 既存サーバー停止
make start        # 新規起動
```

### 💡 効率化のコツ

1. **エイリアス設定**

   ```bash
   alias mdev="make dev"
   alias mstart="make start-bg"
   alias mstop="make stop"
   alias mquick="make quick"
   ```

2. **ワンライナー起動**

   ```bash
   make quick && echo "開発準備完了！"
   ```

3. **監視コマンド**
   ```bash
   watch -n 2 make status    # 2秒ごとに状態確認
   ```

---

**💻 Happy Coding!** Makefile で効率的な開発をお楽しみください。
