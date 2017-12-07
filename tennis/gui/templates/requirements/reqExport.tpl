{* TestLink Open Source Project - http://testlink.sourceforge.net/ *}
{* $Id: reqExport.tpl,v 1.8 2010/11/06 11:42:47 amkhullar Exp $ *}
{* Purpose: smarty template - req export initial page *}
{* revisions:
*}
{lang_get var="labels"
          s="warning_empty_filename,title_req_export,warning,btn_export,btn_cancel,
             view_file_format_doc,req_spec,export_filename,file_type"}

{assign var="cfg_section" value=$smarty.template|basename|replace:".tpl":"" }
{config_load file="input_dimensions.conf" section=$cfg_section}

{assign var="req_module" value='lib/requirements/'}
{assign var="url_args" value="reqExport.php"}
{assign var="req_export_url" value="$req_module$url_args"}

{assign var="url_args" value="reqSpecView.php?req_spec_id="}
{assign var="req_spec_view_url" value="$basehref$req_module$url_args"}

{if $gui->req_spec_id == 0}
  {assign var="dummy" value=$gui->tproject_id}
  {assign var="targetUrl" value="lib/project/project_req_spec_mgmt.php?id="}
  {assign var="xurl" value="$basehref$targetUrl"}
  {assign var="cancelUrl" value="$xurl$dummy"}
{else}
  {assign var="req_spec_view_url" value="$basehref$req_module$url_args"}
  {assign var="dummy" value=$gui->req_spec_id}
  {assign var="cancelUrl" value="$req_spec_view_url$dummy"}
{/if}

{include file="inc_head.tpl" openHead="yes" jsValidate="yes"}
{include file="inc_del_onclick.tpl"}
{include file="../custom.tpl"}
{literal}
<script type="text/javascript">
{/literal}
// BUGID 3943: Escape all messages (string)
var warning_empty_filename = "{$labels.warning_empty_filename|escape:'javascript'}";
var alert_box_title = "{$labels.warning}";
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
    <h2 class="text-center">{$labels.req_spec} {$smarty.const.TITLE_SEP} {$gui->req_spec.title|escape}</h2>
</section>

<div class="container">


<form method="post" enctype="multipart/form-data" action="{$req_export_url}"
      onSubmit="return validateForm(this);">
    <fieldset>
        <legend><h3>{$labels.title_req_export}</h3></legend>
        <div class="form-group">
            <label for="{$labels.export_filename}">{$labels.export_filename}</label>
            <input type="text" class="form-control" id="{$labels.export_filename}" name="export_filename" maxlength="{#FILENAME_MAXLEN#}"
                   value="{$gui->export_filename|escape}" size="{#FILENAME_SIZE#}"/>
            {include file="error_icon.tpl" field="export_filename"}
        </div>
        <div class="form-group">
            <label for="{$labels.file_type}">{$labels.file_type}</label>
            <select class="form-control" id="{$labels.file_type}" name="exportType">
                {html_options options=$gui->exportTypes}
            </select>
            <a href={$basehref}{$smarty.const.PARTIAL_URL_TL_FILE_FORMATS_DOCUMENT}>{$labels.view_file_format_doc}</a>
        </div>
        <div class="text-center">
            <input type="hidden" id="doAction" name="doAction" value="export" />
            <input type="hidden" name="req_spec_id" value="{$gui->req_spec_id}" />
            <input type="hidden" name="scope" id="scope" value="{$gui->scope}" />
            <input type="hidden" name="tproject_id" value="{$gui->tproject_id}" />
            <input class="btn btn-info" type="submit" id="export" name="export" value="{$labels.btn_export}"
                   onclick="doAction.value='doExport'" />
            {*
                <input type="button" name="cancel" value="{$labels.btn_cancel}"
                    onclick="javascript: location.href='{$req_spec_view_url}{$gui->req_spec_id}';" />
            *}
            <input class="btn btn-secondary" type="button" name="cancel" value="{$labels.btn_cancel}"
                   onclick="location.href='{$cancelUrl}';" />

        </div>
    </fieldset>

      

</form>

</div>

</body>
</html>