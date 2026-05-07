<?php
/** @var array $data */

extract($data);

?>
<div class="tab-filter-m">
    <div class="tab-filter-m__control">
        <span class="tab-filter-m__title"><?= $title ?></span>
        <button class="tab-filter-m__toggle">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
                <path fill-rule="evenodd"
                      clip-rule="evenodd"
                      d="M9.79289 16.2071C9.40237 15.8166 9.40237 15.1834 9.79289 14.7929L12.0858 12.5L9.79289 10.2071C9.40237 9.81658 9.40237 9.18342 9.79289 8.79289C10.1834 8.40237 10.8166 8.40237 11.2071 8.79289L14.2071 11.7929C14.5976 12.1834 14.5976 12.8166 14.2071 13.2071L11.2071 16.2071C10.8166 16.5976 10.1834 16.5976 9.79289 16.2071Z"
                      fill="#0D0D0D"/>
            </svg>
        </button>
    </div>
    <div class="tab-filter-m__tags" data-tags="<?= $id == 'brand' ? $id : ('param_' . $id) ?>[]"
         style="<?= isset($_REQUEST[$paramKey]) && $_REQUEST[$paramKey] ? '' : 'display:none' ?>">
        <?php
        $paramKey = $id == 'brand' ? 'brand' : 'param_' . $id;
        if (isset($_REQUEST[$paramKey]) && is_array($_REQUEST[$paramKey])):
            foreach ($_REQUEST[$paramKey] as $v):
                $displayText = '';
                if ($id == 'brand') {
                    $displayText = (new \App\Extensions\Catalog\Model\Brand($v))->name;
                } else {
                    foreach ($items as $vv) {
                        if ($vv['param_id'] == $id && $vv['value'] == $v) {
                            $displayText = $vv['value'];
                            break;
                        }
                    }
                }
                if ($displayText):
                    App\Layout\UIKit\TagFilter\Layout::draw([
                        'text' => $displayText,
                        'style' => $id == 'brand' ? 'default' : 'red',
                        'dt' => 'data-tag="' . htmlspecialchars($v) . '"'
                    ]);
                endif;
            endforeach;
        endif;
        ?>

        <?php
        App\Layout\UIKit\TagFilter\Layout::draw([
            'text' => 'Очистить всё',
            'dt' => 'data-reset="reset"',
            'style' => 'gray',
        ]);
        ?>
    </div>
</div>