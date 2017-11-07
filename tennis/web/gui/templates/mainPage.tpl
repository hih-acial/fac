{* 
 Testlink Open Source Project - http://testlink.sourceforge.net/ 
 @filesource  mainPage.tpl 
 Purpose: smarty template - main page / site map                 
*}
<html>
{lang_get var='labels' s='title_product_mgmt,href_tproject_management,href_admin_modules,
                          href_assign_user_roles,href_cfields_management,system_config,
                          href_cfields_tproject_assign,href_keywords_manage,
                          title_user_mgmt,href_user_management,
                          href_roles_management,title_requirements,
                          href_req_spec,href_req_assign,link_report_test_cases_created_per_user,
                          title_test_spec,href_edit_tc,href_browse_tc,href_search_tc,
                          href_search_req, href_search_req_spec,href_inventory,
                          href_platform_management, href_inventory_management,
                          href_print_tc,href_keywords_assign, href_req_overview,
                          href_print_req,title_plugins,title_documentation,href_issuetracker_management,
                          href_reqmgrsystem_management,href_req_monitor_overview,
            current_test_plan,ok,testplan_role,msg_no_rights_for_tp,
             title_test_execution,href_execute_test,href_rep_and_metrics,
             href_update_tplan,href_newest_tcversions,title_plugins,
             href_my_testcase_assignments,href_platform_assign,
             href_tc_exec_assignment,href_plan_assign_urgency,
             href_upd_mod_tc,title_test_plan_mgmt,title_test_case_suite,
             href_plan_management,href_assign_user_roles,
             href_build_new,href_plan_mstones,href_plan_define_priority,
             href_metrics_dashboard,href_add_remove_test_cases,
             href_exec_ro_access'}
{$projectView="lib/project/projectView.php"}
{$usersAssign="lib/usermanagement/usersAssign.php?featureType=testproject&featureID="}
{$cfAssignment="lib/cfields/cfieldsTprojectAssign.php"}
{$keywordsAssignment="lib/keywords/keywordsView.php?tproject_id="}
{$platformsView="lib/platforms/platformsView.php"}
{$cfg_section=$smarty.template|replace:".tpl":""}
{$display_left_block_1=false}
{$display_left_block_2=false}
{$display_left_block_3=false}
{$display_left_block_4=false}
{$display_left_block_5=$tlCfg->userDocOnDesktop}
{$display_left_block_top = false}
{$display_left_block_bottom = false}

{if $gui->testprojectID &&
($gui->grants.project_edit == "yes" ||
$gui->grants.tproject_user_role_assignment == "yes" ||
$gui->grants.cfield_management == "yes" ||
$gui->grants.platform_management == "yes" ||
$gui->grants.keywords_view == "yes")}

    {$display_left_block_1=true}
{/if}

{if $gui->testprojectID &&
($gui->grants.cfield_management == "yes" || $gui->grants.issuetracker_management || $gui->grants.issuetracker_view)}
    {$display_left_block_2=true}
{/if}

{if $gui->testprojectID && $gui->opt_requirements == TRUE &&
($gui->grants.reqs_view == "yes" || $gui->grants.reqs_edit == "yes")}
    {$display_left_block_3=true}
{/if}

{if $gui->testprojectID && $gui->grants.view_tc == "yes"}
    {$display_left_block_4=true}
{/if}

{if isset($gui->plugins.EVENT_LEFTMENU_TOP) &&  $gui->plugins.EVENT_LEFTMENU_TOP}
    {$display_left_block_top=true}
{/if}
{if isset($gui->plugins.EVENT_LEFTMENU_BOTTOM) &&  $gui->plugins.EVENT_LEFTMENU_BOTTOM}
    {$display_left_block_bottom=true}
{/if}

{$menuLayout=$tlCfg->gui->layoutMainPageRight}
{$display_right_block_1=false}
{$display_right_block_2=false}
{$display_right_block_3=false}
{$display_left_block_top = false}
{$display_left_block_bottom = false}

{if $gui->grants.testplan_planning == "yes" || $gui->grants.mgt_testplan_create == "yes" ||
$gui->grants.testplan_user_role_assignment == "yes" or $gui->grants.testplan_create_build == "yes"}
    {$display_right_block_1=true}
{/if}

{if $gui->countPlans > 0 &&
($gui->grants.testplan_execute == "yes" ||
$gui->grants.testplan_metrics == "yes" ||
$gui->grants.exec_ro_access == "yes")}
    {$display_right_block_2=true}
{/if}

{if $gui->countPlans > 0 && $gui->grants.testplan_planning == "yes"}
    {$display_right_block_3=true}
{/if}

{$display_right_block_top=false}
{$display_right_block_bottom=false}

{if isset($gui->plugins.EVENT_RIGHTMENU_TOP) &&  $gui->plugins.EVENT_RIGHTMENU_TOP}
    {$display_right_block_top=true}
{/if}
{if isset($gui->plugins.EVENT_RIGHTMENU_BOTTOM) &&  $gui->plugins.EVENT_RIGHTMENU_BOTTOM}
    {$display_right_block_bottom=true}
{/if}
{config_load file="input_dimensions.conf" section=$cfg_section}
{include file="inc_head.tpl" popup="yes" openHead="yes"}

{include file="inc_ext_js.tpl"}
{include file="custom.tpl"}

<head>
<script language="JavaScript" src="{$basehref}gui/niftycube/niftycube.js" type="text/javascript"></script>
</head>
<body>

<div id="wrapper" class="toggled">

    <!-- Sidebar -->
    <div id="sidebar-wrapper">
        <ul class="sidebar-nav" >
            <li class="sidebar-brand">
                <a href="index.php" target="_parent">
                    TESTLINK V.3.0
                </a>
            </li>
            <li>
                <a href="#" style="font-size: large">Espace campagne</a>
            </li>
            <li>
                 <a href="#" style="font-size: large">Espace test</a>
            </li>
            <li>
                <a href="#" style="font-size: large">Espace exécution</a>
            </li>
        </ul>
    </div>
    <!-- /#sidebar-wrapper -->
    <a href="#menu-toggle" class="btn btn-dark" id="menu-toggle"><i class="glyphicon glyphicon-list"></i>Menu</a>


    <!-- Page Content -->
    <div id="page-content-wrapper">
        <div class="container-fluid">


            <div class="row" style="padding-left: 5px;">
                <div class="col-sm-3 col-md-3">
                    {if $gui->num_active_tplans > 0}
                        <form name="testplanForm" action="lib/general/mainPage.php">
                            {if $gui->countPlans > 0}
                                <h4>{$labels.current_test_plan}:</h4>
                                <select class="form-control" name="testplan" onchange="this.form.submit();">
                                    {section name=tPlan loop=$gui->arrPlans}
                                        <option value="{$gui->arrPlans[tPlan].id}"
                                                {if $gui->arrPlans[tPlan].selected} selected="selected" {/if}
                                                title="{$gui->arrPlans[tPlan].name|escape}">
                                            {$gui->arrPlans[tPlan].name|escape}
                                        </option>
                                    {/section}
                                </select>

                                {if $gui->countPlans == 1}
                                    <input type="button" onclick="this.form.submit();" value="{$labels.ok}"/>
                                {/if}

                                {if $gui->testplanRole neq null}
                                    <br />{$labels.testplan_role} {$gui->testplanRole|escape}
                                {/if}
                            {else}
                                {if $gui->num_active_tplans > 0}{$labels.msg_no_rights_for_tp}{/if}
                            {/if}
                        </form>
                    {/if}
                    <div class="panel-group" id="accordion">

                        {if $display_right_block_1}
                            {$planView="lib/plan/planView.php"}
                            {$buildView="lib/plan/buildView.php?tplan_id="}
                            {$mileView="lib/plan/planMilestonesView.php"}
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne"><span class="glyphicon glyphicon-folder-close">
                            </span>Campagne de test</a>
                                    </h4>
                                </div>
                                <div id="collapseOne" class="panel-collapse collapse in">
                                    <div class="panel-body">
                                        <table class="table">
                                            <tr>
                                                <td>
                                                    <span class="glyphicon glyphicon-pencil text-primary"></span>
                                                    {if $gui->grants.mgt_testplan_create == "yes"}
                                                        <a href="{$planView}" >{$labels.href_plan_management}</a>
                                                    {/if}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="glyphicon glyphicon-flash text-success"></span> {if $gui->grants.testplan_create_build == "yes" and $gui->countPlans > 0}
                                                        <a href="{$buildView}{$gui->testplanID}" >{$labels.href_build_new}</a>
                                                    {/if}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="glyphicon glyphicon-file text-info"></span>
                                                    {if $gui->grants.testplan_milestone_overview == "yes" and $gui->countPlans > 0}
                                                        <a href="{$mileView}" >{$labels.href_plan_mstones}</a>
                                                    {/if}
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        {/if}

                        {$reqOverView="lib/requirements/reqOverview.php"}
                        {$reqMonOverView="lib/requirements/reqMonitorOverview.php?tproject_id="}
                        <div class="panel panel-marine">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseSeven"><span class="glyphicon glyphicon-user">
                            </span>Dossier d'exigences</a>
                                </h4>
                            </div>
                            <div id="collapseSeven" class="panel-collapse collapse">
                                <div class="panel-body">

                                    <table class="table">
                                        {if $gui->grants.reqs_view == "yes"}
                                            <tr>
                                                <td>
                                                    <a href="{$gui->launcher}?feature=reqSpecMgmt"  >{$labels.href_req_spec}</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="{$reqOverView}"  >{$labels.href_req_overview}</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="{$gui->launcher}?feature=searchReq"  >{$labels.href_search_req}</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="{$gui->launcher}?feature=searchReqSpec" >{$labels.href_search_req_spec}</a>
                                                </td>
                                            </tr>
                                        {/if}
                                        {if $gui->grants.reqs_edit == "yes"}
                                            <tr>
                                                <td>
                                                    <a href="lib/general/frmWorkArea.php?feature=assignReqs"  style="{$aStyle}">{$labels.href_req_assign}</a>
                                                </td>
                                            </tr>
                                        {/if}
                                        <tr>
                                            <td>
                                                <a href="{$reqMonOverView}{$gui->testprojectID}" >{$labels.href_req_monitor_overview}</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span class="glyphicon glyphicon-trash text-danger"></span>
                                                <a href="{$gui->launcher}?feature=printReqSpec"  >{$labels.href_print_req}</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>

                        {if $display_left_block_4}
                            {$tcSearch="lib/testcases/tcSearch.php?doAction=userInput&tproject_id="}
                            {$tcCreatedUser="lib/results/tcCreatedPerUserOnTestProject.php?do_action=uinput&tproject_id="}
                            <div class="panel panel-purple">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo"><span class="glyphicon glyphicon-th">
                            </span>Fiches de test</a>
                                    </h4>
                                </div>
                                <div id="collapseTwo" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <table class="table">
                                            <tr>
                                                <td>
                                                    <a href="{$gui->launcher}?feature=editTc" >
                                                        {if $gui->grants.modify_tc eq "yes"}
                                                            {lang_get s='href_edit_tc'}
                                                        {else}
                                                            {lang_get s='href_browse_tc'}
                                                        {/if}
                                                    </a>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <a href="{$tcSearch}{$gui->testprojectID}"  >{$labels.href_search_tc}</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="{$gui->launcher}?feature=keywordsAssign"  >{$labels.href_keywords_assign}</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="{$tcCreatedUser}{$gui->testprojectID}"  >{$labels.link_report_test_cases_created_per_user}</a>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        {/if}

                        {if $display_right_block_3}
                            {$platformAssign="lib/platforms/platformsAssign.php?tplan_id="}
                            <div class="panel panel-danger">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFour"><span class="glyphicon glyphicon-file">
                            </span>Assignation des fiches de test</a>
                                    </h4>
                                </div>
                                <div id="collapseFour" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <table class="table">
                                            <tr>
                                                <td>
                                                    <span class="glyphicon glyphicon-usd"></span>
                                                    {if $gui->grants.testplan_add_remove_platforms == "yes"}
                                                        <a href="{$platformAssign}{$gui->testplanID}"  >{$labels.href_platform_assign}</a>
                                                    {/if}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="glyphicon glyphicon-user"></span>
                                                    <a href="{$gui->launcher}?feature=planAddTC" >{$labels.href_add_remove_test_cases}</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="glyphicon glyphicon-tasks"></span>
                                                    <a href="{$gui->launcher}?feature=tc_exec_assignment"  >{$labels.href_tc_exec_assignment}</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="glyphicon glyphicon-shopping-cart"></span>
                                                    {if $session['testprojectOptions']->testPriorityEnabled &&
                                                    $gui->grants.testplan_set_urgent_testcases == "yes"}
                                                        <a href="{$gui->launcher}?feature=test_urgency"  >{$labels.href_plan_assign_urgency}</a>
                                                    {/if}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="glyphicon glyphicon-shopping-cart"></span>
                                                    {if $gui->grants.testplan_update_linked_testcase_versions == "yes"}
                                                        <a href="{$gui->launcher}?feature=planUpdateTC"  >{$labels.href_update_tplan}</a>
                                                    {/if}

                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="glyphicon glyphicon-shopping-cart"></span>
                                                    {if $gui->grants.testplan_show_testcases_newest_versions == "yes"}
                                                        <a href="{$gui->launcher}?feature=newest_tcversions" >{$labels.href_newest_tcversions}</a>
                                                    {/if}
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        {/if}

                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree"><span class="glyphicon glyphicon-user">
                            </span>Exécution des fiches de test</a>
                                </h4>
                            </div>
                            <div id="collapseThree" class="panel-collapse collapse">
                                <div class="panel-body">

                                    <table class="table">
                                        {if $gui->grants.testplan_execute == "yes" ||
                                        $gui->grants.exec_ro_access == "yes"}
                                            {if $gui->grants.testplan_execute == "yes"}
                                                {$lbx = $labels.href_execute_test}
                                            {/if}

                                            {if $gui->grants.exec_ro_access == "yes"}
                                                {$lbx = $labels.href_exec_ro_access}
                                            {/if}
                                            <tr>
                                                <td>
                                                    <a href="{$gui->launcher}?feature=executeTest" >{$lbx}</a>
                                                </td>
                                            </tr>
                                        {/if}
                                        <tr>
                                            <td>
                                                <a href="{$gui->url.testcase_assignments}"  >{$labels.href_my_testcase_assignments}</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="{$gui->launcher}?feature=showMetrics" >{$labels.href_rep_and_metrics}</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span class="glyphicon glyphicon-trash text-danger"></span><a href="{$gui->url.metrics_dashboard}">{$labels.href_metrics_dashboard}</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>

                        {if $display_left_block_2}
                            {$cfieldsView="lib/cfields/cfieldsView.php"}
                            {$issueTrackerView="lib/issuetrackers/issueTrackerView.php"}
                            <div class="panel panel-success">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFive"><span class="glyphicon glyphicon-user">
                            </span>Système</a>
                                    </h4>
                                </div>
                                <div id="collapseFive" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <table class="table">
                                            <tr>
                                                <td>
                                                    {if $gui->grants.cfield_management == "yes"}
                                                        <a href="{$cfieldsView}" >{$labels.href_cfields_management}</a>
                                                    {/if}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    {if $gui->grants.issuetracker_management || $gui->grants.issuetracker_view}
                                                        <a href="{$issueTrackerView}" >{$labels.href_issuetracker_management}</a>
                                                    {/if}
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        {/if}

                        {if $display_left_block_1}
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseSix"><span class="glyphicon glyphicon-user">
                            </span>Gestion du projet de test</a>
                                    </h4>
                                </div>
                                <div id="collapseSix" class="panel-collapse collapse">
                                    <div class="panel-body">

                                        <table class="table">
                                            <tr>
                                                <td>
                                                    {if $gui->grants.project_edit == "yes"}
                                                        <a href="{$projectView}"  >
                                                            {$labels.href_tproject_management}</a>
                                                    {/if}
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    {if $gui->grants.tproject_user_role_assignment == "yes"}
                                                        <a href="{$usersAssign}{$gui->testprojectID}" >{$labels.href_assign_user_roles}</a>
                                                    {/if}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    {if $gui->grants.cfield_management == "yes"}
                                                        <a href="{$cfAssignment}" >{$labels.href_cfields_tproject_assign}</a>
                                                    {/if}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="glyphicon glyphicon-trash text-danger"></span>
                                                    {if $gui->grants.keywords_view == "yes"}
                                                        <a href="{$keywordsAssignment}{$gui->testprojectID}" >{$labels.href_keywords_manage}</a>
                                                    {/if}

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="glyphicon glyphicon-trash text-danger"></span>
                                                    {if $gui->grants.platform_management == "yes"}
                                                        <a href="{$platformsView}" >{$labels.href_platform_management}</a>
                                                    {/if}

                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        {/if}
                    </div>
                </div>
                <div class="col-sm-9 col-md-9">
                    <div class="jumbotron">
                        <section class="row" style="margin: 25%;">
                            <div class="text-center">
                                <h1>TESTLINK V 3.0</h1>
                            </div>
                            <div class="col-lg-12 col-md-12 col-xs-12">

                                <div class="col-lg-12">
                                    <div class="col-lg-4 col-md-6 col-xs-12">
                                        {if $display_right_block_top}
                                            <script type="text/javascript">
                                                function display_right_block_top()
                                                {
                                                    var pt = new Ext.Panel({
                                                        title: '{$labels.title_plugins}',
                                                        collapsible: false,
                                                        collapsed: false,
                                                        draggable: false,
                                                        contentEl: 'plugin_right_top',
                                                        baseCls: 'x-tl-panel',
                                                        bodyStyle: "background:#c8dce8;padding:3px;",
                                                        renderTo: 'menu_right_block_top',
                                                        width: '100%'
                                                    });
                                                }
                                            </script>
                                        {if isset($gui->plugins.EVENT_RIGHTMENU_TOP)}
                                            <div id="plugin_right_top">
                                                {foreach from=$gui->plugins.EVENT_RIGHTMENU_TOP item=menu_item}
                                                    {$menu_item}
                                                    <br/>
                                                {/foreach}
                                            </div>
                                        {/if}
                                        {/if}
                                    </div>
                                    <div class="col-lg-4 col-md-6 col-xs-12">
                                        {if $display_right_block_bottom}
                                            <script type="text/javascript">
                                                function display_right_block_bottom()
                                                {
                                                    var pb = new Ext.Panel({
                                                        title: '{$labels.title_plugins}',
                                                        collapsible: false,
                                                        collapsed: false,
                                                        draggable: false,
                                                        contentEl: 'plugin_right_bottom',
                                                        baseCls: 'x-tl-panel',
                                                        bodyStyle: "background:#c8dce8;padding:3px;",
                                                        renderTo: 'menu_right_block_bottom',
                                                        width: '100%'
                                                    });
                                                }
                                            </script>
                                        {if isset($gui->plugins.EVENT_RIGHTMENU_BOTTOM)}
                                            <div id="plugin_right_bottom">
                                                {foreach from=$gui->plugins.EVENT_RIGHTMENU_BOTTOM item=menu_item}
                                                    {$menu_item}
                                                    <br/>
                                                {/foreach}
                                            </div>
                                        {/if}
                                        {/if}
                                    </div>
                                </div>
                            </div>

                        </section>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /#page-content-wrapper -->

</div>

<!-- Menu Toggle Script -->
<script>
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
</script>


    <script>
    jQuery( document ).ready(function() {
        jQuery(".chosen-select").chosen({ width: "85%" });
    });
</script>
</body>
</html>