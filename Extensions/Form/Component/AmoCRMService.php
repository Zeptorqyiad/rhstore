<?php

namespace App\Extensions\Form\Component;

use AmoCRM\Client\AmoCRMApiClient;
use AmoCRM\Models\ContactModel;
use AmoCRM\Models\LeadModel;
use AmoCRM\Models\CustomFieldsValues\TextCustomFieldValuesModel;
use AmoCRM\Models\CustomFieldsValues\ValueCollections\TextCustomFieldValueCollection;
use AmoCRM\Models\CustomFieldsValues\ValueModels\TextCustomFieldValueModel;
use AmoCRM\Collections\CustomFieldsValuesCollection;
use League\OAuth2\Client\Token\AccessToken;
use AmoCRM\Exceptions\AmoCRMApiException;
use AmoCRM\Helpers\EntityTypesInterface;

use AmoCRM\Models\CustomFieldsValues\ValueCollections\MultiselectCustomFieldValueCollection;
use AmoCRM\Models\CustomFieldsValues\ValueModels\MultiselectCustomFieldValueModel;

class AmoCRMService
{
    private $apiClient;

    // === ЗАМЕНИ НА СВОИ ID ПОЛЕЙ ИЗ amoCRM ===
    private const FIELD_UTM_SOURCE = 185449;
    private const FIELD_UTM_MEDIUM = 185451;
    private const FIELD_UTM_CAMPAIGN = 185453;
    private const FIELD_UTM_TERM = 185457;
    private const FIELD_UTM_CONTENT = 185455;
    private const FIELD_ROISTAT = 238639;
    private const FIELD_YA_CID = 185461;

    private const FIELD_SOURCE = 262369;  // ID поля "Источник"
    private const ENUM_SITE = 365411;     // ID варианта "Сайт"

    public function __construct()
    {
        $clientId = 'cb47840e-34f1-49be-ab69-91421b4130ab';
        $clientSecret = '0DNP2Ycaw6VsmPIWZjO02o8Or9fBVXFdnNKjiYFLu7hhH4TibDFI3EKOVDXpZlhj';
        $redirectUri = 'https://rhstore.net/amocrm/oauth.php';

        $this->apiClient = new AmoCRMApiClient($clientId, $clientSecret, $redirectUri);
        $this->apiClient->setAccountBaseDomain('grhino.amocrm.ru');

        $tokenFile = $_SERVER['DOCUMENT_ROOT'] . '/amocrm/token.json';

        if (file_exists($tokenFile)) {
            $tokenData = json_decode(file_get_contents($tokenFile), true);

            if (isset($tokenData['token']) && !isset($tokenData['access_token'])) {
                $tokenData['access_token'] = $tokenData['token'];
            }

            $accessToken = new AccessToken($tokenData);

            $this->apiClient->setAccessToken($accessToken)
                ->onAccessTokenRefresh(function (AccessToken $accessToken, $baseDomain) use ($tokenFile) {
                    file_put_contents($tokenFile, json_encode($accessToken->jsonSerialize()));
                });
        }
    }

    /**
     * Получает значение из GET → POST → COOKIE
     */
    private function getParam(string $name): string
    {
        if (isset($_GET[$name]) && $_GET[$name] !== '') return $_GET[$name];
        if (isset($_POST[$name]) && $_POST[$name] !== '') return $_POST[$name];
        if (isset($_REQUEST[$name]) && $_REQUEST[$name] !== '') return $_REQUEST[$name];
        if (isset($_COOKIE[$name]) && $_COOKIE[$name] !== '') return $_COOKIE[$name];
        return '';
    }

    /**
     * Добавляет текстовое кастомное поле в модель (лид или контакт)
     */
    private function addTextCustomField($model, int $fieldId, string $value): void
    {
        if (empty($value)) {
            return;
        }

        $customFields = $model->getCustomFieldsValues();
        if (!$customFields) {
            $customFields = new CustomFieldsValuesCollection();
            $model->setCustomFieldsValues($customFields);
        }

        $valueCollection = new TextCustomFieldValueCollection();
        $valueCollection->add((new TextCustomFieldValueModel())->setValue($value));

        $fieldValueModel = new TextCustomFieldValuesModel();
        $fieldValueModel->setFieldId($fieldId);
        $fieldValueModel->setValues($valueCollection);

        $customFields->add($fieldValueModel);
    }

