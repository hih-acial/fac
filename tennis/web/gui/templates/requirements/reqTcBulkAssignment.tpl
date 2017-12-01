{*
TestLink Open Source Project - http://testlink.sourceforge.net/
Id: reqAssign.tpl,v 1.6 2006/07/15 19:55:30 schlundus Exp $

Author: Francisco Mancardi

Purpose: Requirements Bulk Assignment

rev:
    20100408 - franciscom - BUGID 3361 FatalError after trying to assign requirements to an empty test suite
    20100403 - franciscom - added config_load
    20081130 - franciscom - BUGID 1852 - Bulk Assignment Feature
*}
{assign var="cfg_section" value=$smarty.template|basename|replace:".tpl":"" }
{config_load file="input_dimensions.conf" section=$cfg_section}

{lang_get var="labels"
          s="req_doc_id,scope,req,req_title_bulk_assign,no_req_spec_available,
             please_select_a_req,test_case,req_title_assign,btn_close,
             req_spec,warning,req_title_available,req_title_assigned,
             check_uncheck_all_checkboxes,req_msg_norequirement,btn_unassign,
             req_title_unassigned,check_uncheck_all_checkboxes,
             req_msg_norequirement,btn_assign,requirement"}

{include file="inc_head.tpl" openHead="yes"}
{include file="inc_jsCheckboxes.tpl"}
{include file="inc_del_onclick.tpl"}
{include file="custom.tpl"}
<script type="text/javascript">
var please_select_a_req="{$labels.please_select_a_req|escape:'javascript'}";
var alert_box_title = "{$labels.warning|escape:'javascript'}";
{literal}

function check_action_precondition(form_id,action)
{
	if(checkbox_count_checked(form_id) <= 0)
	{
		alert_message(alert_box_title,please_select_a_req);
		return false;
	}
	return true;
}
</script>
{/literal}
</head>
<body>
<section class="jumbotron">
	<h2 class="text-center">
        {$gui->pageTitle|escape}
        {include file="inc_help.tpl" helptopic="hlp_requirementsCoverage" show_help_icon=true}
	</h2>
</section>

{if $gui->has_req_spec}

    <div class="container">
      <h2>{$labels.req_title_bulk_assign}</h2>
		<hr>
		<form id="SRS_switch" name="SRS_switch" method="post">
        <input type="hidden" name="form_token" id="form_token" value="{$gui->form_token}" />
 	      <input type="hidden" name="doAction" id="doAction" value="switchspec" />
 	      <input type="hidden" name="id" id="id" value="{$gui->tsuite_id}" />
        <div class="form-group">
			<label for="idSRS">{$labels.req_spec}</label>
			<select class="form-control" id="idSRS" name="idSRS" onchange="form.submit()">
                {html_options options=$gui->req_specs selected=$gui->selectedReqSpec}</select>
		</div>
      </form>
      {include file="inc_update.tpl" user_feedback=$gui->user_feedback}
		<br>
		<hr>
      {if $gui->requirements != ""}
		<div class="alert alert-primary">
			<h3>NB :</h3>
            {* 20100408 - BUGID *}
            {$gui->bulkassign_warning_msg}
		</div>
		  <hr>
		  <br>
        {if $gui->tcase_number > 0}
          <h2>{$labels.req_title_available}</h2>
			<hr>
			<form id="reqList" method="post" action="lib/requirements/reqTcAssign.php">
             <input type="hidden" name="form_token" id="form_token" value="{$gui->form_token}" />
             <input type="hidden" name="id" id="id"  value="{$gui->tsuite_id}" />

          <div id="div_assigned_req">
     	      {* used as memory for the check/uncheck all checkbox javascript logic *}
             <input type="hidden" name="memory_assigned_req"
                                  id="memory_assigned_req"  value="0" />

          <input type="hidden" name="idSRS" value="{$gui->selectedReqSpec}" />
          <table class="table">
          	<thead class="thead-dark">
			<tr>
				<th>
					<img src="{$smarty.const.TL_THEME_IMG_DIR}/toggle_all.gif"
						 onclick='cs_all_checkbox_in_div("div_assigned_req","assigned_req","memory_assigned_req");'
						 title="{$labels.check_uncheck_all_checkboxes}" />
				</th>
				<th>{$labels.req_doc_id}</th>
				<th>{$labels.req}</th>
				<th>{$labels.scope}</th>
			</tr>
			</thead>
          	{section name=row loop=$gui->requirements}
          	<tr>
          		<td><input type="checkbox" id="assigned_req{$gui->requirements[row].id}"
          		                           name="req_id[{$gui->requirements[row].id}]" /></td>
          		<td><span>{$gui->requirements[row].req_doc_id|escape}</span></td>
          		<td>
          			<img class="clickable" src="{$smarty.const.TL_THEME_IMG_DIR}/edit_icon.png"
          			     onclick="openLinkedReqWindow({$gui->requirements[row].id});"
          			     title="{$labels.requirement}" />
          			{$gui->requirements[row].title|escape}
          		</td>
				<td>{if $gui->reqSpecEditorType == 'none'}{$gui->requirements[row].scope|nl2br}{else}{$gui->requirements[row].scope|strip_tags|strip|truncate:#SCOPE_SHORT_TRUNCATE#}{/if}</td>
          	</tr>
          	{sectionelse}
          	<tr><td></td><td><span class="text-primary">{$labels.req_msg_norequirement}</span></td></tr>
          	{/section}
          </table>
       	  </div>

          {if $smarty.section.row.total > 0}
          	<div class="groupBtn">
          	  	<input type="hidden" name="doAction" id="doAction" value="bulkassign" />
          		<input class="btn btn-success" type="submit" name="actionButton" value="{$labels.btn_assign}"
 		      		       onclick="return check_action_precondition('reqList');"/>
          	</div>
          {/if}
          </form>
       {/if}  {* no test case available on test suite *}
    {/if}

    </div>
{else}
    {$labels.no_req_spec_available}
{/if}
</body>
</html>
