{*
TestLink Open Source Project - http://testlink.sourceforge.net/
@filesource	platformsEdit.tpl
Purpose: smarty template - View all platforms

@internal revisions
*}
{assign var="url_args" value="lib/platforms/platformsEdit.php"}
{assign var="platform_edit_url" value="$basehref$url_args"}

{lang_get var="labels"
          s="warning,warning_empty_platform,show_event_history,
             th_platform,th_notes,btn_cancel"}


{include file="inc_head.tpl" jsValidate="yes" openHead="yes"}
{include file="inc_del_onclick.tpl"}
{include file="custom.tpl"}

{literal}
<script type="text/javascript">
{/literal}
var alert_box_title = "{$labels.warning|escape:'javascript'}";
var warning_empty_platform = "{$labels.warning_empty_platform|escape:'javascript'}";
{literal}
function validateForm(f)
{
	if (isWhitespace(f.name.value))
  {
    alert_message(alert_box_title,warning_empty_platform);
    selectField(f, 'name');
    return false;
  }
	return true;
}
</script>
{/literal}
</head>

<body>
{assign var="cfg_section" value=$smarty.template|basename|replace:".tpl":"" }
{config_load file="input_dimensions.conf" section=$cfg_section}
<section class="jumbotron">
	<h2 class="text-center">{$gui->action_descr|escape}</h2>
</section>

{include file="inc_feedback.tpl" user_feedback=$gui->user_feedback}

{if $gui->canManage ne ""}
  <div class="container">
  
  <div>
	{if $gui->mgt_view_events eq "yes" && $gui->platformID > 0}
			<img style="margin-left:5px;" class="clickable" 
			     src="{$smarty.const.TL_THEME_IMG_DIR}/question.gif" 
			     onclick="showEventHistoryFor('{$gui->platformID}','platforms')" 
			     alt="{$labels.show_event_history}" title="{$labels.show_event_history}"/>
	{/if}
  
  </div><br />

  	<form id="addPlatform" name="addPlatform" method="post" action="{$platform_edit_url}"
 		      onsubmit="return validateForm(this);">
	<div class="form-group">
		<label for="{$labels.th_platform}">{$labels.th_platform}</label>
        {assign var="input_name" value="name"}
		<input class="form-control" id="{$labels.th_platform}" type="text" name="{$input_name}"
			   size="{#PLATFORM_SIZE#}" maxlength="{#PLATFORM_MAXLEN#}"
			   value="{$gui->name|escape}" required />
        {include file="error_icon.tpl" field="$input_name"}
	</div>
		<div class="form-group">
			<label for="{$labels.th_notes}">{$labels.th_notes}</label>
            {$gui->notes}
		</div>
  	<div class="text-center center-block">
	  	<input type="hidden" name="doAction" value="" />
	    <input class="btn btn-success" type="submit" id="submitButton" name="submitButton" value="{$gui->submit_button_label}"
		         onclick="doAction.value='{$gui->submit_button_action}'" />
	  	<input class="btn btn-secondary" type="button" value="{$labels.btn_cancel}"
		         onclick="location.href=fRoot+'lib/platforms/platformsView.php'" />
  	</div>
  	</form>
  </div>
{/if}
{* --------------------------------------------------------------------------------------   *}

</body>
</html>
