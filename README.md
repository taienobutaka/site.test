# エンターテイメントサイト
![alt text](<スクリーンショット 2025-08-20 094802.png>)

![alt text](<スクリーンショット 2025-08-20 094825.png>)

![alt text](<スクリーンショット 2025-08-20 094845.png>)
## ポートフォリオ向けアピールポイント

- モダンな UI/UX・レスポンシブデザイン（スマホ/PC 両対応）
- Node.js + Express + EJS によるフルスタック SPA
- 動的バナー広告（API 連携・スライドイン・自動ローテーション）
- SEO 最適化（メタタグ/OGP/構造化データ/カノニカル/robots/sitemap）
- PWA 対応・パフォーマンス最適化（遅延読込・プリロード・キャッシュ）

## 📦 クローンからの構築・起動方法

1. リポジトリをクローン

```bash
git clone git@github.com:taienobutaka/site.test.git
cd site.test
```

2. セットアップ（依存関係インストール）

```bash
make setup
```

3. サーバー起動

```bash
make dev      # 開発モード（ホットリロード対応）
# または
make start    # 本番モード
```

4. サイトへアクセス

- http://localhost:3000
- `make open` で自動オープンも可能

```bash
# Node.js 18以上がインストールされていることを確認
node --version  # v18.0.0以上が必要
npm --version   # 確認

# Node.jsがない場合は以下からインストール:
# https://nodejs.org/ (推奨: LTS版)
```

#### ステップ 2: プロジェクト取得・セットアップ

```bash
# 環境確認と依存関係インストール（推奨）
make setup

# または手動でのセットアップ
npm install
```

#### ステップ 3: サーバー起動

```bash
# 開発モード（推奨 - ホットリロード対応）
make dev

# または本番モード
make start

# またはバックグラウンド起動
make start-bg
```

#### ステップ 4: アクセス確認

```bash
# ブラウザ自動オープン
make open

# または手動でアクセス
# http://localhost:3000
```

### 🚀 Makefile を使用した効率的な開発（推奨）

```bash
# ヘルプ表示
make help

# 初回セットアップ
make setup

# 開発モード起動
make dev

# 本番モード起動
make start

# バックグラウンド起動
make start-bg

# サーバー停止
make stop

# ブラウザでサイトを開く
make open

# クイック起動（インストール→起動→ブラウザ）
make quick

# サーバー状態確認
make status

# ログ表示
make logs

# クリーンアップ
make clean
```

### 🛠️ 従来の npm コマンド

### 1. 依存関係のインストール

```bash
npm install
```

### 2. サーバー起動

```bash
# 開発モード
npm run dev

# 本番モード
npm start
```

### 3. 高速開発スクリプト

```bash
# 初回セットアップ
./dev-script.sh setup

# 開発開始
./dev-script.sh start

# クイック起動
./dev-script.sh quick
```

### 3. アクセス

- **推奨**: `make open` でブラウザ自動オープン
- メインアクセス: http://localhost:3000
- ポート 80 でのアクセス（オプション）: `./setup-port-forwarding.sh` 実行後、http://localhost

## 🔧 開発効率化ツール

### Makefile コマンド一覧

| コマンド         | 説明                   |
| ---------------- | ---------------------- |
| `make help`      | ヘルプ表示             |
| `make setup`     | 初期セットアップ       |
| `make dev`       | 開発モード起動         |
| `make start`     | 本番モード起動         |
| `make start-bg`  | バックグラウンド起動   |
| `make stop`      | サーバー停止           |
| `make restart`   | サーバー再起動         |
| `make status`    | サーバー状態確認       |
| `make logs`      | ログ表示               |
| `make open`      | ブラウザでサイトを開く |
| `make quick`     | クイック起動           |
| `make test`      | テスト実行             |
| `make lint`      | コード品質チェック     |
| `make format`    | コードフォーマット     |
| `make build`     | 本番用ビルド           |
| `make clean`     | 一時ファイル削除       |
| `make clean-all` | 完全クリーンアップ     |

## 🎨 デザイン要素

### 実装済み機能

✅ **トップナビゲーションヘッダー（画像完全忠実再現）**

- 白背景のクリーンなナビゲーションバー
- 左側：「ギガファイル便」ロゴテキスト
- 右側：7 つのナビゲーションメニュー（ホーム、お知らせ、ギガファイルとは、お問い合わせ、アプリ、使い方、速度比較）
- レスポンシブ対応（モバイルドロップダウンメニュー）
- スクロール時の背景ブラー効果

