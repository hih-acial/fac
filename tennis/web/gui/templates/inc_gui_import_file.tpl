{* 
Testlink Open Source Project - http://testlink.sourceforge.net/ 
$Id: inc_gui_import_file.tpl,v 1.2 2010/09/19 17:39:40 franciscom Exp $

rev :
*}
{lang_get var="local_labels" 
          s='file_type,view_file_format_doc,local_file,btn_cancel,btn_upload_file,
             action_for_duplicates,skip_frozen_req'
}
<div class="form-group">
    <label for="{$local_labels.file_type}">{$local_labels.file_type}</label>
    <select class="form-control" id="{$local_labels.file_type}" name="importType">
        {html_options options=$args->importTypes}
    </select>
    <a href={$basehref}{$smarty.const.PARTIAL_URL_TL_FILE_FORMATS_DOCUMENT}>{$local_labels.view_file_format_doc}</a>
</div>
<div class="form-group">
    <label for="exampleInputFile">{$local_labels.local_file}</label>
    <input type="file" name="uploadedFile" size="{#FILENAME_SIZE#}"
           maxlength="{#FILENAME_MAXLEN#}" class="form-control-file" id="exampleInputFile" aria-describedby="fileHelp">
</div>
<div class="checkbox">
    <label>
        <input type="checkbox" class="form-check-input" name="skip_frozen_req" {$args->skip_frozen_req_checked}>
        {$local_labels.skip_frozen_req}
    </label>
</div>
{if $gui->hitOptions != ''}
    <label for="hitCriteria">{$gui->duplicate_criteria_verbose}</label>
    <select class="form-control" name="hitCriteria" id="hitCriteria">
        {html_options options=$gui->hitOptions selected=$gui->hitCriteria}
    </select>
{/if}
{if $gui->actionOptions != ''}
    <label for="actionOnHit">{$local_labels.action_for_duplicates}</label>
    <select class="form-control" id="actionOnHit" name="actionOnHit">
        {html_options options=$gui->actionOptions selected=$gui->actionOnHit}
    </select>
{/if}
<small>{$args->fileSizeLimitMsg}</small>
<div class="text-center">
	<input type="hidden" name="MAX_FILE_SIZE" value="{$args->maxFileSize}" /> {* restrict file size How ?*}
	<input class="btn btn-success" type="submit" name="uploadFile" value="{$local_labels.btn_upload_file}" />
	<input class="btn btn-secondary" type="button" name="cancel" value="{$local_labels.btn_cancel}"
		     onclick="location.href='{$args->return_to_url}';" />
</div>

