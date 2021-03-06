{**
 * Шапка профиля
 *}

{$component = 'user-profile'}

{$user = $smarty.local.user}
{$mods = $smarty.local.mods}

{if $user->getProfileName()}
	{$mods = "{$mods} has-name"}
{/if}

<div class="{$component} {cmods name=$component mods=$mods} {$smarty.local.classes}" {cattr list=$smarty.local.attributes}>
	{hook run='profile_top_begin' user=$user}

	{* Пользователь *}
	<div class="{$component}-user">
		<a href="{$user->getUserWebPath()}">
			<img src="{$user->getProfileAvatarPath(64)}" alt="{$user->getProfileName()}" class="{$component}-user-avatar js-user-profile-avatar" itemprop="photo">
		</a>

		<h2 class="{$component}-user-login word-wrap" itemprop="nickname">
			<a href="{$user->getUserWebPath()}">
				{$user->getLogin()}
			</a>
		</h2>

		{if $user->getProfileName()}
			<p class="{$component}-user-name" itemprop="name">
				{$user->getProfileName()|escape}
			</p>
		{/if}
	</div>

	{* Голосование *}
	{component 'vote'
			 classes   = 'js-vote-user'
			 mods      = 'large'
			 target    = $user
			 isLocked  = true
			 showLabel = true}

	{hook run='profile_top_end' user=$user}
</div>