✅ ヒーローセクション（キャラクター紹介）  
✅ 動画埋め込み（YouTube）  
✅ ニュースセクション  
✅ ダウンロードセクション  
✅ 動的バナー広告  
✅ レスポンシブ対応  
✅ アニメーション効果

### 画像について

テスト環境では実際の画像の代わりに CSS 生成された代用要素を使用：

- 広告バナー → CSS 生成デザイン
- ロゴ → テキストベース表示
- QR コード → CSS 代用ボックス

## 🔧 SEO & パフォーマンス最適化

### 🎯 SEO 対応済み機能

#### メタタグ最適化

- タイトル、ディスクリプション、キーワード設定
- Open Graph（SNS 共有最適化）
- Twitter Card 対応
- 構造化データ（JSON-LD）実装
- カノニカル URL 設定

#### 検索エンジン対応

- `robots.txt` - クローラー制御
- `sitemap.xml` - 自動生成サイトマップ
- セマンティック HTML 構造
- 構造化マークアップ（Schema.org）

#### PWA 対応

- `manifest.json` - アプリ化対応
- テーマカラー設定
- オフライン対応準備

#### パフォーマンス

- 遅延画像読み込み
- CSS/JavaScript 最適化
- フォント最適化（Google Fonts）
- 圧縮・キャッシュ対応

### 📊 SEO 確認コマンド

```bash
# サイトマップ確認
curl http://localhost:3000/sitemap.xml

# robots.txt確認
curl http://localhost:3000/robots.txt

# 構造化データ確認（ページソース）
curl http://localhost:3000 | grep -A 20 'application/ld+json'
```

## 🔧 API エンドポイント

### GET `/`

メインページの表示

### GET `/api/banner-ads`

動的バナー広告データの取得

```json
[
  {
    "title": "ChatGPT活用講座",
    "subtitle": "初心者からはじめる 2時間のオンラインセミナー",
    "description": "学ぶか学ばないかで圧倒的な差がつきます！",
    "instructor": "講師: 七星恵一",
    "buttonText": "参加無料",
    "bgColor": "#4ECDC4"
  }
]
```

## 📱 レスポンシブ対応

- **デスクトップ**: 1200px 以上
- **タブレット**: 768px - 1199px
- **モバイル**: 767px 以下

## 🎯 パフォーマンス最適化

- CSS Grid & Flexbox レイアウト
- 遅延画像読み込み
- デバウンス機能
- プリロード対応
- 最適化されたアニメーション

## 🔄 動的機能

### バナー広告ローテーション

- 5 秒ごとに自動更新（高速更新）
- フェード効果付きトランジション（0.3 秒）
- ランダム選択アルゴリズム
- スムーズな UI 更新

### インタラクション

- ホバー効果
- クリック追跡
- スムーズスクロール
- レスポンシブ調整

## 🚀 本番デプロイ準備

1. **画像アセット**: `public/images/` に実際の画像を配置
2. **環境変数**: `.env` ファイルで設定管理
3. **SSL 証明書**: HTTPS 対応
4. **CDN**: 静的アセット配信最適化
5. **監視**: ログ・メトリクス設定

## ⚡ 高速開発フロー

### 🎯 初回開発者向け

```bash
# 1. リポジトリクローン後
make setup

# 2. 開発開始
make dev
```

### 🔄 日常開発フロー

```bash
# 朝の開発開始
make start-bg && make open

# 昼休み前
make stop

# 午後の開発再開
make restart

# 夕方の終了
make stop
```

### 🚀 デモ・プレゼン用

```bash
# 一発起動（インストール→起動→ブラウザ）
make quick

# 状態確認
make status

# 問題があれば再起動
make restart
```

---

## クローン＆構築手順（Makefile 推奨）

1. リポジトリをクローン

```bash
git clone git@github.com:taienobutaka/site.test.git
cd site.test
```

2. Makefile でセットアップ＆起動

```bash
make setup   # 依存関係インストール・初期化
make dev     # 開発モードで起動（ホットリロード対応）
# または
make start   # 本番モードで起動
```

3. ブラウザでアクセス

- http://localhost:3000
- `make open` で自動オープンも可能

---
