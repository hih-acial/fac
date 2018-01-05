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
        <ul class="sidebar-nav">
            {if $display_right_block_1}
                {$planView="lib/plan/planView.php"}
                {$buildView="lib/plan/buildView.php?tplan_id="}
                {$mileView="lib/plan/planMilestonesView.php"}
                {$reqOverView="lib/requirements/reqOverview.php"}
                {$reqMonOverView="lib/requirements/reqMonitorOverview.php?tproject_id="}
                <li>
                    <a data-toggle="collapse" data-parent="#accordion" href="#collapse"> Exigences</a>
                    <ul id="collapse" class="panel-collapse collapse">
                        {if $gui->grants.reqs_view == "yes"}
                            <li>
                                <a href="{$gui->launcher}?feature=reqSpecMgmt"  >{$labels.href_req_spec}</a>
                            </li>
                            <li>
                                <a href="{$reqOverView}"  >{$labels.href_req_overview}</a>
                            </li>
                            <li>
                                <a href="{$gui->launcher}?feature=searchReq"  >{$labels.href_search_req}</a>
                            </li>
                            <li>
                                <a href="{$gui->launcher}?feature=searchReqSpec" >{$labels.href_search_req_spec}</a>
                            </li>
                        {/if}
                        {if $gui->grants.reqs_edit == "yes"}
                            <li>
                                <a href="lib/general/frmWorkArea.php?feature=assignReqs"  style="{$aStyle}">{$labels.href_req_assign}</a>
                            </li>

                        {/if}
                        <li>
                            <a href="{$reqMonOverView}{$gui->testprojectID}" >{$labels.href_req_monitor_overview}</a>
                        </li>
                        <li>
                            <a href="{$gui->launcher}?feature=printReqSpec"  >{$labels.href_print_req}</a>
                        </li>
                    </ul>
                </li>

            {/if}
            {if $display_left_block_4 || $display_right_block_3}
                {$tcSearch="lib/testcases/tcSearch.php?doAction=userInput&tproject_id="}
                {$tcCreatedUser="lib/results/tcCreatedPerUserOnTestProject.php?do_action=uinput&tproject_id="}
                {$platformAssign="lib/platforms/platformsAssign.php?tplan_id="}
                <li>
                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" >Test</a>
                    <ul id="collapseTwo" class="panel-collapse collapse">

                        <li>
                            <a href="{$gui->launcher}?feature=editTc" >
                                {if $gui->grants.modify_tc eq "yes"}
                                    {lang_get s='href_edit_tc'}
                                {else}
                                    {lang_get s='href_browse_tc'}
                                {/if}
                            </a>
                        </li>
                        {if $gui->countPlans > 0}
                        <li>
                            <a href="{$gui->launcher}?feature=planAddTC" >{$labels.href_add_remove_test_cases}</a>
                        </li>
                        {/if}
                        <li>
                            <a href="{$gui->launcher}?feature=tc_exec_assignment"  >{$labels.href_tc_exec_assignment}</a>
                        </li>

                        <li>
                            <a href="{$tcSearch}{$gui->testprojectID}"  >{$labels.href_search_tc}</a>

                        </li>
                        <li>
                            <a href="{$gui->launcher}?feature=keywordsAssign"  >{$labels.href_keywords_assign}</a>

                        </li>
                        <li>
                            <a href="{$tcCreatedUser}{$gui->testprojectID}"  >{$labels.link_report_test_cases_created_per_user}</a>

                        </li>
                        {if $gui->grants.mgt_testplan_create == "yes"}
                            <li>
                                <a href="{$planView}" >{$labels.href_plan_management}</a>
                            </li>

                        {/if}
                        {if $gui->grants.testplan_create_build == "yes" and $gui->countPlans > 0}
                            <li>
                                <a href="{$buildView}{$gui->testplanID}" >{$labels.href_build_new}</a>

                            </li>
                        {/if}
                        {if $gui->grants.testplan_milestone_overview == "yes" and $gui->countPlans > 0}
                            <li>
                                <a href="{$mileView}" >{$labels.href_plan_mstones}</a>
                            </li>
                        {/if}
                    </ul>
                </li>
            {/if}
            <li>
                <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree" >Exécution</a>
                <ul id="collapseThree" class="panel-collapse collapse">
                    {if $gui->grants.testplan_execute == "yes" ||$gui->grants.exec_ro_access == "yes"}
                        {if $gui->grants.testplan_execute == "yes"}
                            {$lbx = $labels.href_execute_test}
                        {/if}
                        {if $gui->grants.exec_ro_access == "yes"}
                            {$lbx = $labels.href_exec_ro_access}
                        {/if}
                        <li>
                            <a href="{$gui->launcher}?feature=executeTest" >{$lbx}</a>
                        </li>
                    {/if}
                    <li>
                        <a href="{$gui->url.testcase_assignments}"  >{$labels.href_my_testcase_assignments}</a>
                    </li>
                    <li>
                        <a href="{$gui->launcher}?feature=showMetrics" >{$labels.href_rep_and_metrics}</a>
                    </li>
                    <li>
                        <a href="{$gui->url.metrics_dashboard}">{$labels.href_metrics_dashboard}</a>
                    </li>
                    {if $gui->grants.testplan_add_remove_platforms == "yes"}
                        <li>
                            <a href="{$platformAssign}{$gui->testplanID}"  >{$labels.href_platform_assign}</a>
                        </li>
                    {/if}
                    {if $gui->countPlans > 0}
                    {if $session['testprojectOptions']->testPriorityEnabled && $gui->grants.testplan_set_urgent_testcases == "yes"}
                        <li>
                            <a href="{$gui->launcher}?feature=test_urgency"  >{$labels.href_plan_assign_urgency}</a>
                        </li>
                    {/if}

                    {if $gui->grants.testplan_update_linked_testcase_versions == "yes"}
                        <li>
                            <a href="{$gui->launcher}?feature=planUpdateTC"  >{$labels.href_update_tplan}</a>
                        </li>
                    {/if}
                    {if $gui->grants.testplan_show_testcases_newest_versions == "yes"}
                        <li>
                            <a href="{$gui->launcher}?feature=newest_tcversions" >{$labels.href_newest_tcversions}</a>
                        </li>
                    {/if}
                    {/if}
                </ul>
            </li>
            {if $display_left_block_2 || $display_left_block_1}
                {$cfieldsView="lib/cfields/cfieldsView.php"}
                {$issueTrackerView="lib/issuetrackers/issueTrackerView.php"}
                <li style="margin-top: 150%;">
                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseFive" >Administration</a>
                    <ul id="collapseFive" class="panel-collapse collapse">
                        {if $gui->grants.tproject_user_role_assignment == "yes"}
                            <li>
                                <a href="{$usersAssign}{$gui->testprojectID}" >{$labels.href_assign_user_roles}</a>
                            </li>
                        {/if}

                        {if $gui->grants.cfield_management == "yes"}
                            <li>
                                <a href="{$cfAssignment}" >{$labels.href_cfields_tproject_assign}</a>
                            </li>
                        {/if}
                        {if $gui->grants.cfield_management == "yes"}
                            <li>
                                <a href="{$cfieldsView}" >{$labels.href_cfields_management}</a>
                            </li>
                        {/if}
                        {if $gui->grants.issuetracker_management || $gui->grants.issuetracker_view}
                            <li>
                                <a href="{$issueTrackerView}" >{$labels.href_issuetracker_management}</a>
                            </li>
                        {/if}
                        {if $gui->grants.project_edit == "yes"}
                            <li>
                                <a href="{$projectView}"  >{$labels.href_tproject_management}</a>
                            </li>
                        {/if}

                        {if $gui->grants.keywords_view == "yes"}

                            <li>
                                <a href="{$keywordsAssignment}{$gui->testprojectID}" >{$labels.href_keywords_manage}</a>
                            </li>
                        {/if}
                        {if $gui->grants.platform_management == "yes"}
                            <li>
                                <a href="{$platformsView}" >{$labels.href_platform_management}</a>
                            </li>
                        {/if}
                    </ul>
                </li>
            {/if}
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
                                <h4><label for="testplan">{$labels.current_test_plan}:</label></h4>
                                <select class="form-control" id="testplan" name="testplan" onchange="this.form.submit();">
                                    {section name=tPlan loop=$gui->arrPlans}
                                        <option value="{$gui->arrPlans[tPlan].id}"
                                                {if $gui->arrPlans[tPlan].selected} selected="selected" {/if}
                                                title="{$gui->arrPlans[tPlan].name|escape}">
                                            {$gui->arrPlans[tPlan].name|escape}
                                        </option>
                                    {/section}
                                </select>

                                {if $gui->countPlans == 1}
                                    <input class="btn btn-light" type="button" onclick="this.form.submit();" value="{$labels.ok}"/>
                                {/if}

                                {if $gui->testplanRole neq null}
                                    <br />{$labels.testplan_role} {$gui->testplanRole|escape}
                                {/if}
                            {else}
                                {if $gui->num_active_tplans > 0}{$labels.msg_no_rights_for_tp}{/if}
                            {/if}
                        </form>
                    {/if}

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
</body>
</html>