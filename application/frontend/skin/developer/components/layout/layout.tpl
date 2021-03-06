<!doctype html>

{block 'layout_options' append}{/block}

{$sRTL = ( Config::Get('view.rtl') ) ? 'dir="rtl"' : ''}
{$sLang = Config::Get('lang.current')}

<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="{$sLang}" {$sRTL}> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="{$sLang}" {$sRTL}> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="{$sLang}" {$sRTL}> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="{$sLang}" {$sRTL}> <!--<![endif]-->

<head>
	{block 'layout_head'}
		<meta charset="utf-8">

		<meta name="description" content="{block 'layout_description'}{$sHtmlDescription}{/block}">
		<meta name="keywords" content="{block 'layout_keywords'}{$sHtmlKeywords}{/block}">

		<title>{block 'layout_title'}{$sHtmlTitle}{/block}</title>

		{* RSS *}
		{if $aHtmlRssAlternate}
			<link rel="alternate" type="application/rss+xml" href="{$aHtmlRssAlternate.url}" title="{$aHtmlRssAlternate.title}">
		{/if}

		{* Canonical *}
		{if $sHtmlCanonical}
			<link rel="canonical" href="{$sHtmlCanonical}" />
		{/if}

		{**
		 * Стили
		 * CSS файлы подключаются в конфиге шаблона (ваш_шаблон/settings/config.php)
		 *}
		{block 'layout_head_styles'}
			{* Подключение стилей указанных в конфиге *}
			{$aHtmlHeadFiles.css}
		{/block}

		<link href="{cfg name='path.skin.assets.web'}/images/favicons/favicon.ico?v1" rel="shortcut icon" />
		<link rel="search" type="application/opensearchdescription+xml" href="{router page='search'}opensearch/" title="{cfg name='view.name'}" />

		<script>
			var	PATH_ROOT 					= '{router page='/'}',
				PATH_SKIN		 			= '{cfg name="path.skin.web"}',
				PATH_FRAMEWORK_FRONTEND		= '{cfg name="path.framework.frontend.web"}',
				PATH_FRAMEWORK_LIBS_VENDOR	= '{cfg name="path.framework.libs_vendor.web"}',
				/**
				 * Для совместимости с прошлыми версиями. БУДУТ УДАЛЕНЫ
				 */
				DIR_WEB_ROOT 				= '{cfg name="path.root.web"}',
				DIR_STATIC_SKIN 			= '{cfg name="path.skin.web"}',
				DIR_STATIC_FRAMEWORK 		= '{cfg name="path.framework.frontend.web"}',
				DIR_ENGINE_LIBS	 			= '{cfg name="path.framework.web"}/libs',

				LIVESTREET_SECURITY_KEY = '{$LIVESTREET_SECURITY_KEY}',
				LANGUAGE				= '{Config::Get('lang.current')}',
				WYSIWYG					= {if Config::Get('view.wysiwyg')}true{else}false{/if};

			var aRouter = [];
			{foreach $aRouter as $sPage => $sPath}
				aRouter['{$sPage}'] = '{$sPath}';
			{/foreach}
		</script>

		{**
		 * JavaScript файлы
		 * JS файлы подключаются в конфиге шаблона (ваш_шаблон/settings/config.php)
		 *}
		{block 'layout_head_scripts'}
			{* Подключение скриптов указанных в конфиге *}
			{$aHtmlHeadFiles.js}
		{/block}
	{/block}

	{hook run='html_head_end'}
</head>


{**
 * Вспомогательные классы
 *
 * ls-user-role-guest        Посетитель - гость
 * ls-user-role-user         Залогиненый пользователь - обычный пользователь
 * ls-user-role-admin        Залогиненый пользователь - админ
 * ls-user-role-not-admin    Залогиненый пользователь - не админ
 * ls-template-*             Класс с названием активного шаблона
 *}
{if $oUserCurrent}
	{$sBodyClasses = $sBodyClasses|cat:' ls-user-role-user'}

	{if $oUserCurrent->isAdministrator()}
		{$sBodyClasses = $sBodyClasses|cat:' ls-user-role-admin'}
	{/if}
{else}
	{$sBodyClasses = $sBodyClasses|cat:' ls-user-role-guest'}
{/if}

{if !$oUserCurrent or !$oUserCurrent->isAdministrator()}
	{$sBodyClasses = $sBodyClasses|cat:' ls-user-role-not-admin'}
{/if}

{$sBodyClasses = $sBodyClasses|cat:' ls-template-'|cat:{cfg name="view.skin"}}


<body class="{$sBodyClasses} layout-{cfg name='view.grid.type'} {block 'layout_body_classes'}{/block}">
	{block 'layout_body'}{/block}

	{$sLayoutAfter}

	{hook run='body_end'}
</body>
</html>