<dialog class="modal-notification">
    <div class="modal-notification__container">
        <div class="modal-notification__top">
            <p class="modal-notification__title">Подтверждение отправлено</p>
            <p class="modal-notification__desc">Ссылка отправлена на ваш почтовый адрес. Перейдите по ней, чтобы восстановить пароль</p>
        </div>
        <div class="modal-notification__bottom">
            <?php App\Layout\Components\Common\Button\Layout::draw([
                'text' => 'Закрыть',
                'style' => 'primary',
                'class_name' => 'modal-notification__button modal-notification__button_close',
                'type' => 'button',
            ]); ?>
        </div>
    </div>
</dialog>
