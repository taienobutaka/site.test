#!/bin/bash

# ポート80でのアクセスをポート3000にリダイレクトするシンプルなプロキシ
# socat が利用可能な場合
if command -v socat &> /dev/null; then
    echo "socat を使用してポート80をポート3000にフォワーディング..."
    sudo socat TCP-LISTEN:80,fork TCP:localhost:3000 &
    echo "ポートフォワーディングが設定されました"
    echo "http://localhost にアクセスしてください"
else
    echo "socat が見つかりません。"
    echo "代わりに http://localhost:3000 にアクセスしてください"
fi
