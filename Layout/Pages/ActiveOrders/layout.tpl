<?php

$pag = $_REQUEST['page'] ?? 0;
$user = \Simflex\Core\Container::getUser();

$sort = 'date desc';
switch ($_REQUEST['sort'] ?? '') {
    case 'pmin':
        $sort = 'sum_actual';
        break;
    case 'pmax':
        $sort = 'sum_actual desc';
        break;
    case 'aup':
        $sort = 'date desc';
        break;
    case 'adown':
        $sort = 'date';
        break;
}

$oq = \App\Extensions\Catalog\Model\Order::findAdv()->where(['user_id' => $user->user_id]
)->andWhere('status not in (\'canceled\', \'finished\')')->orderBy($sort);

$total = $oq->select('count(*)')->fetchScalar();
$orders = $oq->select('*')->limit('16 offset ' . (16 * $pag))->all();
?>

<?php
App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php
App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

    <main class="active-orders">
        <div class="active-orders__back">
            <div class="active-orders__wrap">
                <?php
                App\Layout\Components\Common\NavAside\Layout::draw([
                    'class_name' => 'active-orders__aside',
                    'active' => '2'
                ]); ?>

                <div class="active-orders__column">
                    <?php
                    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
                        'class_name' => 'active-orders__breadcrumbs',
                        'text' => 'Активные заказы'
                    ]);
                    ?>

                    <div class="active-orders__top">
                        <h1 class="active-orders__title">Активные заказы</h1>

                        <form>
                            <input type="hidden" name="active" value="<?= $_REQUEST['active'] ?? 0 ?>"/>
                            <input type="hidden" name="page" value="<?= $_REQUEST['page'] ?? 0 ?>"/>
                            <?php
                            if ($orders): ?>
                                <?php
                                App\Layout\Components\Common\Dropdown\Layout::draw([
                                    'class_name' => 'archived-orders__dropdown',
                                    'placeholder' => 'Сортировать',
                                    'name' => 'sort',
                                    'items' => [
                                        'pmin' => 'Сначала дешевле',
                                        'pmax' => 'Сначала дороже',
                                        'aup' => 'Сначала новые',
                                        'adown' => 'Сначала старые',
                                    ]
                                ]); ?>
                            <?php
                            endif; ?>
                        </form>
                    </div>

                    <?php
                    if (!$orders): ?>
                        <?php
                        App\Layout\Components\Other\OrdersNotFound\Layout::draw(); ?>
                    <?php
                    endif; ?>

                    <?php
                    App\Layout\Components\Common\OrderCards\Layout::draw([
                        'class_name' => 'active-orders__cards',
                        'cards' => array_map(fn($o) => [
                            'number' => $o->order_id,
                            'date' => \Simflex\Core\Time::user($o->date),
                            'status' => $o->statusToText(),
                            'badge_color' => $o->statusToFrontend(),
                            'sum' => $o->getTotal(),
                            'count' => $o->getProductCount(),
                            'link' => '/user/orders/' . $o->order_id . '/',
                            'track_link' => $o->tracking,
                        ], $orders),
                    ]); ?>
                </div>
            </div>
        </div>
    </main>

<?php
App\Layout\Components\Common\Footer\Layout::draw(); ?>
<?php
App\Layout\Components\MobileMenuBlock\MobileMenu\Layout::draw([
    'active_nav' => '4'
]); ?>