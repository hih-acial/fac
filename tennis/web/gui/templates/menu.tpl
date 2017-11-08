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