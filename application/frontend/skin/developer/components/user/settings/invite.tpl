{**
 * Управление инвайтами
 *}

<small class="note mb-20">
	{lang name='user.settings.invites.note'}
</small>

{hook run='settings_invite_begin'}

<form action="" method="POST" enctype="multipart/form-data">
	{hook run='form_settings_invite_begin'}

	<p>
		{lang name='user.settings.invites.available'}:
		<strong>
			{if $oUserCurrent->isAdministrator()}
				{lang name='user.settings.invites.many'}
			{else}
				{$iCountInviteAvailable}
			{/if}
		</strong><br />

		{lang name='user.settings.invites.used'}: <strong>{$iCountInviteUsed}</strong>
	</p>

    {* E-mail *}
    {component 'field' template='text'
             name  = 'invite_mail'
             note  = {lang name='user.settings.invites.fields.email.note'}
             label = {lang name='user.settings.invites.fields.email.label'}}

	{hook run='form_settings_invite_end'}

    {* Скрытые поля *}
    {component 'field' template='hidden.security-key'}

    {* Кнопки *}
    {component 'button' name='submit_invite' mods='primary' text={lang name='user.settings.invites.fields.submit.text'}}
</form>

{hook run='settings_invite_end'}