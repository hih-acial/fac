{* 
 * TestLink Open Source Project - http://testlink.sourceforge.net/ 
 * $Id: reqmanagesubs.tpl,v 1.9 2016/22/02
 *
 * Purpose: List requirements in an ExtJS Table, with the ability to subscribe or unsubscribe requirements.
 * 
 * @internal revisions
 *
 *}

{lang_get var="labels" 
          s='testproject_has_no_reqspec, testproject_has_no_requirements,
             all_versions_displayed, latest_version_displayed, 
             dont_show_all_versions_btn'}

{include file="inc_head.tpl" openHead="yes"}
{include file="custom.tpl"}
{foreach from=$gui->tableSet key=idx item=matrix name="initializer"}
  {$tableID="table_$idx"}
  {if $smarty.foreach.initializer.first}
    {$matrix->renderCommonGlobals()}
    {if $matrix instanceof tlExtTable}
      {include file="inc_ext_js.tpl" bResetEXTCss=1}
      {include file="inc_ext_table.tpl"}
    {/if}
  {/if}
  {$matrix->renderHeadSection($tableID)}
{/foreach}
</head>

<body>
<section class="jumbotron">
  <h2 class="text-center">{$gui->pageTitle|escape}</h2>
</section>


<div class="container">

{foreach from=$gui->tableSet key=idx item=matrix}
{$tableID="table_$idx"}
  {$matrix->renderBodySection($tableID)}
{/foreach}

<br/>

</div>

</body>

</html>