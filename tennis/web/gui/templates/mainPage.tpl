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
{include file="bootstrap.inc.tpl"}
<head>
<script language="JavaScript" src="{$basehref}gui/niftycube/niftycube.js" type="text/javascript"></script>
<script type="text/javascript">
window.onload=function() 
{

  /* with typeof display_left_block_1 I'm checking is function exists */
  if(typeof display_left_block_top != 'undefined') 
  {
    display_left_block_top();
  }

  if(typeof display_left_block_1 != 'undefined') 
  {
    display_left_block_1();
  }

  if(typeof display_left_block_2 != 'undefined') 
  {
    display_left_block_2();
  }

  if(typeof display_left_block_3 != 'undefined') 
  {
    display_left_block_3();
  }

  if(typeof display_left_block_4 != 'undefined') 
  {
    display_left_block_4();
  }

  if(typeof display_left_block_bottom != 'undefined') 
  {
    display_left_block_bottom();
  }

  if(typeof display_left_block_5 != 'undefined')
  {
    display_left_block_5();
  }

  if( typeof display_right_block_1 != 'undefined')
  {
    display_right_block_1();
  }

  if( typeof display_right_block_2 != 'undefined')
  {
    display_right_block_2();
  }

  if( typeof display_right_block_3 != 'undefined')
  {
    display_right_block_3();
  }

  if( typeof display_right_block_top != 'undefined')
  {
    display_right_block_top();
  }

  if( typeof display_right_block_bottom != 'undefined')
  {
    display_right_block_bottom();
  }
}
</script>
</head>

