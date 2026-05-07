<?php

use App\Extensions\Catalog\Price\PriceManager;
use App\Extensions\Catalog\Price\SaleProxy;
use App\Extensions\Catalog2\Model\Product;
use App\Layout\LayoutManager;
use Simflex\Auth\Auth\BasicAuthMiddleware;
use Simflex\Auth\Auth\Chain;
use Simflex\Auth\Auth\CookieMiddleware;
use Simflex\Auth\Auth\SessionMiddleware;
use Simflex\Auth\Bootstrap;
use Simflex\Core\Container;
use Simflex\Core\Core;
use Simflex\Core\EventManager;
use Simflex\Core\Factory;
use Simflex\Core\Log;
use Simflex\Core\Logger\FileLogger;
use Simflex\Core\Page;

class Init
{

    /**
     * @return Core
     */
    public static function _()
    {
        static::setTimezone();
        require_once SF_ROOT_PATH . '/vendor/autoload.php';
        static::loadEnv();
        require_once SF_ROOT_PATH . '/functions.php';
        static::setSessionParams();
        static::startDebug();
        static::startSession();
        static::setCharset();
        static::loadConfig();
        static::initServices();

//        \App\Extensions\Catalog\MailAssist::$templateDir = SF_ROOT_PATH . '/Extensions/Catalog2/tpl/mail/';

        // init loggers
        if (Container::getConfig()::$devMode) {
            Log::addLogger(Container::get('debugbar')->getMessages());
            Container::getConfig()::$logPath = $_SERVER['DOCUMENT_ROOT'] . '/uf/log';
        }

        Log::addLogger(new FileLogger());

        // setup class overrides
        static::setupOverrides();
        static::setAuthHandler();

        if (SF_LOCATION != SF_LOCATION_CLI) {
            \App\Extensions\Catalog\CategoryAssist::loadCounts();
            \App\Extensions\Catalog\LoadAssist::load();
            \App\Extensions\Catalog2\LoadAssist2::load();

            // don't do this on import... you idiot
            if (!str_contains(Container::getRequest()->getPath(), 'import')) {
                $user = Container::getUser();
                \App\Extensions\Catalog\SessionAssist::$cart = \App\Extensions\Catalog2\Model\Cart::getOrInsert(
                    $user->user_id ?: 0
                );
                \App\Extensions\Catalog\SessionAssist::$fav = \App\Extensions\Catalog\Model\Fav::getOrInsert(
                    $user->user_id ?: 0
                );
            }
        }

        // init page
        if (SF_LOCATION_ADMIN == SF_LOCATION) {
            Container::set('page', new \Simflex\Admin\Page());
            Container::set('core', \Simflex\Admin\Core::class);
        } elseif (SF_LOCATION_API == SF_LOCATION || SF_LOCATION_SITE == SF_LOCATION) {
            Container::set('page', new Page());
            Container::set('core', Core::class);
        }

        if (SF_LOCATION != SF_LOCATION_CLI) {
            $lastUpdate = (int)file_get_contents(SF_ROOT_PATH . '/cache/new_timeout_update');
            if (time() - $lastUpdate > 84600) {
                file_put_contents(SF_ROOT_PATH . '/cache/new_timeout_update', time());
                \Simflex\Core\DB::query('update catalog_product set is_new = 0 where new_timeout < unix_timestamp()');
            }

            $lastUpdate = (int)file_get_contents(SF_ROOT_PATH . '/cache/filter_update');
            if (time() - $lastUpdate > 84600) {
                file_put_contents(SF_ROOT_PATH . '/cache/filter_update', time());

                $cg = new \App\Extensions\Catalog\CacheGen();
                $cg->updateAll();
            }

            // setup price manager
            $man = new PriceManager();
            $man->addProxy(new \App\Extensions\Catalog2\Price\MultiPriceProxy());
            $man->addProxy(new SaleProxy());

            Container::set('price', $man);

            Container::getCore()::init();
            Container::getPage()::init();
            LayoutManager::init();
        }

        return Container::getCore();
    }

    protected static function setupOverrides()
    {
        $factory = Container::getFactory();

        $factory->override(
            \App\Extensions\Catalog\Model\Product::class,
            Product::class
        );

        $factory->override(
            \App\Extensions\Catalog\Model\Cart::class,
            \App\Extensions\Catalog2\Model\Cart::class
        );

        $factory->override(
            \Simflex\Core\Models\User::class,
            \App\Extensions\Catalog2\Model\User::class,
        );

        $factory->override(
            \App\Extensions\Catalog\Model\FakeCategory::class,
            \App\Extensions\Catalog2\Model\FakeCategory::class,
        );

        $factory->override(
            \App\Extensions\Catalog\Model\Category::class,
            \App\Extensions\Catalog2\Model\Category::class,
        );
    }

    protected static function loadConfig()
    {
        require_once SF_ROOT_PATH . '/config.php';
        Config::load();
        Container::set('config', new Config());
    }

    protected static function initServices()
    {
        $services = include Container::getConfig()::$servicesFile;
        foreach ($services as $service) {
            Container::set($service::getServiceName(), new $service());
        }

        $events = include Container::getConfig()::$eventsFile;

        $eventManager = Container::getEvents();
        $eventManager->subscribeAll($events);
    }

    protected static function loadEnv()
    {
        $dotenv = Dotenv\Dotenv::createImmutable(SF_ROOT_PATH);
        $dotenv->safeLoad();
    }

    protected static function setAuthHandler()
    {
        Container::setAuthHandler(function () {
            Bootstrap::authByMiddlewareChain(
                (new Chain([
                    new SessionMiddleware(),
                    new CookieMiddleware(),
                    new BasicAuthMiddleware(),
                ]))
            // You can change base user model for auth
//            ->setUserModelClass(YourUser::class)
            );
        });
    }

    public static function loadConstants()
    {
        require_once __DIR__ . '/../vendor/glushkovds/simflex/src/constants.php';
        require_once __DIR__ . '/../constants.php';
    }

    protected static function setTimezone()
    {
        date_default_timezone_set('Asia/Yekaterinburg');
    }

    /**
     * One session for all subdomains
     */
    protected static function setSessionParams()
    {
        if (\Simflex\Core\Config::$subdomainOneSession) {
            $baseDomain = implode('.', array_slice(explode('.', $_SERVER['HTTP_HOST']), 1));
            session_set_cookie_params(0, '/', ".$baseDomain");
        }
    }

    protected static function startDebug()
    {
        $_ENV['start'] = ['time' => microtime(true), 'memory' => memory_get_usage()];
    }

    protected static function startSession()
    {
        session_start();
    }

    protected static function setCharset()
    {
        ini_set('default_charset', 'UTF-8');
    }

}