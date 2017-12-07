{*
 Testlink Open Source Project - http://testlink.sourceforge.net/
 @filesource  mainPageLeft.tpl
 Purpose: smarty template - main page / site map

 @internal revisions
 @since 1.9.15
*}
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

'}

{* Show / Hide section logic *}
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





{$divStyle="width:300px;padding: 0px 0px 0px 10px;"}
{$aStyle="padding: 3px 15px;font-size:16px"}

{$projectView="lib/project/projectView.php"}
{$usersAssign="lib/usermanagement/usersAssign.php?featureType=testproject&featureID="}
{$cfAssignment="lib/cfields/cfieldsTprojectAssign.php"}
{$keywordsAssignment="lib/keywords/keywordsView.php?tproject_id="}
{$platformsView="lib/platforms/platformsView.php"}
<div class="container">
<div class="jumbotron">
    <div class="text-center center-block">
        <h1 class="text-primary">Welcome to TestLink !</h1>
        <h1>Menu</h1>
    </div>

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
</div>