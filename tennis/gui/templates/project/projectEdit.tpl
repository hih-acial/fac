{**
 * TestLink Open Source Project - http://testlink.sourceforge.net/
 *
 * Smarty template - Edit existing Test project
 *
 * @filesource  projectEdit.tpl
 *
 * @internal revisions
 * @since 1.9.14
 *
 *}
{$cfg_section=$smarty.template|basename|replace:".tpl":""}
{config_load file="input_dimensions.conf" section=$cfg_section}

{* Configure Actions *}
{$managerURL="lib/project/projectEdit.php"}
{$editAction="$managerURL?doAction=edit&tprojectID="}

{lang_get var="labels" 
  s='show_event_history,th_active,cancel,info_failed_loc_prod,invalid_query,
  create_from_existent_tproject,opt_no,caption_edit_tproject,caption_new_tproject,name,
  title_testproject_management,testproject_enable_priority, testproject_enable_automation,
  public,testproject_color,testproject_alt_color,testproject_enable_requirements,
  testproject_enable_inventory,testproject_features,testproject_description,
  testproject_prefix,availability,mandatory,warning,warning_empty_tcase_prefix,api_key,
  warning_empty_tproject_name,testproject_issue_tracker_integration,issue_tracker,
  testproject_reqmgr_integration,reqmgrsystem,no_rms_defined,no_issuetracker_defined'}

{include file="inc_head.tpl" openHead="yes" jsValidate="yes" editorType=$editorType}
{include file="inc_del_onclick.tpl"}
{include file="../custom.tpl"}
{if $gui_cfg->testproject_coloring neq 'none'}
  {include file="inc_jsPicker.tpl"}
{/if}

<script type="text/javascript">
var alert_box_title = "{$labels.warning|escape:'javascript'}";
var warning_empty_tcase_prefix = "{$labels.warning_empty_tcase_prefix|escape:'javascript'}";
var warning_empty_tproject_name = "{$labels.warning_empty_tproject_name|escape:'javascript'}";

function validateForm(f)
{
  if (isWhitespace(f.tprojectName.value))
  {
     alert_message(alert_box_title,warning_empty_tproject_name);
     selectField(f, 'tprojectName');
     return false;
  }
  if (isWhitespace(f.tcasePrefix.value))
  {
     alert_message(alert_box_title,warning_empty_tcase_prefix);
     selectField(f, 'tcasePrefix');
     return false;
  }

  return true;
}

/**
 *
 *
 */
function manageIssueTracker(selectOID,targetOID)
{
  var so;
  var to;

  so = document.getElementById(selectOID);
  to = document.getElementById(targetOID);

  to.disabled = false;
  if(so.selectedIndex == 0)
  {
    to.checked = false;
    to.disabled = true;
  }  

}

</script>
</head>

<body onload="manageIssueTracker('issue_tracker_id','issue_tracker_enabled');">

    <div class="container-fluid">
        {if $user_feedback != ''}
            {include file="inc_update.tpl" user_feedback=$user_feedback feedback_type=$feedback_type}
        {/if}
      <section class="container">
        <div class="jumbotron">
            {if $gui->found == "yes"}
              <div style="width:80%; margin: auto;">
                <form class="form-horizontal" name="edit_testproject" id="edit_testproject"
                      method="post" action="{$managerURL}"
                      onSubmit="return validateForm(this);">
                  <fieldset>
                    <legend>
                      <h3>
                          {$main_descr|escape}  {$tlCfg->gui_title_separator_1}
                          {$caption|escape}
                          {if $mgt_view_events eq "yes" and $gui->tprojectID}
                            <img style="margin-left:5px;" class="clickable" src="{$tlImages.help}"
                                 onclick="showEventHistoryFor('{$gui->tprojectID}','testprojects')"
                                 alt="{$labels.show_event_history}" title="{$labels.show_event_history}"/>
                          {/if}
                      </h3>

                    </legend>
                    <div class="form-group">
                        {if $gui->tprojectID eq 0}
                            {if $gui->testprojects != ''}
                              <label for="copy_from_tproject_id" class="col-lg-2 control-label"> {$labels.create_from_existent_tproject}</label>
                              <div class="col-lg-10">
                                <select class="form-control"  id="copy_from_tproject_id" name="copy_from_tproject_id">
                                  <option value="0">{$labels.opt_no}</option>
                                    {foreach item=testproject from=$gui->testprojects}
                                      <option value="{$testproject.id}">{$testproject.name|escape}</option>
                                    {/foreach}
                                </select>
                              </div>
                            {/if}
                        {/if}
                    </div>
                    <div class="form-group">

                      <label class="col-lg-2 control-label" for="tprojectName">{$labels.name} <span style="color:red;">*</span></label>
                      <div class="col-lg-10">
                        <input class="form-control" id="tprojectName" type="text" name="tprojectName" size="{#TESTPROJECT_NAME_SIZE#}"
                               value="{$gui->tprojectName|escape}" maxlength="{#TESTPROJECT_NAME_MAXLEN#}" required />
                          {include file="error_icon.tpl" field="tprojectName"}
                      </div>

                    </div>

                    <div class="form-group">
                      <label class="col-lg-2 control-label" for="tcasePrefix">{$labels.testproject_prefix} <span style="color:red;">*</span></label>
                      <div class="col-lg-10">
                        <input class="form-control" id="tcasePrefix" type="text" name="tcasePrefix" size="{#TESTCASE_PREFIX_SIZE#}"
                               value="{$gui->tcasePrefix|escape}" maxlength="{#TESTCASE_PREFIX_MAXLEN#}" required />
                          {include file="error_icon.tpl" field="tcasePrefix"}
                      </div>
                    </div>

                    <div class="form-group">
                      <table class="common" style="width:100%; padding:3px;">
                        <tr>
                          <td style="font-weight: bold">{$labels.testproject_description}</td>
                          <td style="width:80%">{$notes}</td>
                        </tr>
                      </table>
                    </div>

                    <label class="col-lg-2 control-label" >{$labels.testproject_features}</label>

                    <div class="form-group col-lg-offset-2 col-lg-10">
                      <div class="checkbox">
                        <label>
                          <input type="checkbox" name="optReq"
                                  {if $gui->projectOptions->requirementsEnabled} checked="checked"  {/if} />
                            {$labels.testproject_enable_requirements}
                        </label>
                      </div>
                      <div class="checkbox">
                        <label>
                          <input type="checkbox" name="optPriority"
                                  {if $gui->projectOptions->testPriorityEnabled} checked="checked"  {/if} />
                            {$labels.testproject_enable_priority}
                        </label>
                      </div>
                      <div class="checkbox">
                        <label>
                          <input type="checkbox" name="optAutomation"
                                  {if $gui->projectOptions->automationEnabled} checked="checked" {/if} />
                            {$labels.testproject_enable_automation}
                        </label>
                      </div>
                      <div class="checkbox">
                        <label>
                          <input type="checkbox" name="optInventory"
                                  {if $gui->projectOptions->inventoryEnabled} checked="checked" {/if} />
                            {$labels.testproject_enable_inventory}
                        </label>
                      </div>
                    </div>

                    <div class="form-group">
                      <label for="issue_tracker_enabled" class="col-lg-2 control-label">{$labels.testproject_issue_tracker_integration}</label>
                      <div class="col-lg-10">
                          {if $gui->issueTrackers == ''}
                            <p >{$labels.no_issuetracker_defined}</p>
                          {else}
                            <div class="checkbox">
                              <input type="checkbox" id="issue_tracker_enabled"
                                     name="issue_tracker_enabled" {if $gui->issue_tracker_enabled == 1} checked="checked" {/if} />
                                {$labels.th_active}
                            </div>
                          {/if}
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="issue_tracker_id" class="col-lg-2 control-label">{$labels.issue_tracker}</label>
                      <div class="col-lg-10">
                        <select class="form-control" name="issue_tracker_id" id="issue_tracker_id"
                                onchange="manageIssueTracker('issue_tracker_id','issue_tracker_enabled');">
                          <option value="0">&nbsp;</option>
                            {foreach item=issue_tracker from=$gui->issueTrackers}
                              <option value="{$issue_tracker.id}"
                                      {if $issue_tracker.id == $gui->issue_tracker_id} selected {/if}
                              >
                                  {$issue_tracker.verbose|escape}</option>
                            {/foreach}
                        </select>
                      </div>

                    </div>
                    <label class="col-lg-2 control-label" >{$labels.availability}</label>
                    <div class="form-group form-inline col-lg-offset-2 col-lg-10">
                      <div class="checkbox">
                        <label>
                          <input type="checkbox" name="active" {if $gui->active eq 1} checked="checked" {/if} />
                            {$labels.th_active}
                        </label>
                      </div>
                      &nbsp; &nbsp;
                      <div class="checkbox">
                        <label>
                          <input type="checkbox" name="is_public" {if $gui->is_public eq 1} checked="checked"  {/if} />
                            {$labels.public}
                        </label>
                      </div>
                    </div>
                      {if $gui->api_key != ''}
                        <label class="col-lg-2 control-label">{$labels.api_key}</label>
                        <p class="text-primary">{$gui->api_key}</p>
                      {/if}
                      {if $gui->canManage == "yes"}
                        <div class="form-group">
                          <div class="col-lg-10 col-lg-offset-2">
                            <input type="hidden" name="doAction" value="{$doActionValue}" />
                            <input type="hidden" name="tprojectID" value="{$gui->tprojectID}" />
                            <input class="btn btn-success" type="submit" name="doActionButton" value="{$buttonValue}" />
                            <input class="btn btn-default" type="button" name="go_back" value="{$labels.cancel}" onclick="location.href=fRoot+'lib/project/projectView.php';" />
                          </div>
                        </div>
                      {/if}
                  </fieldset>
                </form>
                <p style="font-size: small" class="text-danger"><span style="color: red">*</span> {$labels.mandatory}</p>
              </div>
            {else}
              <p class="info">
                  {if $gui->tprojectName != ''}
                      {$labels.info_failed_loc_prod} - {$gui->tprojectName|escape}!<br />
                  {/if}
                  {$labels.invalid_query}: {$sqlResult|escape}</p>
            {/if}
        </div>
      </section>
    </div>

</body>
</html>
