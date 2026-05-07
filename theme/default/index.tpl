<!DOCTYPE html>
<html lang="ru">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <meta name="theme-color" content="#FF3838">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="#FF3838">

    <link rel="apple-touch-icon" href="/assets/meta/apple-touch-icon.png">
    <link rel="icon" href="/assets/meta/favicon.ico" sizes="any">
    <link rel="icon" href="/assets/meta/icon.svg" type="image/svg+xml">
    <link rel="manifest" href="/assets/meta/manifest.webmanifest">
    <link rel="yandex-tableau-widget" href="/assets/meta/tableau.json">

    <link rel="preload" href="/assets/fonts/Raleway-VF.ttf" as="font" type="font/ttf" crossorigin>

    <link rel="canonical" href="<?= url(\Simflex\Core\Container::getRequest()->getPath()) ?>" />

    <?php Simflex\Core\Page::meta(); ?>

    <link rel="stylesheet"
          href="https://cdn.sn9.ru/css/swiper/11.1.3/swiper-bundle.min.css"/>
    <script src="https://cdn.sn9.ru/js/swiper/11.1.3/swiper-bundle.min.js"></script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/intl-tel-input@25.1.0/build/css/intlTelInput.css">
    <script src="https://cdn.jsdelivr.net/npm/intl-tel-input@25.1.0/build/js/intlTelInput.min.js"></script>

    <!-- Yandex.Metrika counter -->
    <script type="text/javascript">
        (function(m,e,t,r,i,k,a){
            m[i]=m[i]||function(){(m[i].a=m[i].a||[]).push(arguments)};
            m[i].l=1*new Date();
            for (var j = 0; j < document.scripts.length; j++) {if (document.scripts[j].src === r) { return; }}
            k=e.createElement(t),a=e.getElementsByTagName(t)[0],k.async=1,k.src=r,a.parentNode.insertBefore(k,a)
        })(window, document,'script','https://mc.yandex.ru/metrika/tag.js?id=105906625', 'ym');

        ym(105906625, 'init', {ssr:true, webvisor:true, clickmap:true, ecommerce:"dataLayer", accurateTrackBounce:true, trackLinks:true});
    </script>
    <noscript><div><img src="https://mc.yandex.ru/watch/105906625" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
    <!-- /Yandex.Metrika counter -->

    <!-- Roistat Counter Start -->
    <script>
        (function(w, d, s, h, id) {
            w.roistatProjectId = id; w.roistatHost = h;
            var p = d.location.protocol == "https:" ? "https://" : "http://";
            var u = /^.*roistat_visit=[^;]+(.*)?$/.test(d.cookie) ? "/dist/module.js" : "/api/site/1.0/"+id+"/init?referrer="+encodeURIComponent(d.location.href);
            var js = d.createElement(s); js.charset="UTF-8"; js.async = 1; js.src = p+h+u; var js2 = d.getElementsByTagName(s)[0]; js2.parentNode.insertBefore(js, js2);
        })(window, document, 'script', 'cloud.roistat.com', '1ee891677afe03e5eae00258dabf6f1a');
    </script>
    <!-- Roistat Counter End -->

    <script>(function () { var widget = document.createElement('script'); widget.defer = true; widget.dataset.pfId = '991737ac-08ce-48f4-8323-b8353a5d1d4c'; widget.src = 'https://widget.yourgood.app/script/widget.js?id=991737ac-08ce-48f4-8323-b8353a5d1d4c&now='+Date.now(); document.head.appendChild(widget); })()</script>

</head>
<body>
<?php
Simflex\Core\Page::position('content-before'); ?>
<?php
Simflex\Core\Page::content(); ?>
<?php
Simflex\Core\Page::position('content-after'); ?>

<?php
Simflex\Core\Page::position('absolute'); ?>
<?php
Simflex\Core\Page::metaJS(); ?>
</body>
</html>
