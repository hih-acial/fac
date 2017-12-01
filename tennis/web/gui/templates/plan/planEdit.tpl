{*
TestLink Open Source Project - http://testlink.sourceforge.net/
@filesource planEdit.tpl

Purpose: smarty template - create Test Plan
@internal revisions
@since 1.9.10
*}

{lang_get var="labels"
          s="warning,warning_empty_tp_name,testplan_title_edit,public,api_key,
             testplan_th_name,testplan_th_notes,testplan_question_create_tp_from,
             opt_no,testplan_th_active,btn_testplan_create,btn_upd,cancel,
             show_event_history,testplan_txt_notes"}



{include file="inc_head.tpl" openHead="yes" jsValidate="yes" editorType=$gui->editorType}
{include file="inc_del_onclick.tpl"}
{include file="custom.tpl"}
<script type="text/javascript">
var alert_box_title = "{$labels.warning|escape:'javascript'}";
var warning_empty_tp_name = "{$labels.warning_empty_tp_name|escape:'javascript'}";

function validateForm(f)
{
  var cf_designTime = document.getElementById('custom_field_container');
  if (isWhitespace(f.testplan_name.value))
  {
      alert_message(alert_box_title,warning_empty_tp_name);
      selectField(f, 'testplan_name');
      return false;
  }
  
  /* Validation of a limited type of custom fields */
  if (cf_designTime)
  {
    var cfields_container = cf_designTime.getElementsByTagName('input');
    var cfieldsChecks = validateCustomFields(cfields_container);
    if(!cfieldsChecks.status_ok)
    {
        var warning_msg = cfMessages[cfieldsChecks.msg_id];
        alert_message(alert_box_title,warning_msg.replace(/%s/, cfieldsChecks.cfield_label));
        return false;
    }
  
    /* Text area needs a special access */
    cfields_container = cf_designTime.getElementsByTagName('textarea');
    cfieldsChecks = validateCustomFields(cfields_container);
    if(!cfieldsChecks.status_ok)
    {
        var warning_msg = cfMessages[cfieldsChecks.msg_id];
        alert_message(alert_box_title,warning_msg.replace(/%s/, cfieldsChecks.cfield_label));
        return false;
    }
  }
  return true;
}

/**
 * manage_copy_ctrls
 *
 */
function manage_copy_ctrls(container_id,display_control_value,hide_value)
{
 o_container=document.getElementById(container_id);

 if( display_control_value == hide_value )
 {
   o_container.style.display='none';
 }
 else
 {
    o_container.style.display='';
 }
}

/**
 * Be Carefull this TRUST on existence of $gui->delAttachmentURL
 */
function jsCallDeleteFile(btn, text, o_id)
{ 
  var my_action='';
  if( btn == 'yes' )
  {
    my_action='{$gui->delAttachmentURL}'+o_id;
    window.location=my_action;
  }
}        
</script>

</head>

<body>
{$cfg_section=$smarty.template|basename|replace:".tpl":""}
{config_load file="input_dimensions.conf" section=$cfg_section}
{$planID=$gui->tplan_id}
{if !isset($loadOnCancelURL)}
  {$loadOnCancelURL=""}
{/if}
<section class="jumbotron">
    <h2 class="text-center">{$gui->main_descr|escape}</h2>
</section>

<div class="container">
    <div class="alert alert-primary">{$labels.testplan_txt_notes}</div>
    <br>
{include file="inc_update.tpl" user_feedback=$gui->user_feedback}
  {$form_action='create'}
  {if $gui->tplan_id neq 0}
    <h2>
    {$labels.testplan_title_edit} {$gui->testplan_name|escape}
    {$form_action='update'}
    {if $gui->grants->mgt_view_events eq "yes"}
      <img style="margin-left:5px;" class="clickable" src="{$smarty.const.TL_THEME_IMG_DIR}/question.gif" 
           onclick="showEventHistoryFor('{$gui->tplan_id}','testplans')" alt="{$labels.show_event_history}" 
           title="{$labels.show_event_history}"/>
    {/if}
    </h2>
      <hr>
  {else}
      <h2>Formulaire de création d'une campagne</h2>
      <hr>
  {/if}

  <form method="post" name="testplan_mgmt" id="testplan_mgmt"
        action="lib/plan/planEdit.php?action={$form_action}"
        onSubmit="return validateForm(this);">
  <fieldset>

      <input type="hidden" id="tplan_id" name="tplan_id" value="{$gui->tplan_id}" />

      <div class="form-group">
          <label for="testplan_name">{$labels.testplan_th_name}</label>
          <input class="form-control" type="text" id="testplan_name" name="testplan_name"
                 size="{#TESTPLAN_NAME_SIZE#}"
                 maxlength="{#TESTPLAN_NAME_MAXLEN#}"
                 value="{$gui->testplan_name|escape}" required />
          {include file="error_icon.tpl" field="testplan_name"}
      </div>
      <div class="form-group">
          <label for="{$labels.testplan_th_notes}">{$labels.testplan_th_notes}</label>
          {$gui->notes}
      </div>

      {if $gui->tplan_id eq 0}
      {if $gui->tplans}
      <div class="form-group">
          <label for="copy_from_tplan_id">{$labels.testplan_question_create_tp_from}</label>
          <select class="form-control" id="copy_from_tplan_id" name="copy_from_tplan_id"
                  onchange="manage_copy_ctrls('copy_controls',this.value,'0')">
              <option value="0">{$labels.opt_no}</option>
              {foreach item=testplan from=$gui->tplans}
                  <option value="{$testplan.id}">{$testplan.name|escape}</option>
              {/foreach}
          </select>
          <div id="copy_controls" style="display:none;">
              {assign var=this_template_dir value=$smarty.template|dirname}
              {include file="$this_template_dir/inc_controls_planEdit.tpl"}
          </div>
      </div>
      {/if}
      {/if}
  <table class="common" width="10%">
      <tr>
        <th style="background:none;">{$labels.testplan_th_active}</th>
          <td>
            <input type="checkbox" name="active" {if $gui->is_active eq 1}  checked="checked" {/if} />
          </td>
      </tr>
      <tr>
        <th style="background:none;">{$labels.public}</th>
          <td>
            <input type="checkbox" name="is_public" {if $gui->is_public eq 1} checked="checked" {/if} />
          </td>
      </tr>
  </table>
      <br>
      {if isset($gui->api_key) && $gui->api_key != ''}
      <div class="form-group">
          <label for="{$labels.api_key}">{$labels.api_key}</label>
          <p>{$gui->api_key}</p>
      </div>
      {/if}



    {if $gui->cfields neq ''}
        <p>{$gui->cfields}</p>
    {/if}


  <div class="groupBtn">
    {if $gui->tplan_id eq 0}
      <input type="hidden" name="do_action" value="do_create" />
      <input class="btn btn-info" type="submit" name="do_create" value="{$labels.btn_testplan_create}"
             onclick="do_action.value='do_create'"/>
    {else}

      <input type="hidden" name="do_action" value="do_update" />
      <input class="btn btn-info" type="submit" name="do_update" value="{$labels.btn_upd}"
             onclick="do_action.value='do_update'"/>

    {/if}

    <input class="btn btn-secondary" type="button" name="go_back" value="{$labels.cancel}"
                         onclick="location.href=fRoot+'lib/plan/planView.php';" />

  </div>
  </fieldset>
  </form>
    <hr>
{if $gui->tplan_id neq 0}
  {$downloadOnly=true}
  {if $gui->grants->testplan_create eq 'yes'}
    {$downloadOnly=false}
  {/if}
  {include file="attachments.inc.tpl" 
               attach_id=$planID
               attach_tableName=$gui->attachmentTableName
               attach_attachmentInfos=$gui->attachments[$planID]  
               attach_downloadOnly=$downloadOnly
               attach_loadOnCancelURL=$loadOnCancelURL}
{/if}
             


</div>


</body>
</html>