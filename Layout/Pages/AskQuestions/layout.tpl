<?php

/** @var array $data */
$pag = $_REQUEST['page'] ?? 0;
$count = $data['cards'];
?>

<?php
App\Layout\Components\Common\RunningLine\Layout::draw(); ?>
<?php
App\Layout\Components\HeaderBlock\Header\Layout::draw(); ?>

    <main class="ask-questions">
        <div class="ask-questions__back">
            <div class="ask-questions__wrap">
                <?php
                App\Layout\Components\Common\NavAside\Layout::draw([
                    'class_name' => 'ask-questions__aside',
                    'active' => '4'
                ]); ?>

                <div class="ask-questions__column">
                    <?php
                    App\Layout\Components\Common\BreadCrumbs\Layout::draw([
                        'class_name' => 'ask-questions__breadcrumbs',
                        'text' => 'Задать вопрос'
                    ]);
                    ?>

                    <h1 class="ask-questions__title">Ваши вопросы</h1>
                    <p class="ask-questions__text">
                        Здесь вы можете задать вопросы руководителю
                    </p>

                    <div class="ask-questions__top">
                        <?php
                        App\Layout\Components\AccountBlocks\AskQuestions\AskForm\Layout::draw([

                        ]); ?>

                        <?php
                        if ($data['cards']): ?>
                            <form>
                                <div class="ask-questions__dropdown-box">
                                    <?php
                                    App\Layout\Components\Common\Dropdown\Layout::draw([
                                        'class_name' => 'ask-questions__dropdown',
                                        'placeholder' => 'Сортировать',
                                        'name' => 'sort',
                                        'value' => $_REQUEST['sort'] ?? '',
                                        'items' => [
                                            'old' => 'Сначала новые',
                                            'new' => 'Сначала старые',
                                            'ans' => 'Сначала с ответом',
                                            'nop' => 'Сначала без ответа',
                                        ]
                                    ]); ?>
                                </div>
                            </form>
                        <?php
                        endif; ?>
                    </div>

                    <ul class="ask-questions__list">
                        <?php
                        foreach ($data['cards'] as $card): ?>
                            <?php
                            App\Layout\Components\Common\QuestionCard\Layout::draw([
                                'card' => $card,
                            ]); ?>
                        <?php
                        endforeach; ?>
                    </ul>
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