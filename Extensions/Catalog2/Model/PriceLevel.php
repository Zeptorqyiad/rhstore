<?php

namespace App\Extensions\Catalog2\Model;

use App\Extensions\Catalog\Model\Cart;
use App\Extensions\Catalog\SessionAssist;
use Simflex\Core\Buffer;
use Simflex\Core\Container;
use Simflex\Core\DB;
use Simflex\Core\Helpers\Str;
use Simflex\Core\ModelBase;
use Simflex\Core\Models\User;

/**
 * @property int level_id
 * @property string name
 * @property double min
 * @property bool is_by_total
 * @property string desc
 * @property int level_ord
 */
class PriceLevel extends ModelBase
{
    protected static $primaryKeyName = 'level_id';
    protected static $table = 'catalog_price_level';

    public function getRangeFormatted(): string
    {
        $out = '';
        if ($this->min > 0) {
            $out .= 'от ' . Str::price($this->min);
        }

        $nextLevel = self::findAdv()->where('min > ' . $this->min)->orderBy('min')->limit(1)->fetchOne();
        if ($nextLevel) {
            if ($out) {
                $out .= ', ';
            }

            $out .= 'до ' . Str::price($nextLevel->min);
        }

        return $out;
    }

    public function getNextLevel(bool $ignore = false): ?self
    {
        return Buffer::getOrSet('pl.next.' . $this->level_ord, fn() => self::findAdv()->where(
            'level_ord > ' . $this->level_ord . ' and is_by_total = ' . ($ignore ?: $this->is_by_total)
        )->orderBy('level_ord')->limit(1)->fetchOne());
    }

    public function getPrevLevel(): ?self
    {
        return self::findAdv()->where(
            'level_ord < ' . $this->level_ord . ' and is_by_total = ' . $this->is_by_total
        )->orderBy('level_ord desc')->limit(1)->fetchOne();
    }

    public static function getAuto(): self
    {
        $user = Container::getUser();
        $q = $user ? static::getForUser($user) : (SessionAssist::$cart ? static::getForCart(
            SessionAssist::$cart
        ) : static::getDefault());
        if (!$q) {
            return static::getDefault();
        }

        return $q;
    }

    public static function getForUser(User $user): self
    {
        return Buffer::getOrSet('pl.user', function () use ($user) {
            $ul = $user->getLevel();
            if ($ul->unlock_id) {
                if ($q = self::findOne(['level_id' => $ul->unlock_id])) {
                    return $q;
                }
            }

            $cart = Cart::findOne(['user_id' => $user->user_id]);
            if (!$cart) {
                // return min non-total level
                return self::getDefault();
            }

            // find the one that fits the cart
            return self::getForCart($cart) ?: self::getDefault();
        });
    }

    public static function getDefault(): self
    {
        return Buffer::getOrSet(
            'pl.default',
            fn() => self::findAdv()->where('is_by_total = 0')->orderBy('level_ord')->limit(1)->fetchOne()
        );
    }

    public static function getForCart(Cart $cart): ?self
    {
        return Buffer::getOrSet('pl.cart.' . ($cart->level ?? 0), function () use ($cart) {
            return self::findOne(['level_ord' => $cart->level ?? 0, 'is_by_total' => 0]);
        });
    }
}