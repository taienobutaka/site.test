// 画像に忠実なヘッダーナビゲーション管理
class GigaFileHeaderManager {
  constructor() {
    this.header = document.querySelector(".top-header");
    this.navList = document.querySelector(".nav-list");
    this.navLinks = document.querySelectorAll(".nav-link");
    this.mobileMenuBtn = document.querySelector(".mobile-menu-btn");
    this.init();
  }

  init() {
    // ナビゲーションリンクのクリックイベント
    this.navLinks.forEach((link) => {
      link.addEventListener("click", (e) => {
        this.handleNavClick(e);
      });
    });

    // モバイルメニューボタンのクリックイベント
    if (this.mobileMenuBtn) {
      this.mobileMenuBtn.addEventListener("click", () => {
        this.toggleMobileMenu();
      });
    }

    // スクロール時のヘッダーの動作
    this.handleHeaderScroll();

    // ウィンドウリサイズ時の調整
    this.handleWindowResize();

    // 外部クリックでメニューを閉じる
    this.handleOutsideClick();
  }

  handleNavClick(e) {
    // アクティブメニューの視覚フィードバック
    this.navLinks.forEach((link) => link.classList.remove("active"));
    e.target.classList.add("active");

    // モバイルメニューを閉じる
    if (window.innerWidth <= 768) {
      this.navList.classList.remove("active");
    }

    console.log(`ナビゲーション項目クリック: ${e.target.textContent}`);
  }

  toggleMobileMenu() {
    this.navList.classList.toggle("active");
  }

  handleHeaderScroll() {
    window.addEventListener("scroll", () => {
      const currentScrollY = window.scrollY;

      // スクロール時の背景色とシャドウ調整（画像に忠実に白背景を維持）
      if (currentScrollY > 10) {
        this.header.style.backgroundColor = "rgba(255, 255, 255, 0.95)";
        this.header.style.backdropFilter = "blur(8px)";
        this.header.style.boxShadow = "0 2px 8px rgba(0, 0, 0, 0.1)";
      } else {
        this.header.style.backgroundColor = "#ffffff";
        this.header.style.backdropFilter = "none";
        this.header.style.boxShadow = "0 1px 2px rgba(0, 0, 0, 0.05)";
      }
    });
  }

  handleWindowResize() {
    window.addEventListener("resize", () => {
      if (window.innerWidth > 768) {
        this.navList.classList.remove("active");
      }
    });
  }

  handleOutsideClick() {
    document.addEventListener("click", (e) => {
      if (!this.header.contains(e.target)) {
        this.navList.classList.remove("active");
      }
    });
  }
}

// 動的バナー広告の管理
class DynamicBannerManager {
  constructor() {
    this.bannerContainer = document.getElementById("dynamic-banners");
    this.currentBanners = [];
    this.rotationInterval = 5000; // 5秒ごとに更新（短縮）
    this.init();
  }

  init() {
    // 初期ロード
    this.loadBanners();

    // 定期的な更新設定
    setInterval(() => {
      this.rotateBanners();
    }, this.rotationInterval);

    // スムーズなアニメーション効果
    this.setupAnimations();
  }

  async loadBanners() {
    try {
      const response = await fetch("/api/banner-ads");
      const banners = await response.json();
      this.currentBanners = banners;
      this.renderBanners(banners);
    } catch (error) {
      console.error("バナー広告の読み込みに失敗しました:", error);
    }
  }

  async rotateBanners() {
    // フェードアウト効果
    this.bannerContainer.style.opacity = "0.3";

    setTimeout(async () => {
      await this.loadBanners();

      // フェードイン効果
      this.bannerContainer.style.opacity = "1";
    }, 300);
  }

  renderBanners(banners) {
    this.bannerContainer.innerHTML = "";

    banners.forEach((ad, index) => {
      const bannerElement = this.createBannerElement(ad, index);
      this.bannerContainer.appendChild(bannerElement);
    });
  }

  createBannerElement(ad, index) {
    const bannerDiv = document.createElement("div");
    bannerDiv.className = "banner-ad";
    bannerDiv.style.backgroundColor = ad.bgColor;
    bannerDiv.style.animationDelay = `${index * 0.2}s`;

    bannerDiv.innerHTML = `
            <div class="banner-text">
                <h3>${ad.title}</h3>
                <p class="banner-subtitle">${ad.subtitle}</p>
                <p class="banner-description">${ad.description}</p>
                ${
                  ad.instructor
                    ? `<p class="banner-instructor">${ad.instructor}</p>`
                    : ""
                }
                ${
                  ad.company
                    ? `<p class="banner-company">${ad.company}</p>`
                    : ""
                }
            </div>
            <button class="banner-btn" onclick="handleBannerClick('${
              ad.title
            }')">${ad.buttonText}</button>
        `;

    return bannerDiv;
  }

