{* 
TestLink Open Source Project - http://testlink.sourceforge.net/ 
$Id: platformsExport.tpl,v 1.3 2010/11/06 11:42:47 amkhullar Exp $ 
Purpose: smarty template - platforms export
rev:

*}
{assign var="cfg_section" value=$smarty.template|basename|replace:".tpl":"" }
{config_load file="input_dimensions.conf" section=$cfg_section}
{include file="inc_head.tpl" openHead="yes" jsValidate="yes"}
{include file="inc_del_onclick.tpl"}
{include file="custom.tpl"}

{lang_get var="labels" 
          s='btn_export,btn_cancel,warning,export_filename,file_type,
             view_file_format_doc,warning_empty_filename'}

{literal}
<script type="text/javascript">
{/literal}
// BUGID 3943: Escape all messages (string)
var alert_box_title = "{$labels.warning|escape:'javascript'}";
var warning_empty_filename = "{$labels.warning_empty_filename|escape:'javascript'}";
{literal}
function validateForm(f)
{
  if (isWhitespace(f.export_filename.value)) 
  {
      alert_message(alert_box_title,warning_empty_filename);
      selectField(f, 'export_filename');
      return false;
  }
  return true;
}
</script>
{/literal}
</head>


<body>
<section class="jumbotron">
	<h2 class="text-center">{$gui->page_title|escape}</h2>
</section>
<div class="container">
{if $gui->do_it eq 1}
  <form method="post" id="export_xml" enctype="multipart/form-data" 
        action="lib/platforms/platformsExport.php"
        onsubmit="return validateForm(this);">
  	<fieldset>
		<legend><h3>Formulaire d'exportation de plateforme</h3></legend>
	</fieldset>
	  <div class="form-group">
		  <label for="{$labels.export_filename}">{$labels.export_filename}</label>
		  <input class="form-control" id="{$labels.export_filename}" type="text" name="export_filename" maxlength="{#FILENAME_MAXLEN#}"
				 value="{$gui->export_filename|escape}" size="{#FILENAME_SIZE#}"/>
          {include file="error_icon.tpl" field="export_filename"}
	  </div>
	  <div class="form-group">
		  <label for="{$labels.file_type}">{$labels.file_type}</label>
		  <select class="form-control" id="{$labels.file_type}" name="exportType">
              {html_options options=$gui->exportTypes}
		  </select>
		  <a href="{$basehref}{$smarty.const.PARTIAL_URL_TL_FILE_FORMATS_DOCUMENT}">{$labels.view_file_format_doc}</a>
	  </div>
  	
  	<div class="center-block text-center">
  	  	<input type="hidden" name="doAction" id="doAction" value="" />
  		<input class="btn btn-info" type="submit" name="doExport" id="doExport" value="{$labels.btn_export}"
  		                     onclick="doAction.value=this.id" />
    	<input class="btn btn-secondary" type="button" name="cancel" value="{$labels.btn_cancel}"
    		  {if $gui->goback_url  != ''}  onclick="location='{$gui->goback_url }'"
    		  {else}  onclick="history.back();" {/if} />
  	</div>
  </form>
{else}
	<div class="alert alert-primary">
        {$gui->nothing_todo_msg|escape}
	</div>
{/if}

</div>

</body>
</html>
