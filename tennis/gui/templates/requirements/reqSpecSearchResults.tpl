{* 
TestLink Open Source Project - http://testlink.sourceforge.net/
Purpose: show results for requirement specification search.
*}

{include file="inc_head.tpl" openHead='yes'}
{include file="custom.tpl"}
{foreach from=$gui->tableSet key=idx item=matrix name="initializer"}
  {$tableID=$matrix->tableID}
  {if $smarty.foreach.initializer.first}
    {$matrix->renderCommonGlobals()}
    {if $matrix instanceof tlExtTable}
        {include file="inc_ext_js.tpl" bResetEXTCss=1}
        {include file="inc_ext_table.tpl"}
    {/if}
  {/if}
  {$matrix->renderHeadSection()}
{/foreach}

</head>

<section class="jumbotron">
  <h3 class="text-center">{$gui->pageTitle}</h3>
</section>

<div class="container">
  <div class="alert alert-primary">
      {lang_get s='info_search_req_spec'}<br><br>
      {lang_get s='generated_by_TestLink_on'} {$smarty.now|date_format:$gsmarty_timestamp_format}
  </div>

{if $gui->warning_msg == ''}
  {foreach from=$gui->tableSet key=idx item=matrix}
    {$tableID="table_$idx"}
    {$matrix->renderBodySection($tableID)}
  {/foreach}
{else}
  <div class="alert alert-warning">
  {$gui->warning_msg}
  </div>
{/if}   
</div>
</body>
</html>