{**
 * Блог в списке блогов
 *
 * @param object $blog
 *}

{extends 'components/item/item.tpl'}

{block 'options' append}
    {$blog = $smarty.local.blog}

    {* Заголовок *}
    {capture 'blog_list_item_title'}
        {if $blog->getType() == 'close'}
            <i title="{$aLang.blog.private}" class="icon-lock"></i>
        {/if}

        <a href="{$blog->getUrlFull()}">{$blog->getTitle()|escape}</a>
    {/capture}

    {$title = $smarty.capture.blog_list_item_title}

    {* Описание *}
    {capture 'blog_list_item_desc'}
        {$blog->getDescription()|strip_tags|truncate:120}
    {/capture}

    {$desc = $smarty.capture.blog_list_item_desc}

    {* Описание *}
    {capture 'blog_list_item_content'}
        {* Информация *}
        {$info = [
            [ 'label' => "{$aLang.blog.users.readers_total}:", 'content' => "<span class=\"js-blog-users-count\" data-blog-id=\"{$blog->getId()}\">{$blog->getCountUser()}</span>" ],
            [ 'label' => "{$aLang.blog.topics_total}:",        'content' => $blog->getCountTopic() ]
        ]}

        {if $blog->category->getCategory()}
            {$info[] = [ 'label' => "{$aLang.blog.categories.category}:", 'content' => $blog->category->getCategory()->getTitle() ]}
        {/if}

        {component 'info-list' list=$info classes='object-list-item-info'}

        {* Действия *}
        <div class="blog-list-item-actions">
            {* Вступить/покинуть блог *}
            {include './join.tpl' blog=$blog}
        </div>
    {/capture}

    {$content = $smarty.capture.blog_list_item_content}

    {* Изображение *}
    {$image = [
        'url' => $blog->getUrlFull(),
        'path' => $blog->getAvatarPath( 100 ),
        'alt' => $blog->getTitle()|escape
    ]}
{/block}