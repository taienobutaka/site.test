const express = require("express");
const path = require("path");
const app = express();
const PORT = process.env.PORT || 3000;

// EJSテンプレートエンジンの設定
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

// 静的ファイルの設定
app.use(express.static(path.join(__dirname, "public")));

// SEO対応: robots.txt
app.get("/robots.txt", (req, res) => {
  res.type("text/plain");
  res.sendFile(path.join(__dirname, "public", "robots.txt"));
});

// SEO対応: sitemap.xml
app.get("/sitemap.xml", (req, res) => {
  const sitemap = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    <url>
        <loc>http://localhost:3000/</loc>
        <lastmod>${new Date().toISOString().split("T")[0]}</lastmod>
        <changefreq>daily</changefreq>
        <priority>1.0</priority>
    </url>
    <url>
        <loc>http://localhost:3000/api/banner-ads</loc>
        <lastmod>${new Date().toISOString().split("T")[0]}</lastmod>
        <changefreq>hourly</changefreq>
        <priority>0.8</priority>
    </url>
</urlset>`;

  res.type("application/xml");
  res.send(sitemap);
});

// ルートページ
app.get("/", (req, res) => {
  const bannerAds = [
    {
      title: "ChatGPT活用講座",
      subtitle: "初心者からはじめる 2時間のオンラインセミナー",
      description: "学ぶか学ばないかで圧倒的な差がつきます！",
      instructor: "講師: 七星恵一",
      buttonText: "参加無料",
      bgColor: "#4ECDC4",
    },
    {
      title: "WEBデザイン5",
      subtitle: "日間無料チャレンジ",
      description: "5日間を通してWebデザインの基礎・基本・デザイン制作を習得",
      company: "デジハリ・オンライン塾",
      buttonText: "開く",
      bgColor: "#FF6B6B",
    },
    {
      title: "プログラミング学習",
      subtitle: "Laravel・Python・大人専用サービス",
      description: "プログラミング教育で転職・就職・副業・在宅ワーク！",
      company: "ポテパンキャンプ",
      buttonText: "詳細",
      bgColor: "#4ECDC4",
    },
  ];

  res.render("index", { bannerAds });
});

// APIエンドポイント - 動的バナー広告取得
app.get("/api/banner-ads", (req, res) => {
  const ads = [
    {
      title: "ChatGPT活用講座",
      subtitle: "初心者からはじめる 2時間のオンラインセミナー",
      description: "学ぶか学ばないかで圧倒的な差がつきます！",
      instructor: "講師: 七星恵一",
      buttonText: "参加無料",
      bgColor: "#4ECDC4",
    },
    {
      title: "WEBデザイン5",
      subtitle: "日間無料チャレンジ",
      description: "5日間を通してWebデザインの基礎・基本・デザイン制作を習得",
      company: "デジハリ・オンライン塾",
      buttonText: "開く",
      bgColor: "#FF6B6B",
    },
    {
      title: "プログラミング学習",
      subtitle: "Laravel・Python・大人専用サービス",
      description: "プログラミング教育で転職・就職・副業・在宅ワーク！",
      company: "ポテパンキャンプ",
      buttonText: "詳細",
      bgColor: "#4ECDC4",
    },
    {
      title: "AI・機械学習講座",
      subtitle: "未経験から始めるAIエンジニア",
      description: "Pythonで学ぶ機械学習とディープラーニング",
      company: "テックアカデミー",
      buttonText: "無料体験",
      bgColor: "#95E1D3",
    },
  ];

  // ランダムに3つの広告を選択
  const shuffled = ads.sort(() => 0.5 - Math.random());
  const selected = shuffled.slice(0, 3);

  res.json(selected);
});

app.listen(PORT, () => {
  console.log(`サーバーが http://localhost:${PORT} で起動しました`);
});

module.exports = app;
