{* TestLink Open Source Project - http://testlink.sourceforge.net/
 * $Id: staticPage.tpl,v 1.3 2010/05/01 18:49:19 franciscom Exp $
 * Purpose: smarty template - generic frame to add any content
 *
 * @internal revisions
 *  20100501 - franciscom - BUGID 3410: Smarty 3.0 compatibility
 *}
{include file="inc_head.tpl"}
{include file="custom.tpl"}
<body>

{if $gui->pageTitle != ""}
    <section class="jumbotron">
        <h2 class="text-center">{$gui->pageTitle|escape}</h2>
    </section>
{/if}

<div class="container">
{$gui->pageContent}
</div>

{if $gui->refreshTree}
   {include file="inc_refreshTree.tpl"}
{/if}
</body>
</html>