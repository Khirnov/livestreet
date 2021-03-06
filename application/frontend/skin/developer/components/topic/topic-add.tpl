{**
 * Базовая форма создания топика
 *
 * @param object $topic
 * @param object $type
 * @param array  $blogs
 * @param array  $blogId
 *}

{$topic = $smarty.local.topic}
{$type = $smarty.local.type}

{block 'add_topic_options'}{/block}

{hook run="add_topic_begin"}
{block 'add_topic_header_after'}{/block}


<form action="" method="POST" enctype="multipart/form-data" id="topic-add-form" class="js-form-validate" data-content-action="{( $topic ) ? 'edit' : 'add'}">
    {hook run="form_add_topic_begin"}
    {block 'add_topic_form_begin'}{/block}


    {* Выбор блога *}
    {if ! $smarty.local.skipBlogs}
        {$blogsSelect = []}

        {foreach $smarty.local.blogs as $blogType => $blogs}
            {$blogsSelectOptions = []}

            {foreach $blogs as $blog}
                {$blogsSelectOptions[] = [
                    'text' => $blog->getTitle()|escape,
                    'value' => $blog->getId()
                ]}
            {/foreach}

            {$blogsSelect[] = [
                'text' => {lang "blog.types.{$blogType}"},
                'value' => $blogsSelectOptions
            ]}
        {/foreach}

        {component 'field' template='select'
            label         = $aLang.topic.add.fields.blog.label
            name          = 'topic[blogs_id_raw][]'
            placeholder   = 'Выберите блоги для публикации'
            inputClasses  = 'js-topic-add-blogs'
            isMultiple    = true
            selectedValue = ( ( $topic ) ? $topic->getBlogsId() : [] )
            items         = $blogsSelect}
    {/if}


    {* Заголовок топика *}
    {component 'field' template='text'
        name        = 'topic[topic_title]'
        value       = {(( $topic ) ? $topic->getTitle() : '')|escape}
        entityField = 'topic_title'
        entity      = 'ModuleTopic_EntityTopic'
        label       = $aLang.topic.add.fields.title.label}

    {block 'add_topic_form_text_before'}{/block}


    {* Текст топика *}
    {if $type->getParam('allow_text')}
        {component 'editor'
            name            = 'topic[topic_text_source]'
            value           = (( $topic ) ? $topic->getTextSource() : '')|escape
            label           = $aLang.topic.add.fields.text.label
            entityField     = 'topic_text_source'
            entity          = 'ModuleTopic_EntityTopic'
            inputClasses    = 'js-editor-default'
            mediaTargetType = 'topic'
            mediaTargetId   = ( $topic ) ? $topic->getId() : ''}
    {/if}

    {block 'add_topic_form_text_after'}{/block}


    {* Теги *}
    {if $type->getParam('allow_tags')}
        {component 'field' template='text'
            name    = 'topic[topic_tags]'
            value     = {(( $topic ) ? $topic->getTags() : '')|escape}
            rules   = [ 'required' => true, 'rangetags' => '[1,15]' ]
            label   = {lang 'topic.add.fields.tags.label'}
            note    = {lang 'topic.add.fields.tags.note'}
            inputClasses = 'width-full autocomplete-tags-sep'}
    {/if}


    {* Показывает дополнительные поля *}
    {insert name='block' block='propertyUpdate' params=[
        'target'      => $topic,
        'entity'      => 'ModuleTopic_EntityTopic',
        'target_type' => "topic_{$type->getCode()}"
    ]}


    {* Выбор превью *}
    {component 'field' template='image-ajax'
        label      = 'Превью'
        modalTitle = 'Выбор превью для топика'
        targetType = 'topic'
        targetId   = ( $topic ) ? $topic->getId() : ''
        classes    = 'js-topic-add-field-image-preview'}


    {* Вставка опросов *}
    {if $type->getParam('allow_poll')}
        {component 'poll' template='manage'
            targetType = 'topic'
            targetId   = ( $topic ) ? $topic->getId() : ''}
    {/if}


    {* Запретить комментарии *}
    {component 'field' template='checkbox'
        name    = 'topic[topic_forbid_comment]'
        checked = {( $topic && $topic->getForbidComment() ) ? true : false }
        note    = $aLang.topic.add.fields.forbid_comments.note
        label   = $aLang.topic.add.fields.forbid_comments.label}


    {* Принудительный вывод топиков на главную (доступно только админам) *}
    {if $oUserCurrent->isAdministrator()}
        {component 'field' template='checkbox'
            name    = 'topic[topic_publish_index]'
            checked = {($topic && $topic->getPublishIndex()) ? true : false }
            note    = $aLang.topic.add.fields.publish_index.note
            label   = $aLang.topic.add.fields.publish_index.label}

        {component 'field' template='checkbox'
            name    = 'topic[topic_skip_index]'
            checked = {($topic && $topic->getSkipIndex()) ? true : false }
            note    = $aLang.topic.add.fields.skip_index.note
            label   = $aLang.topic.add.fields.skip_index.label}
    {/if}


    {block 'add_topic_form_end'}{/block}
    {hook run="form_add_topic_end"}


    {* Скрытые поля *}
    {component 'field' template='hidden' name='topic_type' value=$type->getCode()}

    {if $topic}
        {include "components/field/field.hidden.tpl" name='topic[id]' value=$topic->getId()}
    {/if}


    {**
     * Кнопки
     *}

    {* Опубликовать / Сохранить изменения *}
    {component 'button'
        id      = {( $topic ) ? 'submit-edit-topic-publish' : 'submit-add-topic-publish' }
        mods    = 'primary'
        classes = 'fl-r'
        text    = $aLang.topic.add.button[ ( $sEvent == 'add' or ( $topic && $topic->getPublish() == 0 ) ) ? 'publish' : 'update' ]}

    {* Превью *}
    {component 'button' type='button' classes='js-topic-preview-text-button' text=$aLang.common.preview_text}

    {* Сохранить в черновиках / Перенести в черновики *}
    {if ! $topic || ( $topic && $topic->getPublish() != 0 )}
        {component 'button' type='button' classes='js-topic-draft-button' text=$aLang.topic.add.button[ ( $sEvent == 'add' ) ? 'save_as_draft' : 'mark_as_draft' ]}
    {/if}
</form>


{* Блок с превью текста *}
{include './topic-preview.tpl'}

{block 'add_topic_end'}{/block}
{hook run="add_topic_end"}