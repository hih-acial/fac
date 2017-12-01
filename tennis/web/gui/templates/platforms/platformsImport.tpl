{* 
TestLink Open Source Project - http://testlink.sourceforge.net/ 
@filesource platformsImport.tpl
Purpose: smarty template - manage import of platforms

@internal revisions
@since 1.9.11

*}

{lang_get var="labels"
          s='file_type,view_file_format_doc,local_file,warning,
             max_size_cvs_file1,max_size_cvs_file2,btn_upload_file,
             btn_goback,not_imported,warning_empty_filename,imported,btn_cancel'}

{$cfg_section=$smarty.template|basename|replace:".tpl":"" }
{config_load file="input_dimensions.conf" section=$cfg_section}

{include file="inc_head.tpl" openHead="yes" jsValidate="yes"}
{include file="inc_del_onclick.tpl"}
{include file="custom.tpl"}
<script type="text/javascript">
var alert_box_title = "{$labels.warning|escape:'javascript'}";
var warning_empty_filename = "{$labels.warning_empty_filename|escape:'javascript'}";

/**
 * when using HTML5 compatible browser this may be is useless
 */
function validateForm(f)
{
  if (isWhitespace(f.targetFilename.value)) 
  {
    alert_message(alert_box_title,warning_empty_filename);
    selectField(f, 'targetFilename');
    return false;
  }
  return true;
}
</script>
</head>

<body>
<section class="jumbotron">
    <h2 class="text-center">{$gui->page_title|escape}</h2>
</section>
<div class="container">
{if $gui->file_check.show_results}
    {if $gui->file_check.import_msg.ok != ''}
        {$labels.imported}: {$gui->file_check.import_msg.ok|@count}<br>
        {foreach item=result from=$gui->file_check.import_msg.ok}
          <b>{$result|escape}</b><br />
        {/foreach}
    {/if} 
    <br>
    {if $gui->file_check.import_msg.ko != ''}
        {$labels.not_imported}<br>
        {foreach item=result from=$gui->file_check.import_msg.ko}
          <b>{$result|escape}</b><br />
        {/foreach}
    {/if} 
    <form method="post" action="{$SCRIPT_NAME}">
      <br />
        <input class="btn btn-success" type="button" name="goback" value="{$labels.btn_goback}"
          {if $gui->goback_url != ''}  onclick="location='{$gui->goback_url}'"
            {else} onclick="history.back();" {/if} />
    </form>
{else}
  <form method="post" enctype="multipart/form-data" action="{$SCRIPT_NAME}"
        onsubmit="return validateForm(this);">
      <fieldset>
          <legend>
              <h3>Formulaire d'importation de plateformes</h3>
          </legend>
      </fieldset>
      <div class="form-group">
          <label for="{$labels.file_type}">{$labels.file_type}</label>
          <select class="form-control" id="{$labels.file_type}" name="importType">
              {html_options options=$gui->importTypes}
          </select>
          <a href="{$basehref}{$smarty.const.PARTIAL_URL_TL_FILE_FORMATS_DOCUMENT}">{$labels.view_file_format_doc}</a>
      </div>
      <div class="form-group">
          <label for="{$labels.local_file}">{$labels.local_file}</label>
          <input type="hidden" name="MAX_FILE_SIZE" value="{$gui->importLimitBytes}" />
          <input id="{$labels.local_file}" type="file" name="targetFilename" value="" size="{#FILENAME_SIZE#}" maxlength="{#FILENAME_MAXLEN#}"/>
          <p class="text-danger">{$gui->max_size_import_file_msg}</p>
      </div>


      <div class="center-block text-center">
        <input type="hidden" name="doAction" id="doAction" value="doImport" />
        <input type="hidden" name="goback_url" value="{ $gui->goback_url|escape}" />
        <input class="btn btn-success" type="submit" name="UploadFile" value="{$labels.btn_upload_file}" />
        <input class="btn btn-secondary" type="button" name="cancel" value="{$labels.btn_cancel}"
                             {if $gui->goback_url != ''}  onclick="location='{$gui->goback_url}'"
                             {else}  onclick="javascript:history.back();" {/if} />
      </div>
    </form> 
{/if}

{if $gui->file_check.status_ok eq 0}
<script>
alert_message(alert_box_title,"{$gui->file_check.msg|escape:'javascript'}");
</script>
{/if}  
</div>
</body>
</html>