  setupAnimations() {
    // CSS アニメーションの設定
    const style = document.createElement("style");
    style.textContent = `
            .banner-ad {
                animation: slideInUp 0.6s ease-out both;
            }
            
            @keyframes slideInUp {
                from {
                    transform: translateY(30px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }
            
            .footer-banners {
                transition: opacity 0.3s ease-in-out;
            }
        `;
    document.head.appendChild(style);
  }
}

// バナークリック処理
function handleBannerClick(bannerTitle) {
  console.log(`バナーがクリックされました: ${bannerTitle}`);

  // アナリティクス送信（実際の実装では適切なトラッキングコードを使用）
  if (typeof gtag !== "undefined") {
    gtag("event", "banner_click", {
      banner_title: bannerTitle,
      event_category: "advertisement",
    });
  }

  // 実際のリンク先へのリダイレクト（現在は例として）
  alert(`${bannerTitle} のページへ移動します`);
}

// 画像の遅延読み込み
class LazyImageLoader {
  constructor() {
    this.images = document.querySelectorAll("img[data-src]");
    this.imageObserver = new IntersectionObserver(
      this.onIntersection.bind(this)
    );
    this.init();
  }

  init() {
    this.images.forEach((img) => {
      this.imageObserver.observe(img);
    });
  }

  onIntersection(entries) {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        const img = entry.target;
        img.src = img.dataset.src;
        img.classList.add("loaded");
        this.imageObserver.unobserve(img);
      }
    });
  }
}

// スムーズスクロール機能
function smoothScrollTo(targetId) {
  const target = document.getElementById(targetId);
  if (target) {
    target.scrollIntoView({
      behavior: "smooth",
      block: "start",
    });
  }
}

// ページ読み込み時の初期化
document.addEventListener("DOMContentLoaded", function () {
  // 動的バナー管理の初期化
  new DynamicBannerManager();

  // 遅延読み込みの初期化
  if ("IntersectionObserver" in window) {
    new LazyImageLoader();
  }

  // ボタンのホバー効果
  const buttons = document.querySelectorAll(".details-btn, .banner-btn, .btn");
  buttons.forEach((button) => {
    button.addEventListener("mouseenter", function () {
      this.style.transform = "translateY(-2px) scale(1.05)";
    });

    button.addEventListener("mouseleave", function () {
      this.style.transform = "translateY(0) scale(1)";
    });
  });

  // ニュースアイテムのアニメーション
  const newsItems = document.querySelectorAll(".news-item");
  const newsObserver = new IntersectionObserver((entries) => {
    entries.forEach((entry, index) => {
      if (entry.isIntersecting) {
        setTimeout(() => {
          entry.target.style.opacity = "1";
          entry.target.style.transform = "translateX(0)";
        }, index * 100);
        newsObserver.unobserve(entry.target);
      }
    });
  });

  newsItems.forEach((item) => {
    item.style.opacity = "0";
    item.style.transform = "translateX(-30px)";
    item.style.transition = "all 0.6s ease-out";
    newsObserver.observe(item);
  });

  // パフォーマンス最適化: 画像プリロード
  preloadImages();
});

// 画像プリロード機能（テスト環境では無効化）
function preloadImages() {
  // テスト環境では画像をCSSで代用しているため、プリロードは不要
  console.log("画像プリロードはスキップされました（テスト環境）");
}

// レスポンシブ対応: ウィンドウリサイズ時の調整
window.addEventListener(
  "resize",
  debounce(() => {
    // 動画コンテナのアスペクト比調整
    const videoContainers = document.querySelectorAll(".video-container");
    videoContainers.forEach((container) => {
      const width = container.offsetWidth;
      container.style.height = `${(width * 9) / 16}px`;
    });
  }, 250)
);

// デバウンス関数
function debounce(func, wait) {
  let timeout;
  return function executedFunction(...args) {
    const later = () => {
      clearTimeout(timeout);
      func(...args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
  };
}

// ページ読み込み完了時の初期化
document.addEventListener("DOMContentLoaded", () => {
  // 画像に忠実なヘッダーナビゲーション管理の初期化
  const gigaFileHeaderManager = new GigaFileHeaderManager();

  // 動的バナー管理の初期化
  const bannerManager = new DynamicBannerManager();

  console.log("ギガファイル便サイト初期化完了（画像忠実デザイン適用）");
});

// エラーハンドリング
window.addEventListener("error", (e) => {
  console.error("JavaScript Error:", e.error);
});

// サービスワーカー登録（PWA対応の準備）
if ("serviceWorker" in navigator) {
  window.addEventListener("load", () => {
    navigator.serviceWorker
      .register("/sw.js")
      .then((registration) => {
        console.log("SW registered: ", registration);
      })
      .catch((registrationError) => {
        console.log("SW registration failed: ", registrationError);
      });
  });
}
