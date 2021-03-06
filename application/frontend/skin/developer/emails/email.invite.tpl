{**
 * Приглашение на сайт
 *}

{extends 'components/email/email.tpl'}

{block 'content'}
	{lang name='emails.invite.text' params=[
		'user_url'     => $oUserFrom->getUserWebPath(),
		'user_name'    => $oUserFrom->getDisplayName(),
		'website_url'  => Router::GetPath('/'),
		'website_name' => Config::Get('view.name'),
		'invite_code'  => $oInvite->getCode(),
		'login_url'    => {router page='login'}
	]}
{/block}