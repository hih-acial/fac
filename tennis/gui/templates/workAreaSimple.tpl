{*
TestLink Open Source Project - http://testlink.sourceforge.net/
$Id: workAreaSimple.tpl,v 1.5 2009/05/18 20:22:10 schlundus Exp $
Purpose: show workarea with simple structure title + content + link
*}
{include file="inc_head.tpl"}
{include file="custom.tpl"}
<body>
{if isset($title) && $title ne ''}
	<section class="jumbotron">
		<h1 class="text-center">{$title|escape}</h1>
	</section>
{/if}

<div>

{if $content ne ''}
	{$content}
{/if}

{* 20060809 - franciscom - if user can solve the problem give him/her the url *}
{if $link_to_op ne ''}
	<div class="text-center">
  		<a class="btn btn-info" href="{$basehref}{$link_to_op}">{$hint_text}</a>
	</div>
{/if}

</div>

</body>
