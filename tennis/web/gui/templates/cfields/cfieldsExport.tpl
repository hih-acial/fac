{* 
TestLink Open Source Project - http://testlink.sourceforge.net/ 
$Id: cfieldsExport.tpl,v 1.4 2010/11/06 11:42:47 amkhullar Exp $ 
Purpose: smarty template - custom fields export
rev:
  20100315 - franciscom - improvement on goback management
*}
{assign var="cfg_section" value=$smarty.template|basename|replace:".tpl":"" }
{config_load file="input_dimensions.conf" section=$cfg_section}
{include file="inc_head.tpl" openHead="yes" jsValidate="yes"}
{include file="inc_del_onclick.tpl"}

{lang_get var="labels" 
          s='btn_export,btn_cancel,warning,export_filename,file_type,
             view_file_format_doc,export_with_keywords,warning_empty_filename'}
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
<div id="wrapper" class="toggled">
    <!-- Sidebar -->
    <div id="sidebar-wrapper">
        <ul class="sidebar-nav">
            <li><a href="lib/general/frmWorkArea.php?feature=reqSpecMgmt"> Exigences</a></li>
            <li><a href="lib/general/frmWorkArea.php?feature=editTc"> Test</a></li>
            <li><a href="lib/general/frmWorkArea.php?feature=executeTest"> Exécution</a></li>
        </ul>

    </div>
    <!-- /#sidebar-wrapper -->
    <a href="#menu-toggle" class="btn btn-dark" id="menu-toggle"><i class="glyphicon glyphicon-list"></i>Menu</a>


    <!-- Page Content -->
    <div id="page-content-wrapper">
        <div class="container-fluid">
            <h1 class="title text-center">{$gui->page_title|escape}</h1>
            <section class="container container-fluid well">
                {if $gui->do_it eq 1}
                    <form method="post" id="export_xml" enctype="multipart/form-data"
                          action="lib/cfields/cfieldsExport.php"
                          onSubmit="return validateForm(this);">

                        <div class="form-group">
                            <label class="col-lg-2 control-label" for="export_filename">{$labels.export_filename}</label>
                            <div class="col-lg-10">
                                <input type="text" class="form-control" id="export_filename" name="export_filename" maxlength="{#FILENAME_MAXLEN#}"
                                       value="{$gui->export_filename|escape}" size="{#FILENAME_SIZE#}"/>
                                {include file="error_icon.tpl" field="export_filename"}
                                {include file="error_icon.tpl" field="cf_name"}
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label" for="exportType">{$labels.file_type}</label>
                            <div  class="col-lg-8">
                                <select class="form-control" id="exportType" name="exportType">
                                    {html_options options=$gui->exportTypes}
                                </select>
                            </div>
                            <a class="col-lg-2" href={$basehref}{$smarty.const.PARTIAL_URL_TL_FILE_FORMATS_DOCUMENT}>{$labels.view_file_format_doc}</a>
                        </div>
                        <br>
                        <div class="groupBtn col-md-offset-4 col-md-offset-4">
                            <input type="hidden" name="doAction" id="doAction" value="" />
                            <input class="btn btn-primary" type="submit" name="doExport" id="doExport" value="{$labels.btn_export}"
                                   onclick="doAction.value=this.id" />
                            <input class="btn btn-default" type="button" name="cancel" value="{$labels.btn_cancel}"
                                    {if $gui->goback_url != ''}  onclick="location='{$gui->goback_url}'"
                                    {else}  onclick="javascript:history.back();" {/if} />


                        </div>
                    </form>
                {else}
                    {$gui->nothing_todo_msg|escape}
                {/if}

            </section>
        </div>
    </div>
    <!-- /#page-content-wrapper -->

</div>

<script>
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
</script>


</body>
</html>
