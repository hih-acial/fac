{*
TestLink Open Source Project - http://testlink.sourceforge.net/
@filesource  tcAssign2Tplan.tpl
Purpose: manage assignment of A test case version to N test plans
         while working on test specification


*}
{lang_get var='labels'
s='testproject,test_plan,th_id,please_select_one_testplan,platform,btn_cancel,
             cancel,warning,version,btn_add,testplan_usage,no_test_plans,design,
             execution_history'}

{include file="inc_head.tpl" openHead="yes"}
{include file="inc_jsCheckboxes.tpl"}
{include file="inc_del_onclick.tpl"}
{include file="../custom.tpl"}
<script type="text/javascript">
    var check_msg="{$labels.please_select_one_testplan|escape:'javascript'}";
    var alert_box_title = "{$labels.warning|escape:'javascript'}";

    function check_action_precondition(container_id,action)
    {
        if(checkbox_count_checked(container_id) <= 0)
        {
            alert_message(alert_box_title,check_msg);
            return false;
        }
        return true;
    }
</script>

{$ll = '[25, 50, 75, -1], [25, 50, 75, "All"]'}
{include file="DataTables.inc.tpl" DataTablesOID="item_view" DataTableslengthMenu=$ll}

</head>
<body>
<section class="jumbotron">
    <h2 class="text-center"> {$gui->pageTitle|escape}</h2>
</section>

<div class="container">
    <h3 class="text-center">{$gui->mainDescription}</h3>
    <hr>
    {if $gui->tplans}
        <div class="row">
            <div class="col-lg-12">
            <a class="col-lg-5 btn btn-primary" href="javascript:openExecHistoryWindow({$gui->tcase_id});"
               title="{$labels.execution_history}" ><i class="fa fa-tasks"> </i> {$labels.execution_history}</a>
            <a class="col-lg-offset-2 col-lg-5 btn btn-info" href="javascript:openTCaseWindow({$gui->tcase_id});"
               title="{$labels.design}"><i class="fa fa-edit"> </i> {$labels.design}</a>
            </div>
        </div>
        <hr>
        <section class="jumbotron">
        <form method="post" action="{$basehref}lib/testcases/tcEdit.php?testcase_id={$gui->tcase_id}&tcversion_id={$gui->tcversion_id}">
            <h3>{$labels.testplan_usage}</h3>
                <hr>
            <div id='checkboxes'>
                <table id="item_view" class="table sortable">
                    <thead class="bg-primary">
                    <tr>
                        <th>&nbsp;</th><th>{$labels.version}</th><th>{$labels.test_plan}</th><th>{$labels.platform}</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach from=$gui->tplans item=link2tplan_platform}
                        {foreach from=$link2tplan_platform item=link2tplan key=platform_id}
                            <tr>
                                <td class="clickable_icon">
                                    <input type="checkbox" id="add2tplanid[{$link2tplan.id}][{$platform_id}]"
                                           name="add2tplanid[{$link2tplan.id}][{$platform_id}]"
                                            {if !$link2tplan.draw_checkbox} checked='checked' disabled='disabled' {/if} >
                                </td>
                                <td style="width:10%;text-align:center;">{$link2tplan.version}</td>
                                <td>{$link2tplan.name|escape}</td>
                                <td>{$link2tplan.platform|escape}</td>
                            </tr>
                        {/foreach}

                    {/foreach}
                    </tbody>
                </table>
            </div>

            {if $gui->can_do}
                <input type="hidden" id="doAction" name="doAction" value="doAdd2testplan" />
                <input class="btn btn-primary" type="submit" id="add2testplan"  name="add2testplan" value="{$labels.btn_add}"
                       onclick="return check_action_precondition('checkboxes','default');" />
            {/if}


            <input class="btn btn-secondary" type="button" name="cancel" value="{$labels.btn_cancel}" onclick={$gui->cancelActionJS};" />

        </form>
        </section>
    {else}
        {$labels.no_test_plans}
    {/if}
</div>