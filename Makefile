# アニメ・エンターテイメントサイト - Makefile
# Node.js + Express プロジェクト用効率的構築システム

# 変数定義
NODE_VERSION := $(shell node --version 2>/dev/null || echo "未インストール")
NPM_VERSION := $(shell npm --version 2>/dev/null || echo "未インストール")
PROJECT_NAME := anime-site
PORT := 3000
HOST := localhost
DEV_PORT := 3001

# カラー定義
GREEN := \033[0;32m
YELLOW := \033[1;33m
RED := \033[0;31m
BLUE := \033[0;34m
NC := \033[0m # No Color

# デフォルトタスク
.DEFAULT_GOAL := help

# ヘルプ表示
.PHONY: help
help: ## ヘルプを表示
	@echo "$(BLUE)🎌 $(PROJECT_NAME) - 構築システム$(NC)"
	@echo ""
	@echo "$(GREEN)利用可能なコマンド:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(YELLOW)%-20s$(NC) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(BLUE)環境情報:$(NC)"
	@echo "  Node.js: $(NODE_VERSION)"
	@echo "  npm: $(NPM_VERSION)"
	@echo "  プロジェクト: $(PROJECT_NAME)"
	@echo "  ポート: $(PORT)"

# インストール・セットアップ
.PHONY: install
install: ## 依存関係をインストール
	@echo "$(GREEN)📦 依存関係をインストール中...$(NC)"
	npm install
	@echo "$(GREEN)✅ インストール完了$(NC)"

.PHONY: install-dev
install-dev: ## 開発用依存関係も含めてインストール
	@echo "$(GREEN)📦 開発用依存関係も含めてインストール中...$(NC)"
	npm install --include=dev
	@echo "$(GREEN)✅ 開発用インストール完了$(NC)"

.PHONY: setup
setup: check-node install ## 初期セットアップ（Node.js確認 + インストール）
	@echo "$(GREEN)🚀 初期セットアップ完了$(NC)"
	@echo "$(YELLOW)次のコマンドでサーバーを起動: make dev$(NC)"

# 開発・実行
.PHONY: dev
dev: ## 開発モードでサーバー起動（ホットリロード）
	@echo "$(GREEN)🔥 開発モードでサーバー起動中...$(NC)"
	@echo "$(BLUE)URL: http://$(HOST):$(PORT)$(NC)"
	npm run dev

.PHONY: start
start: ## 本番モードでサーバー起動
	@echo "$(GREEN)🚀 本番モードでサーバー起動中...$(NC)"
	@echo "$(BLUE)URL: http://$(HOST):$(PORT)$(NC)"
	npm start

.PHONY: start-bg
start-bg: ## バックグラウンドでサーバー起動
	@echo "$(GREEN)🔄 バックグラウンドでサーバー起動中...$(NC)"
	nohup npm start > server.log 2>&1 & echo $$! > server.pid
	@echo "$(GREEN)✅ サーバーがバックグラウンドで起動しました$(NC)"
	@echo "$(YELLOW)ログ確認: make logs$(NC)"
	@echo "$(YELLOW)停止: make stop$(NC)"

.PHONY: stop
stop: ## バックグラウンドサーバーを停止
	@if [ -f server.pid ]; then \
		echo "$(GREEN)🛑 サーバーを停止中...$(NC)"; \
		kill -9 `cat server.pid` 2>/dev/null || echo "$(YELLOW)サーバーは既に停止しています$(NC)"; \
		rm -f server.pid; \
		echo "$(GREEN)✅ サーバーが停止しました$(NC)"; \
	else \
		echo "$(YELLOW)⚠️  サーバーPIDファイルが見つかりません$(NC)"; \
	fi

.PHONY: restart
restart: stop start-bg ## サーバーを再起動

# テスト・品質チェック
.PHONY: test
test: ## テストを実行
	@echo "$(GREEN)🧪 テスト実行中...$(NC)"
	@if npm list jest >/dev/null 2>&1; then \
		npm test; \
	else \
		echo "$(YELLOW)⚠️  テストフレームワークが見つかりません$(NC)"; \
		echo "$(BLUE)テスト環境をセットアップ: make setup-test$(NC)"; \
	fi

.PHONY: lint
lint: ## コード品質チェック
	@echo "$(GREEN)🔍 コード品質チェック中...$(NC)"
	@if command -v eslint >/dev/null 2>&1; then \
		npx eslint public/js/*.js server.js; \
	else \
		echo "$(YELLOW)⚠️  ESLintが見つかりません$(NC)"; \
		echo "$(BLUE)ESLintをインストール: npm install -g eslint$(NC)"; \
	fi

.PHONY: format
format: ## コードフォーマット
	@echo "$(GREEN)💄 コードフォーマット中...$(NC)"
	@if command -v prettier >/dev/null 2>&1; then \
		npx prettier --write "**/*.{js,css,html,ejs}"; \
	else \
		echo "$(YELLOW)⚠️  Prettierが見つかりません$(NC)"; \
		echo "$(BLUE)Prettierをインストール: npm install -g prettier$(NC)"; \
	fi

# ビルド・最適化
.PHONY: build
build: clean install ## 本番用ビルド
	@echo "$(GREEN)🏗️  本番用ビルド中...$(NC)"
	@mkdir -p dist
	@cp -r public dist/
	@cp -r views dist/
	@cp server.js dist/
	@cp package.json dist/
	@echo "$(GREEN)✅ ビルド完了: dist/$(NC)"

.PHONY: optimize
optimize: ## CSSとJSの最適化
	@echo "$(GREEN)⚡ アセット最適化中...$(NC)"
	@if command -v uglifyjs >/dev/null 2>&1; then \
		uglifyjs public/js/script.js -o public/js/script.min.js -c -m; \
		echo "$(GREEN)✅ JavaScript最適化完了$(NC)"; \
	else \
		echo "$(YELLOW)⚠️  UglifyJSが見つかりません$(NC)"; \
	fi
	@if command -v cssnano >/dev/null 2>&1; then \
		cssnano public/css/style.css public/css/style.min.css; \
		echo "$(GREEN)✅ CSS最適化完了$(NC)"; \
	else \
		echo "$(YELLOW)⚠️  CSSnanoが見つかりません$(NC)"; \
	fi

# 開発ツール
.PHONY: logs
logs: ## サーバーログを表示
	@if [ -f server.log ]; then \
		echo "$(GREEN)📋 サーバーログ:$(NC)"; \
		tail -f server.log; \
	else \
		echo "$(YELLOW)⚠️  ログファイルが見つかりません$(NC)"; \
	fi

.PHONY: status
status: ## サーバーの状態確認
	@echo "$(GREEN)📊 サーバー状態:$(NC)"
	@if [ -f server.pid ]; then \
		PID=`cat server.pid`; \
		if ps -p $$PID > /dev/null; then \
			echo "$(GREEN)✅ サーバー稼働中 (PID: $$PID)$(NC)"; \
			echo "$(BLUE)URL: http://$(HOST):$(PORT)$(NC)"; \
		else \
			echo "$(RED)❌ サーバー停止中$(NC)"; \
			rm -f server.pid; \
		fi \
	else \
		echo "$(YELLOW)⚠️  サーバー情報なし$(NC)"; \
	fi

.PHONY: open
open: ## ブラウザでサイトを開く
	@echo "$(GREEN)🌐 ブラウザでサイトを開いています...$(NC)"
	@if command -v xdg-open >/dev/null 2>&1; then \
		xdg-open http://$(HOST):$(PORT); \
	elif command -v open >/dev/null 2>&1; then \
		open http://$(HOST):$(PORT); \
	else \
		echo "$(BLUE)手動でアクセスしてください: http://$(HOST):$(PORT)$(NC)"; \
	fi

# メンテナンス
.PHONY: clean
clean: ## 一時ファイルを削除
	@echo "$(GREEN)🧹 クリーンアップ中...$(NC)"
	@rm -rf node_modules/.cache
	@rm -rf dist
	@rm -f server.log server.pid
	@rm -f public/js/*.min.js
	@rm -f public/css/*.min.css
	@echo "$(GREEN)✅ クリーンアップ完了$(NC)"

.PHONY: clean-all
clean-all: clean ## すべての依存関係を削除してクリーン
	@echo "$(GREEN)🧹 完全クリーンアップ中...$(NC)"
	@rm -rf node_modules
	@rm -f package-lock.json
	@echo "$(GREEN)✅ 完全クリーンアップ完了$(NC)"
	@echo "$(YELLOW)再セットアップ: make setup$(NC)"

# 環境確認
.PHONY: check-node
check-node: ## Node.js環境確認
	@echo "$(GREEN)🔍 Node.js環境確認中...$(NC)"
	@if command -v node >/dev/null 2>&1; then \
		echo "$(GREEN)✅ Node.js: $(NODE_VERSION)$(NC)"; \
	else \
		echo "$(RED)❌ Node.jsがインストールされていません$(NC)"; \
		echo "$(BLUE)Node.jsをインストールしてください: https://nodejs.org/$(NC)"; \
		exit 1; \
	fi
	@if command -v npm >/dev/null 2>&1; then \
		echo "$(GREEN)✅ npm: $(NPM_VERSION)$(NC)"; \
	else \
		echo "$(RED)❌ npmがインストールされていません$(NC)"; \
		exit 1; \
	fi

.PHONY: info
info: ## プロジェクト情報表示
	@echo "$(BLUE)📋 プロジェクト情報$(NC)"
	@echo "  名前: $(PROJECT_NAME)"
	@echo "  バージョン: $$(grep '"version"' package.json | cut -d'"' -f4)"
	@echo "  Node.js: $(NODE_VERSION)"
	@echo "  npm: $(NPM_VERSION)"
	@echo "  ポート: $(PORT)"
	@echo "  開発ポート: $(DEV_PORT)"
	@echo ""
	@echo "$(GREEN)📁 ファイル構成:$(NC)"
	@find . -maxdepth 2 -type f \( -name "*.js" -o -name "*.css" -o -name "*.ejs" -o -name "*.json" \) | grep -v node_modules | sort

# デプロイ支援
.PHONY: deploy-check
deploy-check: ## デプロイ前チェック
	@echo "$(GREEN)🚀 デプロイ前チェック中...$(NC)"
	@make check-node
	@make test
	@make lint
	@echo "$(GREEN)✅ デプロイ前チェック完了$(NC)"

# 高速起動用コマンド
.PHONY: quick
quick: install start-bg open ## クイック起動（インストール→起動→ブラウザ）
	@echo "$(GREEN)🚀 クイック起動完了！$(NC)"

# 開発用完全セットアップ
.PHONY: dev-setup
dev-setup: clean-all setup ## 開発環境完全セットアップ
	@echo "$(GREEN)🔧 開発環境セットアップ完了$(NC)"
	@echo "$(YELLOW)開発開始: make dev$(NC)"