<body>

      <header class="text-center">
          <h1>TEST LINK</h1>
      </header>
      <section class="row jumbotron">

      <div class="col-lg-12 col-md-12 col-xs-12">
          <div class="col-lg-4 col-md-6 col-xs-12">
              {if $display_left_block_2}
                  {$cfieldsView="lib/cfields/cfieldsView.php"}
                  {$issueTrackerView="lib/issuetrackers/issueTrackerView.php"}
                  <div class="panel panel-primary">
                      <div class="panel-heading" role="tab" id="heading1">
                          <div class="row parent">
                              <div class="col-xs-10 col-sm-10 col-md-10 col-lg-10 ">
                                  <h3> SYSTEM </h3>
                              </div>
                              <div class="col-lg-offset-1 col-xs-2 col-sm-1 col-md-1 col-lg-1 child">
                                  <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse1" aria-expanded="true" aria-controls="collapse1">
                                      <span class="glyphicon glyphicon-chevron-down" style="color:white; padding-top: 25px;" aria-hidden="true"></span>
                                  </a>
                              </div>
                          </div>
                      </div>
                      <div id="collapse1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading1">
                          <div class="panel-body">
                              <div class="list-group">
                                  {if $gui->grants.cfield_management == "yes"}
                                      <a href="{$cfieldsView}" class="list-group-item">{$labels.href_cfields_management}</a>
                                  {/if}

                                  {if $gui->grants.issuetracker_management || $gui->grants.issuetracker_view}
                                      <a href="{$issueTrackerView}" class="list-group-item" >{$labels.href_issuetracker_management}</a>
                                  {/if}
                              </div>
                          </div>
                      </div>
                  </div>

              {/if}
          </div>
          <div class="col-lg-4 col-md-6 col-xs-12">
              {if $display_left_block_1}
                  <div class="panel panel-success">
                      <div class="panel-heading" role="tab" id="heading2">
                          <div class="row parent">
                              <div class="col-xs-10 col-sm-10 col-md-10 col-lg-10 ">
                                  <h3> TEST PROJECT MANAGEMENT </h3>
                              </div>
                              <div class="col-lg-offset-1 col-xs-2 col-sm-1 col-md-1 col-lg-1 child">
                                  <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse2" aria-expanded="true" aria-controls="collapse2">
                                      <span class="glyphicon glyphicon-chevron-down" style="color:white; padding-top: 25px;" aria-hidden="true"></span>
                                  </a>
                              </div>
                          </div>
                      </div>
                      <div id="collapse2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading2">
                          <div class="panel-body">
                              <div class="list-group">
                                  {if $gui->grants.project_edit == "yes"}
                                      <a href="{$projectView}" class="list-group-item" >
                                          {$labels.href_tproject_management}</a>
                                  {/if}

                                  {if $gui->grants.tproject_user_role_assignment == "yes"}
                                      <a href="{$usersAssign}{$gui->testprojectID}" class="list-group-item" >{$labels.href_assign_user_roles}</a>
                                  {/if}

                                  {if $gui->grants.cfield_management == "yes"}
                                      <a href="{$cfAssignment}" class="list-group-item">{$labels.href_cfields_tproject_assign}</a>
                                  {/if}

                                  {if $gui->grants.keywords_view == "yes"}
                                      <a href="{$keywordsAssignment}{$gui->testprojectID}" class="list-group-item">{$labels.href_keywords_manage}</a>
                                  {/if}

                                  {if $gui->grants.platform_management == "yes"}
                                      <a href="{$platformsView}" class="list-group-item" >{$labels.href_platform_management}</a>
                                  {/if}
                              </div>
                          </div>
                      </div>
                  </div>

              {/if}
          </div>
          <div class="col-lg-4 col-md-6 col-xs-12">
              {if $display_left_block_3}
                  {$reqOverView="lib/requirements/reqOverview.php"}
                  {$reqMonOverView="lib/requirements/reqMonitorOverview.php?tproject_id="}

                  <div class="panel panel-info">
                      <div class="panel-heading" role="tab" id="heading3">
                          <div class="row parent">
                              <div class="col-xs-10 col-sm-10 col-md-10 col-lg-10 ">
                                  <h3> TEST PROJECT </h3>
                              </div>
                              <div class="col-lg-offset-1 col-xs-2 col-sm-1 col-md-1 col-lg-1 child">
                                  <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse3" aria-expanded="true" aria-controls="collapse3">
                                      <span class="glyphicon glyphicon-chevron-down" style="color:white; padding-top: 25px;" aria-hidden="true"></span>
                                  </a>
                              </div>
                          </div>
                      </div>
                      <div id="collapse3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading3">
                          <div class="panel-body">
                              <div class="list-group">
                                  {if $gui->grants.reqs_view == "yes"}
                                      <a href="{$gui->launcher}?feature=reqSpecMgmt" class="list-group-item" >{$labels.href_req_spec}</a>
                                      <a href="{$reqOverView}" class="list-group-item" >{$labels.href_req_overview}</a>
                                      <a href="{$gui->launcher}?feature=searchReq" class="list-group-item" >{$labels.href_search_req}</a>
                                      <a href="{$gui->launcher}?feature=searchReqSpec" class="list-group-item" >{$labels.href_search_req_spec}</a>
                                  {/if}

                                  {if $gui->grants.reqs_edit == "yes"}
                                      <a href="lib/general/frmWorkArea.php?feature=assignReqs" class="list-group-item" style="{$aStyle}">{$labels.href_req_assign}</a>
                                      <a href="{$reqMonOverView}{$gui->testprojectID}" class="list-group-item" >{$labels.href_req_monitor_overview}</a>
                                      <a href="{$gui->launcher}?feature=printReqSpec" class="list-group-item" >{$labels.href_print_req}</a>
                                  {/if}
                              </div>
                          </div>
                      </div>
                  </div>


              {/if}
          </div>
          <div class="col-lg-4 col-md-6 col-xs-12">
              {if $display_left_block_4}
                  {$tcSearch="lib/testcases/tcSearch.php?doAction=userInput&tproject_id="}
                  {$tcCreatedUser="lib/results/tcCreatedPerUserOnTestProject.php?do_action=uinput&tproject_id="}
                  <div class="panel panel-danger">
                      <div class="panel-heading" role="tab" id="heading4">
                          <div class="row parent">
                              <div class="col-xs-10 col-sm-10 col-md-10 col-lg-10 ">
                                  <h3> TEST PROJECT SPECIFICATIONS </h3>
                              </div>
                              <div class="col-lg-offset-1 col-xs-2 col-sm-1 col-md-1 col-lg-1 child">
                                  <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse4" aria-expanded="true" aria-controls="collapse4">
                                      <span class="glyphicon glyphicon-chevron-down" style="color:white; padding-top: 25px;" aria-hidden="true"></span>
                                  </a>
                              </div>
                          </div>
                      </div>
                      <div id="collapse4" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading4">
                          <div class="panel-body">
                              <div class="list-group" >
                                  <a href="{$gui->launcher}?feature=editTc" class="list-group-item" >
                                      {if $gui->grants.modify_tc eq "yes"}
                                          {lang_get s='href_edit_tc'}
                                      {else}
                                          {lang_get s='href_browse_tc'}
                                      {/if}
                                  </a>
                                  {if $gui->hasTestCases}
                                      <a href="{$tcSearch}{$gui->testprojectID}" class="list-group-item" >{$labels.href_search_tc}</a>
                                  {/if}

                                  {if $gui->hasKeywords}
                                      {if $gui->grants.keywords_view == "yes" &&
                                      $gui->grants.keywords_edit == "yes"}
                                          <a href="{$gui->launcher}?feature=keywordsAssign" class="list-group-item" >{$labels.href_keywords_assign}</a>
                                      {/if}
                                  {/if}

                                  {if $gui->grants.modify_tc eq "yes"}
                                      <a href="{$tcCreatedUser}{$gui->testprojectID}" class="list-group-item" >{$labels.link_report_test_cases_created_per_user}</a>
                                  {/if}

                              </div>
                          </div>
                      </div>
                  </div>

              {/if}
          </div>

          <div class="vertical_menu" >
              <div class="col-lg-12 col-xs-12 col-md-12 col-sm-12">
                  {if $gui->num_active_tplans > 0}
                  <div class="panel panel-info">
                      <div class="panel-heading" role="tab" id="heading5">
                          <div class="row parent">
                              <div class="col-xs-10 col-sm-10 col-md-10 col-lg-10 ">
                                  <h3> SEARCH BAR </h3>
                              </div>
                              <div class="col-lg-offset-1 col-xs-2 col-sm-1 col-md-1 col-lg-1 child">
                                  <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse5" aria-expanded="true" aria-controls="collapse5">
                                      <span class="glyphicon glyphicon-chevron-down" style="color:white; padding-top: 25px;" aria-hidden="true"></span>
                                  </a>
                              </div>
                          </div>
                      </div>
                      <div id="collapse5" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading5">
                          <div class="panel-body">

                                  <div class="" style="padding: 3px 15px;">
                                      {lang_get s='help' var='common_prefix'}
                                      {lang_get s='test_plan' var="xx_alt"}
                                      {$text_hint="$common_prefix: $xx_alt"}
                                      {include file="inc_help.tpl" helptopic="hlp_testPlan" show_help_icon=true
                                      inc_help_alt="$text_hint" inc_help_title="$text_hint"
                                      inc_help_style="float: right;vertical-align: top;"}

                                      <form name="testplanForm" action="lib/general/mainPage.php">
                                          {if $gui->countPlans > 0}
                                              {$labels.current_test_plan}:<br/>
                                              <select class="chosen-select" name="testplan" onchange="this.form.submit();">
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
                                  </div>

                          </div>
                      </div>
                  </div>
                  {/if}
              </div>

                <div class="row">
                    <div class="col-lg-12">
              <div class="col-lg-4 col-md-6 col-xs-12">
                  {if $display_right_block_1}
                      {$planView="lib/plan/planView.php"}
                      {$buildView="lib/plan/buildView.php?tplan_id="}
                      {$mileView="lib/plan/planMilestonesView.php"}
                      <div class="panel panel-purple">
                          <div class="panel-heading" role="tab" id="heading6">
                              <div class="row parent">
                                  <div class="col-xs-10 col-sm-10 col-md-10 col-lg-10 ">
                                      <h3> TEST PLAN MANAGEMENT </h3>
                                  </div>
                                  <div class="col-lg-offset-1 col-xs-2 col-sm-1 col-md-1 col-lg-1 child">
                                      <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse6" aria-expanded="true" aria-controls="collapse6">
                                          <span class="glyphicon glyphicon-chevron-down" style="color:white; padding-top: 25px;" aria-hidden="true"></span>
                                      </a>
                                  </div>
                              </div>
                          </div>
                          <div id="collapse6" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading6">
                              <div class="panel-body">
                                  <div class="list-group">
                                      {if $gui->grants.mgt_testplan_create == "yes"}
                                          <a href="{$planView}" class="list-group-item" >{$labels.href_plan_management}</a>
                                      {/if}

                                      {if $gui->grants.testplan_create_build == "yes" and $gui->countPlans > 0}
                                          <a href="{$buildView}{$gui->testplanID}" class="list-group-item" >{$labels.href_build_new}</a>
                                      {/if}

                                      {if $gui->grants.testplan_milestone_overview == "yes" and $gui->countPlans > 0}
                                          <a href="{$mileView}" class="list-group-item" >{$labels.href_plan_mstones}</a>
                                      {/if}
                                  </div>
                              </div>
                          </div>
                      </div>

                  {/if}
              </div>
              <div class="col-lg-4 col-md-6 col-xs-12">
                  {if $display_right_block_2}
                      <div class="panel panel-marine">
                          <div class="panel-heading" role="tab" id="heading7">
                              <div class="row parent">
                                  <div class="col-xs-10 col-sm-10 col-md-10 col-lg-10 ">
                                      <h3> TEST EXECUTION </h3>
                                  </div>
                                  <div class="col-lg-offset-1 col-xs-2 col-sm-1 col-md-1 col-lg-1 child">
                                      <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse7" aria-expanded="true" aria-controls="collapse7">
                                          <span class="glyphicon glyphicon-chevron-down" style="color:white; padding-top: 25px;" aria-hidden="true"></span>
                                      </a>
                                  </div>
                              </div>
                          </div>
                          <div id="collapse7" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading7">
                              <div class="panel-body">
                                  <div class="list-group" >
                                      {if $gui->grants.testplan_execute == "yes" ||
                                      $gui->grants.exec_ro_access == "yes"}

                                          {if $gui->grants.testplan_execute == "yes"}
                                              {$lbx = $labels.href_execute_test}
                                          {/if}

                                          {if $gui->grants.exec_ro_access == "yes"}
                                              {$lbx = $labels.href_exec_ro_access}
                                          {/if}

                                          <a href="{$gui->launcher}?feature=executeTest" class="list-group-item" >{$lbx}</a>

                                          {if $gui->grants.exec_testcases_assigned_to_me == "yes"}
                                              <a href="{$gui->url.testcase_assignments}" class="list-group-item" >{$labels.href_my_testcase_assignments}</a>
                                          {/if}
                                      {/if}

                                      {if $gui->grants.testplan_metrics == "yes"}
                                          <a href="{$gui->launcher}?feature=showMetrics" class="list-group-item" >{$labels.href_rep_and_metrics}</a>
                                          <a href="{$gui->url.metrics_dashboard}" class="list-group-item" >{$labels.href_metrics_dashboard}</a>
                                      {/if}
                                  </div>
                              </div>
                          </div>
                      </div>

                  {/if}
              </div>
              <div class="col-lg-4 col-md-6 col-xs-12">
                  {if $display_right_block_3}
                      {$platformAssign="lib/platforms/platformsAssign.php?tplan_id="}
                      <div class="panel panel-warning">
                          <div class="panel-heading" role="tab" id="heading8">
                              <div class="row parent">
                                  <div class="col-xs-10 col-sm-10 col-md-10 col-lg-10 ">
                                      <h3> TEST CASES MANAGEMENT </h3>
                                  </div>
                                  <div class="col-lg-offset-1 col-xs-2 col-sm-1 col-md-1 col-lg-1 child">
                                      <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse8" aria-expanded="true" aria-controls="collapse8">
                                          <span class="glyphicon glyphicon-chevron-down" style="color:white; padding-top: 25px;" aria-hidden="true"></span>
                                      </a>
                                  </div>
                              </div>
                          </div>
                          <div id="collapse8" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading8">
                              <div class="panel-body">
                                  <div class="list-group" >
                                      {if $gui->grants.testplan_add_remove_platforms == "yes"}
                                          <a href="{$platformAssign}{$gui->testplanID}" class="list-group-item" >{$labels.href_platform_assign}</a>
                                      {/if}

                                      <a href="{$gui->launcher}?feature=planAddTC" class="list-group-item" >{$labels.href_add_remove_test_cases}</a>

                                      <a href="{$gui->launcher}?feature=tc_exec_assignment" class="list-group-item" >{$labels.href_tc_exec_assignment}</a>

                                      {if $session['testprojectOptions']->testPriorityEnabled &&
                                      $gui->grants.testplan_set_urgent_testcases == "yes"}
                                          <a href="{$gui->launcher}?feature=test_urgency" class="list-group-item" >{$labels.href_plan_assign_urgency}</a>
                                      {/if}

                                      {if $gui->grants.testplan_update_linked_testcase_versions == "yes"}
                                          <a href="{$gui->launcher}?feature=planUpdateTC" class="list-group-item" >{$labels.href_update_tplan}</a>
                                      {/if}

                                      {if $gui->grants.testplan_show_testcases_newest_versions == "yes"}
                                          <a href="{$gui->launcher}?feature=newest_tcversions" class="list-group-item" >{$labels.href_newest_tcversions}</a>
                                      {/if}

                                  </div>
                              </div>
                          </div>
                      </div>

                  {/if}
              </div>
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
          </div>
      </div>

      </section>

<script>
    jQuery( document ).ready(function() {
        jQuery(".chosen-select").chosen({ width: "85%" });
    });
</script>
</body>
</html>