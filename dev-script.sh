#!/bin/bash

# アニメ・エンターテイメントサイト - 高速開発スクリプト
# このスクリプトは make コマンドの補完として使用

set -e

# カラー定義
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 関数定義
print_header() {
    echo -e "${BLUE}🎌 アニメ・エンターテイメントサイト - 開発スクリプト${NC}"
    echo "=================================================="
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Node.js環境チェック
check_environment() {
    echo -e "${BLUE}🔍 環境チェック中...${NC}"
    
    if ! command -v node &> /dev/null; then
        print_error "Node.jsがインストールされていません"
        echo "https://nodejs.org/ からインストールしてください"
        exit 1
    fi
    
    if ! command -v npm &> /dev/null; then
        print_error "npmがインストールされていません"
        exit 1
    fi
    
    print_success "Node.js $(node --version) と npm $(npm --version) が利用可能です"
}

# 依存関係インストール
install_dependencies() {
    echo -e "${BLUE}📦 依存関係をインストール中...${NC}"
    
    if [ ! -d "node_modules" ]; then
        npm install
        print_success "依存関係のインストールが完了しました"
    else
        print_warning "node_modules が既に存在します"
        echo "再インストールする場合は: make clean-all && make install"
    fi
}

# 開発サーバー起動
start_dev_server() {
    echo -e "${BLUE}🚀 開発サーバーを起動中...${NC}"
    echo -e "${YELLOW}サーバー停止: Ctrl+C${NC}"
    echo -e "${YELLOW}ブラウザアクセス: http://localhost:3000${NC}"
    echo ""
    
    # バックグラウンドで起動
    if [ "$1" = "--background" ]; then
        nohup npm run dev > server.log 2>&1 & echo $! > server.pid
        print_success "バックグラウンドでサーバーが起動しました"
        echo "ログ確認: tail -f server.log"
        echo "停止: make stop"
    else
        npm run dev
    fi
}

# ブラウザオープン
open_browser() {
    sleep 2
    if command -v xdg-open &> /dev/null; then
        xdg-open http://localhost:3000
    elif command -v open &> /dev/null; then
        open http://localhost:3000
    else
        echo -e "${BLUE}手動でブラウザを開いて http://localhost:3000 にアクセスしてください${NC}"
    fi
}

# メイン処理
main() {
    print_header
    
    case "${1:-help}" in
        "setup")
            check_environment
            install_dependencies
            print_success "セットアップが完了しました"
            echo -e "${YELLOW}開発開始: ./dev-script.sh start${NC}"
            ;;
        "start")
            start_dev_server
            ;;
        "start-bg")
            start_dev_server --background
            ;;
        "open")
            open_browser
            ;;
        "quick")
            check_environment
            install_dependencies
            start_dev_server --background
            open_browser
            ;;
        "status")
            if [ -f server.pid ]; then
                PID=$(cat server.pid)
                if ps -p $PID > /dev/null; then
                    print_success "サーバー稼働中 (PID: $PID)"
                else
                    print_warning "サーバー停止中"
                    rm -f server.pid
                fi
            else
                print_warning "サーバー情報なし"
            fi
            ;;
        "help"|*)
            echo "使用方法: $0 [コマンド]"
            echo ""
            echo "利用可能なコマンド:"
            echo "  setup     初期セットアップ"
            echo "  start     開発サーバー起動"
            echo "  start-bg  バックグラウンドで開発サーバー起動"
            echo "  open      ブラウザでサイトを開く"
            echo "  quick     クイック起動（セットアップ→起動→ブラウザ）"
            echo "  status    サーバー状態確認"
            echo "  help      このヘルプを表示"
            echo ""
            echo "推奨フロー:"
            echo "1. $0 setup      (初回のみ)"
            echo "2. $0 start      (開発開始)"
            echo ""
            echo "または: $0 quick  (すべて一括実行)"
            ;;
    esac
}

# スクリプト実行
main "$@"
