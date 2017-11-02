{*
TestLink Open Source Project - http://testlink.sourceforge.net/
@filesource  rolesEdit.tpl
Purpose: smarty template - create/edit user role

@internal revisions
@since 1.9.15
*}

{lang_get var="labels"
          s='btn_save,warning,warning_modify_role,warning_empty_role_name,th_rights,
             error_role_no_rights,caption_possible_affected_users,enter_role_notes,
             title_user_mgmt,caption_define_role,th_mgttc_rights,th_req_rights,
             th_product_rights,th_user_rights,th_kw_rights,th_cf_rights,th_system_rights,
             th_platform_rights,demo_update_role_disabled,th_issuetracker_rights,show_event_history,
             th_reqmgrsystem_rights,th_execution_rights,
             th_rolename,th_tp_rights,btn_cancel'}

{include file="inc_head.tpl" openHead="yes" jsValidate="yes" editorType=$gui->editorType}
{include file="inc_del_onclick.tpl"}
{include file="inc_jsCheckboxes.tpl"}

<script type="text/javascript">
var alert_box_title = "{$labels.warning|escape:'javascript'}";
var warning_modify_role = "{$labels.warning_modify_role|escape:'javascript'}";
var warning_empty_role_name = "{$labels.warning_empty_role_name|escape:'javascript'}";
var warning_error_role_no_rights = "{$labels.error_role_no_rights|escape:'javascript'}";

function validateForm(f)
{
  if (isWhitespace(f.rolename.value))
  {
      alert_message(alert_box_title,warning_empty_role_name);
      selectField(f, 'rolename');
      return false;
  }

  if( checkbox_count_checked(f.id) == 0)
  {
      alert_message(alert_box_title,warning_error_role_no_rights);
      return false;
  }

  return true;
}
</script>
</head>


<body>
{$cfg_section=$smarty.template|basename|replace:".tpl":""}
{config_load file="input_dimensions.conf" section=$cfg_section}


<h1 class="text-center text-success">{$gui->main_title}</h1>
{include file="inc_update.tpl" user_feedback=$gui->userFeedback}

<section class="well">

  <form class="form-horizontal" name="rolesedit" id="rolesedit"
    method="post" action="lib/usermanagement/rolesEdit.php"
    {if $gui->grants->role_mgmt == "yes"}
      onSubmit="return validateForm(this);"
    {else}
      onsubmit="return false"
    {/if}
  >
  <input type="hidden" name="roleid" value="{$gui->role->dbID}" />
    <div class="form-group">
      <label class="col-lg-1 control-label" for="rolename">{$labels.th_rolename} <span style="color:red;">*</span></label>
        {if $gui->grants->mgt_view_events eq "yes" && $gui->role->dbID}
    <img src="{$tlImages.info}" alt="{$labels.show_event_history}"
         title="{$labels.show_event_history}"
         onclick="showEventHistoryFor('{$gui->role->dbID}','roles');" />
        {/if}
      <div class="col-lg-4">
        <input id="rolename" class="form-control" type="text" name="rolename" {$gui->disabledAttr}
               size="{#ROLENAME_SIZE#}" maxlength="{#ROLENAME_MAXLEN#}" value="{$gui->role->name|escape}" required />
          {include file="error_icon.tpl" field="rolename"}
      </div>
    </div>
      <div class="form-group">
          <label class="col-lg-1">{$labels.enter_role_notes}</label>
          <div class="col-lg-4">{$gui->notes}</div>
      </div>
      <h3 class="text-success">{$labels.th_rights}</h3>
      <div class="col-lg-12">
      <div class="col-lg-3">
          <div class="panel panel-success">
              <div class="panel-heading">
                  <h3 class="panel-title text-center">{$labels.th_tp_rights}s</h3>
              </div>
              <div class="panel-body">
                  {foreach from=$gui->rightsCfg->tplan_mgmt item=id key=k}
                      <div class="checkbox">
                          <label>
                              <input type="checkbox" name="grant[{$k}]" {$gui->checkboxStatus[$k]}> {$id}
                          </label>
                      </div>
                  {/foreach}
              </div>
          </div>
      </div>
      <div class="col-lg-3">
          <div class="panel panel-success">
              <div class="panel-heading">
                  <h3 class="panel-title text-center">{$labels.th_mgttc_rights}</h3>
              </div>
              <div class="panel-body">
                  {foreach from=$gui->rightsCfg->tcase_mgmt item=id key=k}
                      <div class="checkbox">
                          <label>
                              <input type="checkbox" name="grant[{$k}]" {$gui->checkboxStatus[$k]}> {$id}
                          </label>
                      </div>
                  {/foreach}
              </div>
          </div>
      </div>
      <div class="col-lg-3">
          <div class="panel panel-success">
              <div class="panel-heading">
                  <h3 class="panel-title text-center">{$labels.th_req_rights}</h3>
              </div>
              <div class="panel-body">
                  {foreach from=$gui->rightsCfg->req_mgmt item=id key=k}
                      <div class="checkbox">
                          <label>
                              <input type="checkbox" name="grant[{$k}]" {$gui->checkboxStatus[$k]}> {$id}
                          </label>
                      </div>
                  {/foreach}
              </div>
          </div>
      </div>
      <div class="col-lg-3">
          <div class="panel panel-success">
              <div class="panel-heading">
                  <h3 class="panel-title text-center">{$labels.th_product_rights}</h3>
              </div>
              <div class="panel-body">
                  {foreach from=$gui->rightsCfg->tproject_mgmt item=id key=k}
                      <div class="checkbox">
                          <label>
                              <input type="checkbox" name="grant[{$k}]" {$gui->checkboxStatus[$k]}> {$id}
                          </label>
                      </div>
                  {/foreach}
              </div>
          </div>
      </div>
      </div>
      <div class="col-lg-12">
      <div class="col-lg-3">
          <div class="panel panel-success">
              <div class="panel-heading">
                  <h3 class="panel-title text-center">{$labels.th_user_rights}</h3>
              </div>
              <div class="panel-body">
                  {foreach from=$gui->rightsCfg->user_mgmt item=id key=k}
                      <div class="checkbox">
                          <label>
                              <input type="checkbox" name="grant[{$k}]" {$gui->checkboxStatus[$k]}> {$id}
                          </label>
                      </div>
                  {/foreach}
              </div>
          </div>
      </div>
      <div class="col-lg-3">
          <div class="panel panel-success">
              <div class="panel-heading">
                  <h3 class="panel-title text-center">{$labels.th_kw_rights}</h3>
              </div>
              <div class="panel-body">
                  {foreach from=$gui->rightsCfg->kword_mgmt item=id key=k}
                      <div class="checkbox">
                          <label>
                              <input type="checkbox" name="grant[{$k}]" {$gui->checkboxStatus[$k]}> {$id}
                          </label>
                      </div>
                  {/foreach}
              </div>
          </div>
      </div>
      <div class="col-lg-3">
          <div class="panel panel-success">
              <div class="panel-heading">
                  <h3 class="panel-title text-center">{$labels.th_cf_rights}</h3>
              </div>
              <div class="panel-body">
                  {foreach from=$gui->rightsCfg->cfield_mgmt item=id key=k}
                      <div class="checkbox">
                          <label>
                              <input type="checkbox" name="grant[{$k}]" {$gui->checkboxStatus[$k]}> {$id}
                          </label>
                      </div>
                  {/foreach}
              </div>
          </div>
      </div>
      <div class="col-lg-3">
          <div class="panel panel-success">
              <div class="panel-heading">
                  <h3 class="panel-title text-center">{$labels.th_system_rights}</h3>
              </div>
              <div class="panel-body">
                  {foreach from=$gui->rightsCfg->system_mgmt item=id key=k}
                      <div class="checkbox">
                          <label>
                              <input type="checkbox" name="grant[{$k}]" {$gui->checkboxStatus[$k]}> {$id}
                          </label>
                      </div>
                  {/foreach}
              </div>
          </div>
      </div>
      </div>
      <div class="col-lg-12">
      <div class="col-lg-3">
          <div class="panel panel-success">
              <div class="panel-heading">
                  <h3 class="panel-title text-center">{$labels.th_platform_rights}</h3>
              </div>
              <div class="panel-body">
                  {foreach from=$gui->rightsCfg->platform_mgmt item=id key=k}
                      <div class="checkbox">
                          <label>
                              <input type="checkbox" name="grant[{$k}]" {$gui->checkboxStatus[$k]}> {$id}
                          </label>
                      </div>
                  {/foreach}
              </div>
          </div>
      </div>
      <div class="col-lg-3">
          <div class="panel panel-success">
              <div class="panel-heading">
                  <h3 class="panel-title text-center">{$labels.th_issuetracker_rights}</h3>
              </div>
              <div class="panel-body">
                  {foreach from=$gui->rightsCfg->issuetracker_mgmt item=id key=k}
                      <div class="checkbox">
                          <label>
                              <input type="checkbox" name="grant[{$k}]" {$gui->checkboxStatus[$k]}> {$id}
                          </label>
                      </div>
                  {/foreach}
              </div>
          </div>
      </div>
      <div class="col-lg-3">
          <div class="panel panel-success">
              <div class="panel-heading">
                  <h3 class="panel-title text-center">{$labels.th_execution_rights}</h3>
              </div>
              <div class="panel-body">
                  {foreach from=$gui->rightsCfg->execution item=id key=k}
                      <div class="checkbox">
                          <label>
                              <input type="checkbox" name="grant[{$k}]" {$gui->checkboxStatus[$k]}> {$id}
                          </label>
                      </div>
                  {/foreach}
              </div>
          </div>
      </div>
     </div>
      <br>
  {$submitEnabled="1"}
  {if $tlCfg->demoMode}
    {if $gui->operation == 'doUpdate'}
      {$submitEnabled="0"}
    {/if}  
  {/if}
  

  {if $gui->grants->role_mgmt == "yes" && $gui->role->dbID != $smarty.const.TL_ROLES_NO_RIGHTS}

    
    {if $submitEnabled}
      {if $gui->roleCanBeEdited}
        <input type="hidden" name="doAction" value="{$gui->operation}" />
        <input class="btn btn-success col-lg-offset-5" type="submit" name="role_mgmt" value="{$labels.btn_save}"
               {if $gui->role != null && $gui->affectedUsers neq null} onClick="return modifyRoles_warning()"{/if}
        />
      {/if}    
    {else}
      {$labels.demo_update_role_disabled}<br>
    {/if}
    
    
  {/if}
    <input class="btn btn-default" type="button" name="cancel" value="{$labels.btn_cancel}"
      onclick="location.href=fRoot+'lib/usermanagement/rolesView.php';" />
  <br />
  {if $gui->affectedUsers neq null}
    <table class="common" style="width:50%">
    <caption>{$labels.caption_possible_affected_users}</caption>
    {foreach from=$gui->affectedUsers item=user}
    <tr>
      <td>{$user->getDisplayName()|escape}</td>
    </tr>
    {/foreach}
    </table>
  {/if}
  </form>
</section>
</body>
</html>