{**
 * Страница с формой поиска
 *
 * @param array resultItems
 * @param array paging
 * @param array searchType
 * @param array query
 * @param array typeCounts
 *}

{extends 'layouts/layout.base.tpl'}

{block 'layout_page_title'}
    {$aLang.search.search}
{/block}

{block 'layout_content'}
    {include 'components/search/search-form.main.tpl' searchType=$searchType}
    {include 'navs/nav.search.tpl'}

    {if $resultItems}
        {if $searchType == 'topics'}
            {component 'topic' template='list' topics=$resultItems paging=$paging}
        {elseif $searchType == 'comments'}
            {component 'comment' template='list' comments=$resultItems paging=$paging}
        {else}
            {hook run='search_result' type=$searchType}
        {/if}
    {elseif $_aRequest.q}
        {component 'alert' text=$aLang.search.alerts.empty mods='empty'}
    {/if}
{/block}