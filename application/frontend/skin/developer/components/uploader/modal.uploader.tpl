{**
 * Загрузка медиа-файлов
 *}

{extends 'components/modal/modal.tpl'}

{block 'modal_options' append}
    {$mods = "$mods uploader"}
    {$attributes = array_merge( $attributes|default:[], [ 'data-modal-center' => 'false' ] )}
{/block}

{block 'modal_content'}
    {component 'uploader' classes='js-uploader-modal'}
{/block}

{block 'modal_footer_cancel' append}
    {component 'button' type='button' mods='primary' text={lang 'common.choose'} classes='js-uploader-modal-choose'}
{/block}