    public function createLeadFromForm(string $phone, string $pageTitle = ''): bool
    {
        if (empty($phone)) {
            error_log("amoCRM: телефон пустой");
            return false;
        }

        // === Собираем UTM и roistat ===
        $utm_source   = $this->getParam('utm_source');
        $utm_medium   = $this->getParam('utm_medium');
        $utm_campaign = $this->getParam('utm_campaign');
        $utm_term     = $this->getParam('utm_term');
        $utm_content  = $this->getParam('utm_content');

        // roistat_visit — основной идентификатор визита
        $roistat_visit = $_COOKIE['roistat_visit'] ?? '';
        if (!$roistat_visit) {
            $roistat_visit = $_COOKIE['roistat_marker'] ?? '';
        }

        $ya_cid = $_COOKIE['ym_uid'] ?? '';

        try {
            error_log("amoCRM: creating lead. Phone: $phone, Roistat: $roistat_visit");

            // === Создаём контакт ===
            $contact = new ContactModel();
            $contact->setName('Заявка с сайта rhstore.net');

            // Телефон
            $phoneField = new \AmoCRM\Models\CustomFieldsValues\MultitextCustomFieldValuesModel();
            $phoneField->setFieldCode('PHONE');
            $phoneField->setValues(
                (new \AmoCRM\Models\CustomFieldsValues\ValueCollections\MultitextCustomFieldValueCollection())
                    ->add(
                        (new \AmoCRM\Models\CustomFieldsValues\ValueModels\MultitextCustomFieldValueModel())
                            ->setValue($phone)
                            ->setEnum('MOB')
                    )
            );

            $customFields = new CustomFieldsValuesCollection();
            $customFields->add($phoneField);
            $contact->setCustomFieldsValues($customFields);

            $addedContact = $this->apiClient->contacts()->addOne($contact);
            error_log("amoCRM: contact created, ID = " . $addedContact->getId());

            // === Создаём сделку ===
            $leadName = 'Заявка с сайта rhstore.net';
            if ($pageTitle) {
                $leadName .= ': ' . mb_substr($pageTitle, 0, 100);
            }

            $lead = new LeadModel();
            $lead->setName($leadName)
                ->setPipelineId(7594598)
                ->setStatusId(62865242);

            // Добавляем UTM и roistat в сделку
            $this->addTextCustomField($lead, self::FIELD_UTM_SOURCE, $utm_source);
            $this->addTextCustomField($lead, self::FIELD_UTM_MEDIUM, $utm_medium);
            $this->addTextCustomField($lead, self::FIELD_UTM_CAMPAIGN, $utm_campaign);
            $this->addTextCustomField($lead, self::FIELD_UTM_TERM, $utm_term);
            $this->addTextCustomField($lead, self::FIELD_UTM_CONTENT, $utm_content);
            $this->addTextCustomField($lead, self::FIELD_ROISTAT, $roistat_visit);
            $this->addTextCustomField($lead, self::FIELD_YA_CID, $ya_cid);

            // === УСТАНАВЛИВАЕМ ИСТОЧНИК = "Сайт" по умолчанию ===
            $sourceValueCollection = new MultiselectCustomFieldValueCollection();
            $sourceValueCollection->add(
                (new MultiselectCustomFieldValueModel())
                    ->setEnumId(self::ENUM_SITE)
            );

            $sourceField = new \AmoCRM\Models\CustomFieldsValues\MultiselectCustomFieldValuesModel();
            $sourceField->setFieldId(self::FIELD_SOURCE);
            $sourceField->setValues($sourceValueCollection);

            $leadCustomFields = $lead->getCustomFieldsValues();
            if (!$leadCustomFields) {
                $leadCustomFields = new CustomFieldsValuesCollection();
                $lead->setCustomFieldsValues($leadCustomFields);
            }
            $leadCustomFields->add($sourceField);

            $addedLead = $this->apiClient->leads()->addOne($lead);
            error_log("amoCRM: lead created, ID = " . $addedLead->getId());

            // === Привязываем контакт к сделке ===
            $links = new \AmoCRM\Collections\LinksCollection();
            $links->add($addedContact);
            $this->apiClient->leads()->link($addedLead, $links);

            // === Заметка со страницей ===
            if ($pageTitle || true) {
                $noteText = "📩 Новая заявка с сайта rhstore.net\n\n";
                $noteText .= "📄 Страница: $pageTitle\n";
                $noteText .= "📞 Телефон: $phone\n\n";

                $noteText .= "🔗 UTM-метки и аналитика:\n";
                if ($utm_source)   $noteText .= "• utm_source: $utm_source\n";
                if ($utm_medium)   $noteText .= "• utm_medium: $utm_medium\n";
                if ($utm_campaign) $noteText .= "• utm_campaign: $utm_campaign\n";
                if ($utm_term)     $noteText .= "• utm_term: $utm_term\n";
                if ($utm_content)  $noteText .= "• utm_content: $utm_content\n";
                if ($roistat_visit)$noteText .= "• Roistat visit: $roistat_visit\n";
                if ($ya_cid)       $noteText .= "• Yandex Client ID: $ya_cid\n";

                if (empty($utm_source) && empty($utm_medium) && empty($utm_campaign) &&
                    empty($utm_term) && empty($utm_content) && empty($roistat_visit) && empty($ya_cid)) {
                    $noteText .= "• UTM-метки отсутствуют\n";
                }

                $noteText .= "\nФорма обратной связи";

                $notesCollection = new \AmoCRM\Collections\NotesCollection();
                $commonNote = new \AmoCRM\Models\NoteType\CommonNote();
                $commonNote
                    ->setText($noteText)
                    ->setEntityId($addedLead->getId());

                $notesCollection->add($commonNote);

                $this->apiClient->notes(EntityTypesInterface::LEADS)->add($notesCollection);

                error_log("amoCRM: notes added in lead");
            }

            return true;

        } catch (AmoCRMApiException $e) {
            error_log('amoCRM API error: ' . $e->getMessage() . ' | Code: ' . $e->getCode() . ' | Validation errors: ' . print_r($e->getValidationErrors(), true));
            return false;
        } catch (\Throwable $e) {
            error_log('amoCRM fatal error: ' . $e->getMessage() . ' in ' . $e->getFile() . ':' . $e->getLine());
            return false;
        }
    }
}