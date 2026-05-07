<?php
/** @var array $content */

$c = $content->loadFrom('/');

$q = App\Extensions\Promotion\Model\Promotion::findAdv();
$pag = $_REQUEST['page'] ?? 0;
$count = $q
    ->select('count(*)')
    ->fetchScalar();
$items = $q
    ->select('*')
    ->limit('20 offset ' . ($pag * 20))
    ->orderBy('npp desc')
    ->where(['is_active' => 1])
    ->all();

App\Layout\Components\HeaderBlock\Header\Layout::draw();
?>

<main>
    <?php
        App\Layout\Components\Common\BreadCrumbs\Layout::draw([
            'class_name' => 'wrapper',
        ]);

        if (!empty($items)) {
            App\Layout\Components\Promo\Promotions\Layout::draw([
                'title' => $content['params']['promo_title'] ?? 'Акции и специальные предложения',
                'items' => $items,
            ]);
        }

        App\Layout\Components\Promo\PromoCallback\Layout::draw([
            'title' => 'Начните сотрудничество с выгодой!',
            'text' => 'Оставьте заявку, и мы проведем консультацию по эффективной продажи наших стёкол на маркетплейсах и ответим на все ваши вопросы',
        ]);
    ?>
</main>

<?php
App\Layout\Components\Common\Footer\Layout::draw();
App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw([
    'active_nav' => '2'
]);
?>
