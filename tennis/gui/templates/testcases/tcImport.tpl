{*
TestLink Open Source Project - http://testlink.sourceforge.net/
@filesource tcImport.tpl
Purpose: smarty template - manage import of test cases and test suites

*}

{lang_get var="labels"
          s='file_type,view_file_format_doc,local_file,
             max_size_cvs_file1,max_size_cvs_file2,btn_upload_file,
             duplicate_criteria,action_for_duplicates,testcase,
             action_on_duplicated_name,warning,btn_cancel,title_imp_tc_data'}

{$cfg_section=$smarty.template|basename|replace:".tpl":""}
{config_load file="input_dimensions.conf" section=$cfg_section}

{include file="inc_head.tpl" openHead="yes"}
{include file="inc_del_onclick.tpl"}
{include file="../custom.tpl"}
</head>
<body>
<section class="jumbotron">
	<h2 class="text-center">{$gui->container_description}{$smarty.const.TITLE_SEP}{$gui->container_name|escape}</h2>
</section>

<div class="container">

<h1 class="text-center">{$gui->import_title}</h1>
	<hr>
{if $gui->resultMap eq null}
<form method="post" enctype="multipart/form-data" action="{$SCRIPT_NAME}">
	<fieldset>
        <div class="form-group">
            <label for="{$labels.file_type}">{$labels.file_type}</label>
            <select class="form-control" id="{$labels.file_type}" name="importType">
                {html_options options=$gui->importTypes}
            </select>
            <a href={$basehref}{$smarty.const.PARTIAL_URL_TL_FILE_FORMATS_DOCUMENT}>{$labels.view_file_format_doc}</a>
        </div>
        <div class="form-group">
            <label for="{$labels.local_file}">{$labels.local_file}</label>
            <input id="{$labels.local_file}" type="file" name="uploadedFile" size="{#FILENAME_SIZE#}" maxlength="{#FILENAME_MAXLEN#}"/>
            <p>{$labels.max_size_cvs_file1} {$gui->importLimitKB|escape} {$labels.max_size_cvs_file2}</p>
        </div>
        {if $gui->hitOptions != ''}
        <div class="form-group">
            <label for="hit_criteria">{$labels.duplicate_criteria}</label>
            <select class="form-control" name="hit_criteria" id="hit_criteria">
                {html_options options=$gui->hitOptions selected=$gui->hitCriteria}
            </select>
        </div>
        {/if}
        {if $gui->actionOptions != ''}
            <div class="form-group">
                <label for="{$labels.action_for_duplicates}">{$labels.action_for_duplicates}</label>
                <select class="form-control" id="{$labels.action_for_duplicates}" name="action_on_duplicated_name">
                    {html_options options=$gui->actionOptions selected=$gui->action_on_duplicated_name}
                </select>
            </div>
        {/if}

	<div class="text-center center-block">
		<input type="hidden" name="useRecursion" value="{$gui->useRecursion|escape}" />
		<input type="hidden" name="bIntoProject" value="{$gui->bIntoProject|escape}" />
		<input type="hidden" name="containerID" value="{$gui->containerID|escape}" />
		<input type="hidden" name="MAX_FILE_SIZE" value="{$gui->importLimitBytes|escape}" /> {* restrict file size *}
		<input class="btn btn-primary" type="submit" name="UploadFile" value="{$labels.btn_upload_file}" />
		<input class="btn btn-secondary" type="button" name="cancel" value="{$labels.btn_cancel}"
			                   onclick="history.back();" />
	</div>
	</fieldset>
</form>
{else}
  {foreach item=result from=$gui->resultMap}
    {$labels.testcase} : <b>{$result[0]|escape}</b> : {$result[1]|escape}<br>
  {/foreach}

  {include file="inc_refreshTree.tpl"}
{/if}

{if $gui->bImport > 0}
	{include file="inc_refreshTree.tpl"}
{/if}

{if $gui->file_check.status_ok eq 0}
  <script type="text/javascript">
  alert_message("{$labels.warning|escape:'javascript'}","{$gui->file_check.msg|escape:'javascript'}");
  </script>
{/if}


</div>

</body>
</html>