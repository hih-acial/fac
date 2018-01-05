{* 
TestLink Open Source Project - http://testlink.sourceforge.net/ 
$Id: cfieldsImport.tpl,v 1.3 2010/11/06 11:42:47 amkhullar Exp $
Purpose: smarty template - manage import of custom fields

rev: 
*}

{lang_get var="labels"
          s='file_type,view_file_format_doc,local_file,warning,warning_empty_filename,
             max_size_cvs_file1,max_size_cvs_file2,btn_upload_file,
             btn_goback,not_imported,imported,btn_cancel,title_imp_tc_data'}

{assign var="cfg_section" value=$smarty.template|basename|replace:".tpl":"" }
{config_load file="input_dimensions.conf" section=$cfg_section}

{include file="inc_head.tpl" openHead="yes" jsValidate="yes"}
{include file="inc_del_onclick.tpl"}
{include file="../custom.tpl"}
{literal}
<script type="text/javascript">
{/literal}
// BUGID 3943: Escape all messages (string)
var alert_box_title = "{$labels.warning|escape:'javascript'}";
var warning_empty_filename = "{$labels.warning_empty_filename|escape:'javascript'}";
{literal}
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
{/literal}
</head>


<body>

		<div class="container-fluid">
			<h1 class="title text-center">{$gui->page_title|escape}</h1>

			<section class="container container-fluid well">
                {if $gui->file_check.show_results}
                    {if $gui->file_check.import_msg.ok != ''}
                        {$labels.imported}<br>
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
						<br>
						<input class="btn btn-primary" type="button" name="goback" value="{$labels.btn_goback}"
                                {if $gui->goback_url != ''}  onclick="location='{$gui->goback_url}'"
                                {else}  onclick="history.back();" {/if} />
					</form>

                {else}
					<form method="post" enctype="multipart/form-data" action="{$SCRIPT_NAME}"
						  onSubmit="return validateForm(this);">

						<div class="form-group">
							<label class="col-lg-2 control-label" for="importType">{$labels.file_type}</label>
							<div class="col-lg-8">
								<select class="form-control" id="importType" name="importType">
                                    {html_options options=$gui->importTypes}
								</select>
							</div>
							<div class="col-lg-2">
								<a href={$basehref}{$smarty.const.PARTIAL_URL_TL_FILE_FORMATS_DOCUMENT}>{$labels.view_file_format_doc}</a>
							</div>
						</div>

						<div class="form-group">
							<label class="col-lg-2 control-label" for="targetFilename">{$labels.local_file}</label>
							<div class="col-lg-10">
								<input class="btn btn-primary" type="file" id="targetFilename" name="targetFilename"
									   size="{#FILENAME_SIZE#}" maxlength="{#FILENAME_MAXLEN#}"/>
								<p class="text-danger">{$labels.max_size_cvs_file1} {$gui->importLimitKB} {$labels.max_size_cvs_file2}</p>
							</div>

						</div>

						<div class="groupBtn col-md-offset-4 col-lg-offset-4">
							<input type="hidden" name="doAction" id="doAction" value="doImport" />
                            {* restrict file size - input name must be UPPER CASE ??? *}
							<input type="hidden" name="MAX_FILE_SIZE" value="{$gui->importLimitKB}" />
							<input class="btn btn-primary" type="submit" name="UploadFile" value="{$labels.btn_upload_file}" />
							<input class="btn btn-default" type="button" name="cancel" value="{$labels.btn_cancel}"
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


			</section>
		</div>




</body>
</html>