{**
 * Создание блога
 *
 * @param array  $blogCategories Список категорий блогов
 * @param object $blogEdit       Блог, передается в случае если блог редактируется
 *
 * TODO: Вынести 'rangelength' в конфиг
 *}

{extends 'layouts/layout.base.tpl'}

{block 'layout_options' append}
    {if $sEvent == 'edit'}
        {$sNav = 'blog.edit'}
    {/if}
{/block}

{block 'layout_page_title'}
    {if $sEvent == 'add'}
        {$aLang.blog.add.title}
    {else}
        {$aLang.blog.admin.title}: <a href="{$blogEdit->getUrlFull()}">{$blogEdit->getTitle()|escape}</a>
    {/if}
{/block}

{block 'layout_content'}
    {component 'blog' template='add' blog=$blogEdit}
{/block}