{**
 * Кнопка экшнбара
 *
 * @param string $icon
 * @param string $text
 * @param string $url
 * @param string $show
 * @param string $classes
 * @param array  $attributes
 *}

{$component = 'actionbar-item'}

{if $smarty.local.show|default:true}
    <li class="{$component}">
        {block 'actionbar_item'}
            {component 'button'
                url        = $smarty.local.url
                classes    = "{$component}-link {$smarty.local.classes}"
                text       = $smarty.local.text
                icon       = $smarty.local.icon
                attributes = $smarty.local.attributes}
        {/block}
    </li>
{/if}