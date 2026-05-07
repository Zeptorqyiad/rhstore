<?php
/** @var array $data */ ?>
<?php
extract($data);
if ($pages > 1): ?>
    <?php
    $key ??= 'page';
    unset($_REQUEST[$key]);
    $add = http_build_query($_REQUEST) . $linkPost;
    ?>

    <!---- Desktop ---->
    <div class="pagination wrapper <?= $data['className'] ?> <?= $data['pt'] ?> <?= $data['pb'] ?>"
         id="pagination-container" data-link="<?= htmlspecialchars($link, ENT_QUOTES, 'UTF-8') ?>">
        <div class="pagination__container container">
            <div class="pagination__inner">
                <ul class="pagination__block">

                    <li class="pagination__item pagination__item_icon-left btn_style-secondary btn btn_size-medium btn_icon-center btn-pagination-icon--prev <?= !$hasPrev ? 'pagination__item_hidden' : '' ?>">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                            <path fill="#404040" fill-rule="evenodd"
                                  d="M14.207 8.793a1 1 0 0 1 0 1.414L11.914 12.5l2.293 2.293a1 1 0 0 1-1.414 1.414l-3-3a1 1 0 0 1 0-1.414l3-3a1 1 0 0 1 1.414 0Z"
                                  clip-rule="evenodd"/>
                        </svg>

                        <a data-pag="<?= $page - 1 ?>" data-cb="<?= $data['cb'] ?>"
                           href="<?= $link ?>?<?= $key ?>=<?= $page - 1 ?>&<?= $add ?>" <?= !($page - 1) ? 'rel="canonical"' : '' ?>
                           class="pagination__link"></a>
                    </li>

                    <?php
                    if ($page < 4): ?>
                        <?php
                        for ($i = 0; $i < min(6, $pages); ++$i): ?>
                            <li class="pagination__item btn btn_size-medium <?= $i == $page ? 'btn_style-gray' : 'btn_style-secondary' ?>">
                                <?= $i + 1 ?>
                                <a data-cb="<?= $data['cb'] ?>" data-pag="<?= $i ?>"
                                   href="<?= $link ?>?<?= $key ?>=<?= $i ?>&<?= $add ?>" <?= !$i ? 'rel="canonical"' : '' ?>
                                   class="pagination__link"></a>
                            </li>
                        <?php
                        endfor; ?>
                        <?php
                        if ($pages > 6): ?>
                            <li class="pagination__item pagination__item_dots btn-pagination">
                                ...
                            </li>
                            <?php
                            if ($pages > 7): ?>
                                <li class="pagination__item btn btn_size-medium btn_style-secondary">
                                    <?= ceil($pages) - 1 ?>
                                    <a data-cb="<?= $data['cb'] ?>" data-pag="<?= ceil($pages) - 2 ?>"
                                       href="<?= $link ?>?<?= $key ?>=<?= ceil($pages) - 2 ?>&<?= $add ?>"
                                       class="pagination__link"></a>
                                </li>
                            <?php
                            endif; ?>
                            <li class="pagination__item btn btn_size-medium btn_style-secondary">
                                <?= ceil($pages) ?>
                                <a data-cb="<?= $data['cb'] ?>" data-pag="<?= ceil($pages) - 1 ?>"
                                   href="<?= $link ?>?<?= $key ?>=<?= ceil($pages) - 1 ?>&<?= $add ?>"
                                   class="pagination__link"></a>
                            </li>
                        <?php
                        endif; ?>
                    <?php
                    else: ?>
                        <li class="pagination__item btn btn_size-medium <?= 0 == $page ? 'btn_style-gray' : 'btn_style-secondary' ?>">
                            1
                            <a data-cb="<?= $data['cb'] ?>" data-pag="<?= 0 ?>"
                               href="<?= $link ?>?<?= $key ?>=0&<?= $add ?>" rel="canonical"
                               class="pagination__link"></a>
                        </li>
                        <li class="pagination__item btn btn_size-medium <?= 0 == $page ? 'btn_style-gray' : 'btn_style-secondary' ?>">
                            2
                            <a data-cb="<?= $data['cb'] ?>" data-pag="<?= 1 ?>"
                               href="<?= $link ?>?<?= $key ?>=1&<?= $add ?>" rel="canonical"
                               class="pagination__link"></a>
                        </li>
                        <li class="pagination__item pagination__item_dots btn-pagination">
                            ...
                        </li>
                    <?php
                    endif; ?>
                    <?php
                    if ($page >= 4): ?>
                        <?php
                        if ($page < $pages - 5): ?>
                            <?php
                            for ($i = $page - 2; $i < min($pages, $page + 3); ++$i): ?>
                                <li class="pagination__item btn btn_size-medium <?= $i == $page ? 'btn_style-gray' : 'btn_style-secondary' ?>">
                                    <?= $i + 1 ?>
                                    <a data-cb="<?= $data['cb'] ?>" data-pag="<?= $i ?>"
                                       href="<?= $link ?>?<?= $key ?>=<?= $i ?>&<?= $add ?>" <?= !$i ? 'rel="canonical"' : '' ?>
                                       class="pagination__link"></a>
                                </li>
                            <?php
                            endfor; ?>

                            <li class="pagination__item pagination__item_dots btn-pagination">
                                ...
                            </li>
                            <li class="pagination__item btn btn_size-medium btn_style-secondary">
                                <?= ceil($pages) - 1 ?>
                                <a data-cb="<?= $data['cb'] ?>" data-pag="<?= ceil($pages) - 2 ?>"
                                   href="<?= $link ?>?<?= $key ?>=<?= ceil($pages) - 2 ?>&<?= $add ?>"
                                   class="pagination__link"></a>
                            </li>
                            <li class="pagination__item btn btn_size-medium btn_style-secondary">
                                <?= ceil($pages) ?>
                                <a data-cb="<?= $data['cb'] ?>" data-pag="<?= ceil($pages) - 1 ?>"
                                   href="<?= $link ?>?<?= $key ?>=<?= ceil($pages) - 1 ?>&<?= $add ?>"
                                   class="pagination__link"></a>
                            </li>
                        <?php
                        else: ?>
                            <?php
                            for ($i = $page - 2; $i < min($pages, $page + 6); ++$i): ?>
                                <li class="pagination__item btn btn_size-medium <?= $i == $page ? 'btn_style-gray' : 'btn_style-secondary' ?>">
                                    <?= $i + 1 ?>
                                    <a data-cb="<?= $data['cb'] ?>" data-pag="<?= $i ?>"
                                       href="<?= $link ?>?<?= $key ?>=<?= $i ?>&<?= $add ?>" <?= !$i ? 'rel="canonical"' : '' ?>
                                       class="pagination__link"></a>
                                </li>
                            <?php
                            endfor; ?>
                        <?php
                        endif; ?>

                    <?php
                    endif; ?>

                    <li class="pagination__item pagination__item_icon-right btn_style-secondary btn btn_size-medium btn_icon-center btn-pagination-icon--next<?= !$hasNext ? ' pagination__item_hidden' : '' ?>">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="#404040" viewBox="0 0 24 24">
                            <path fill-rule="evenodd"
                                  d="M9.793 16.207a1 1 0 0 1 0-1.414l2.293-2.293-2.293-2.293a1 1 0 0 1 1.414-1.414l3 3a1 1 0 0 1 0 1.414l-3 3a1 1 0 0 1-1.414 0Z"
                                  clip-rule="evenodd"/>
                        </svg>
                        <?php
                        if ($hasNext): ?>
                            <a data-pag="<?= $page + 1 ?>" data-cb="<?= $data['cb'] ?>"
                               href="<?= $link ?>?<?= $key ?>=<?= $page + 1 ?>&<?= $add ?>"
                               class="pagination__link"></a>
                        <?php
                        else: ?>
                            <a data-pag="<?= $page + 1 ?>" data-cb="<?= $data['cb'] ?>" href="#"
                               class="pagination__link"></a>
                        <?php
                        endif; ?>
                    </li>
                </ul>
            </div>
            <div class="pagination__search" data-max="<?= ceil($pages) - 1 ?>">
                <p class="pagination__search-text">Перейти на страницу:</p>
                <?php
                App\Layout\Components\Common\TextField\Layout::draw([
                    'class_name' => 'pagination__search-input',
                    'placeholder' => 'Стр.',
                    'name' => 'pagSearch',
                    'value' => '',
                ]); ?>
                <?php
                App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Перейти',
                    'style' => 'black',
                    'class_name' => 'pagination__search-button',
                    'type' => 'submit',
                ]); ?>
            </div>
        </div>
    </div>
    <!---- end Desktop ---->

    <!---- Mobile ---->
    <div class="pagination pagination--mobile <?= $data['className'] ?> <?= $data['pt'] ?> <?= $data['pb'] ?>">
        <div class="pagination__container container">
            <div class="pagination__inner">
                <ul class="pagination__block mob">

                    <li class="pagination__item pagination__item_icon-left btn_style-secondary btn btn_size-medium btn_icon-center btn-pagination-icon--prev <?= !$hasPrev ? 'pagination__item_hidden' : '' ?>">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                            <path fill="#404040" fill-rule="evenodd"
                                  d="M14.207 8.793a1 1 0 0 1 0 1.414L11.914 12.5l2.293 2.293a1 1 0 0 1-1.414 1.414l-3-3a1 1 0 0 1 0-1.414l3-3a1 1 0 0 1 1.414 0Z"
                                  clip-rule="evenodd"/>
                        </svg>

                        <a data-pag="<?= $page - 1 ?>" data-cb="<?= $data['cb'] ?>"
                           href="<?= $link ?>?<?= $key ?>=<?= $page - 1 ?>&<?= $add ?>" <?= !($page - 1) ? 'rel="canonical"' : '' ?>
                           class="pagination__link"></a>
                    </li>

                    <?php
                    if ($page < 4): ?>
                        <?php
                        for ($i = 0; $i < min(4, $pages); ++$i): ?>
                            <li class="pagination__item btn btn_size-medium <?= $i == $page ? 'btn_style-gray' : 'btn_style-secondary' ?>">
                                <?= $i + 1 ?>
                                <a data-cb="<?= $data['cb'] ?>" data-pag="<?= $i ?>"
                                   href="<?= $link ?>?<?= $key ?>=<?= $i ?>&<?= $add ?>" <?= !$i ? 'rel="canonical"' : '' ?>
                                   class="pagination__link"></a>
                            </li>
                        <?php
                        endfor; ?>
                        <?php
                        if ($pages > 6): ?>
                            <li class="pagination__item pagination__item_dots btn-pagination">
                                ...
                            </li>
                            <li class="pagination__item btn btn_size-medium btn_style-secondary">
                                <?= ceil($pages) ?>
                                <a data-cb="<?= $data['cb'] ?>" data-pag="<?= ceil($pages) - 1 ?>"
                                   href="<?= $link ?>?<?= $key ?>=<?= ceil($pages) - 1 ?>&<?= $add ?>"
                                   class="pagination__link"></a>
                            </li>
                        <?php
                        endif; ?>
                    <?php
                    else: ?>
                        <li class="pagination__item btn btn_size-medium <?= 0 == $page ? 'btn_style-gray' : 'btn_style-secondary' ?>">
                            1
                            <a data-cb="<?= $data['cb'] ?>" data-pag="<?= 0 ?>"
                               href="<?= $link ?>?<?= $key ?>=0&<?= $add ?>" rel="canonical"
                               class="pagination__link"></a>
                        </li>
                        <li class="pagination__item pagination__item_dots btn-pagination">
                            ...
                        </li>
                    <?php
                    endif; ?>
                    <?php
                    if ($page >= 4): ?>
                        <?php
                        if ($page < $pages - 2): ?>
                            <?php
                            for ($i = $page; $i < min($pages, $page + 1); ++$i): ?>
                                <li class="pagination__item btn btn_size-medium <?= $i == $page ? 'btn_style-gray' : 'btn_style-secondary' ?>">
                                    <?= $i + 1 ?>
                                    <a data-cb="<?= $data['cb'] ?>" data-pag="<?= $i ?>"
                                       href="<?= $link ?>?<?= $key ?>=<?= $i ?>&<?= $add ?>" <?= !$i ? 'rel="canonical"' : '' ?>
                                       class="pagination__link"></a>
                                </li>
                            <?php
                            endfor; ?>

                            <li class="pagination__item pagination__item_dots btn-pagination">
                                ...
                            </li>

                            <li class="pagination__item btn btn_size-medium btn_style-secondary">
                                <?= ceil($pages) ?>
                                <a data-cb="<?= $data['cb'] ?>" data-pag="<?= ceil($pages) - 1 ?>"
                                   href="<?= $link ?>?<?= $key ?>=<?= ceil($pages) - 1 ?>&<?= $add ?>"
                                   class="pagination__link"></a>
                            </li>
                        <?php
                        else: ?>
                            <?php
                            for ($i = $page - 1; $i < min($pages, $page + 4); ++$i): ?>
                                <li class="pagination__item btn btn_size-medium <?= $i == $page ? 'btn_style-gray' : 'btn_style-secondary' ?>">
                                    <?= $i + 1 ?>
                                    <a data-cb="<?= $data['cb'] ?>" data-pag="<?= $i ?>"
                                       href="<?= $link ?>?<?= $key ?>=<?= $i ?>&<?= $add ?>" <?= !$i ? 'rel="canonical"' : '' ?>
                                       class="pagination__link"></a>
                                </li>
                            <?php
                            endfor; ?>
                        <?php
                        endif; ?>

                    <?php
                    endif; ?>

                    <li class="pagination__item pagination__item_icon-right btn_style-secondary btn btn_size-medium btn_icon-center btn-pagination-icon--next<?= !$hasNext ? ' pagination__item_hidden' : '' ?>">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="#404040" viewBox="0 0 24 24">
                            <path fill-rule="evenodd"
                                  d="M9.793 16.207a1 1 0 0 1 0-1.414l2.293-2.293-2.293-2.293a1 1 0 0 1 1.414-1.414l3 3a1 1 0 0 1 0 1.414l-3 3a1 1 0 0 1-1.414 0Z"
                                  clip-rule="evenodd"/>
                        </svg>

                        <a data-pag="<?= $page + 1 ?>" data-cb="<?= $data['cb'] ?>"
                           href="<?= $link ?>?<?= $key ?>=<?= $page + 1 ?>&<?= $add ?>"
                           class="pagination__link"></a>
                    </li>
                </ul>
            </div>
            <div class="pagination__search" data-max="<?= ceil($pages) - 1 ?>">
                <p class="pagination__search-text">Перейти на страницу:</p>
                <?php
                App\Layout\Components\Common\TextField\Layout::draw([
                    'class_name' => 'pagination__search-input',
                    'placeholder' => 'Стр.',
                    'name' => 'pagSearch',
                    'value' => '',
                ]); ?>
                <?php
                App\Layout\Components\Common\Button\Layout::draw([
                    'text' => 'Перейти',
                    'style' => 'black',
                    'class_name' => 'pagination__search-button',
                    'type' => 'button',
                ]); ?>
            </div>
        </div>
    </div>
    <!---- end Mobile ---->
<?php
endif; ?>

