{*
TestLink Open Source Project - http://testlink.sourceforge.net/

@filesource	execDashboard.tpl
@internal revisions
@since 1.9.10
*}
{$title_sep=$smarty.const.TITLE_SEP}
{$title_sep_type3=$smarty.const.TITLE_SEP_TYPE3}
{lang_get var='labels'
          s='build_is_closed,test_cases_cannot_be_executed,build,builds_notes,testplan,
             test_plan_notes,platform,platform_description'}

{$cfg_section=$smarty.template|basename|replace:".tpl":""}
{config_load file="input_dimensions.conf" section=$cfg_section}

{include file="inc_head.tpl" popup='yes' openHead='yes'}
{include file="../custom.tpl"}
{if #ROUND_EXEC_HISTORY# || #ROUND_TC_TITLE# || #ROUND_TC_SPEC#}
  {$round_enabled=1}
  <script language="JavaScript" src="{$basehref}gui/niftycube/niftycube.js" type="text/javascript"></script>
{/if}

<body>

<section class="jumbotron">
    <h3 class="text-center">
        {$gui->pageTitlePrefix}
        {$labels.testplan} {$gui->testplan_name|escape} {$title_sep_type3} {$labels.build} {$gui->build_name|escape}
        {if $gui->platform_info.name != ""}
            {$title_sep_type3}{$labels.platform}{$title_sep}{$gui->platform_info.name|escape}
        {/if}
    </h3>
</section>

<section class="container">
  {if $gui->build_is_open == 0}

        <div class="alert alert-danger" role="alert">
            {$labels.build_is_closed} <br>
            {$labels.test_cases_cannot_be_executed}
        </div>
    <br>
  {/if}
    <div class="alert alert-primary" role="alert">
        {$labels.testplan} : {$gui->testplan_name|escape}
        <br>
        {if $gui->testPlanEditorType == 'none'}{$gui->testplan_notes|nl2br}{else}{$gui->testplan_notes}{/if}
        {if $gui->testplan_cfields neq ''} <div class="text-dark">{$gui->testplan_cfields}</div>{/if}
        <br>
        {$labels.build} : {$gui->build_name|escape}
        <br>
        {if $gui->platform_info.id > 0}
            {$labels.platform} : {$gui->platform_info.name|escape}
            <br>
            {if $gui->platformEditorType == 'none'}{$gui->platform_info.notes|nl2br}{else}{$gui->platform_info.notes}{/if}
            <br>
        {/if}
        {if $gui->buildEditorType == 'none'}{$gui->build_notes|nl2br}{else}{$gui->build_notes}{/if}
        <br>
        {if $gui->build_cfields != ''} <div id="cfields_build" class="custom_field_container">{$gui->build_cfields}</div>{/if}
    </div>

</section>
</body>
