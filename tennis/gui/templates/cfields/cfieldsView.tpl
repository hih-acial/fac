{* 
TestLink Open Source Project - http://testlink.sourceforge.net/
@filesource cfieldsView.tpl

@internal revisions
*}
{$cfg_section=$smarty.template|basename|replace:".tpl":""}
{config_load file="input_dimensions.conf" section=$cfg_section}

{$cfViewAction="lib/cfields/cfieldsView.php"}

{$cfImportAction="lib/cfields/cfieldsImport.php?goback_url="}
{$importCfieldsAction="$basehref$cfImportAction$basehref$cfViewAction"}

{$cfExportAction="lib/cfields/cfieldsExport.php?goback_url="}
{$exportCfieldsAction="$basehref$cfExportAction$basehref$cfViewAction"}


{lang_get var="labels"
          s='name,label,type,title_cfields_mgmt,manage_cfield,btn_cfields_create,
             btn_export,btn_import,btn_goback,sort_table_by_column,enabled_on_context,
             display_on_exec,available_on'}

{include file="inc_head.tpl" popup="yes" openHead="yes"}
{include file="../custom.tpl"}
<body>

        <div class="container-fluid">
            <h1 class="title text-center">{$labels.title_cfields_mgmt}</h1>

            <div class="workBack">

                {if $gui->cf_map != '' }
                    <section class="well container container-fluid">
                        <div class="container">
                            <div class="col-lg-offset-5">
                                <span style="float: left">
                                    <form method="post" action="lib/cfields/cfieldsEdit.php?do_action=create">
                                      <input class="btn btn-success" type="submit" name="create_cfield" value="{$labels.btn_cfields_create}" />
                                    </form>
                                </span>
                            </div>
                            <span>
	  <form method="post" action="{$exportCfieldsAction}" name="cfieldsExport">
		  <input class="btn btn-warning" type="submit" name="export_cf" id="export_cf"
                 style="margin-left: 3px;" value="{$labels.btn_export}" />

		  <input class="btn btn-primary" type="button" name="import_cf" id="import_cf"
                 onclick="location='{$importCfieldsAction}'" value="{$labels.btn_import}" />

	  </form>
	  </span>
                        </div>
                    </section>
                    <section class="container container-fluid">
                        <h2 class="text-center">Table des champes personnalisés</h2>
                        <hr>
                        <table id='item_view' class="table teble-striped table-hover table-responsive">
                            <thead class="thead-dark">
                            <tr>
                                <th>{$tlImages.sort_hint}{$labels.name}</th>
                                <th>{$tlImages.sort_hint}{$labels.label}</th>
                                <th>{$tlImages.sort_hint}{$labels.type}</th>
                                <th class="{$noSortableColumnClass}">{$labels.enabled_on_context}</th>
                                <th class="{$noSortableColumnClass}">{$labels.display_on_exec}</th>
                                <th>{$tlImages.sort_hint}{$labels.available_on}</th>
                            </tr>
                            </thead>
                            <tbody>

                            {foreach key=cf_id item=cf_def from=$gui->cf_map}
                                <tr>
                                    <td width="20%" class="bold"><a href="lib/cfields/cfieldsEdit.php?do_action=edit&cfield_id={$cf_def.id}"
                                                                    title="{$labels.manage_cfield}">{$cf_def.name|escape}</a></td>
                                    <td >{$cf_def.label|escape}</td>
                                    <td width="5%">{$gui->cf_types[$cf_def.type]}</td>
                                    <td width="10%">{$cf_def.enabled_on_context}</td>
                                    <td align="center" width="5%">{if $cf_def.show_on_execution}<img src="{$tlImages.checked}">{/if} </td>
                                    <td width="10%">{lang_get s=$cf_def.node_description}</td>

                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                    </section>

                {else}
                    <section class="well">
                        <div class="container">
                            <div class="col-lg-offset-5">
    <span style="float: left">
    <form method="post" action="lib/cfields/cfieldsEdit.php?do_action=create">
      <input class="btn btn-success" type="submit" name="create_cfield" value="{$labels.btn_cfields_create}" />
    </form>
    </span>
                            </div>
                            <span>
	  <form method="post" action="{$exportCfieldsAction}" name="cfieldsExport">
		  <input class="btn btn-warning" type="submit" name="export_cf" id="export_cf"
                 style="margin-left: 3px;" value="{$labels.btn_export}" />

		  <input class="btn btn-primary" type="button" name="import_cf" id="import_cf"
                 onclick="location='{$importCfieldsAction}'" value="{$labels.btn_import}" />

	  </form>
	  </span>
                        </div>
                    </section>
                    <h1 class="text-center" style="color: darkgrey">Aucun champ personnalisé n'est défini ! </h1>
                {/if} {* $cf_map != '' *}
            </div>
        </div>




</body>
</html>