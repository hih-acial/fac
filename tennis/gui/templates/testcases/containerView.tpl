{* 
TestLink Open Source Project - http://testlink.sourceforge.net/

View test specification containers

@filesource containerView.tpl
@internal revisions
@since 1.9.12
*}

{lang_get var='labels' 
          s='th_product_name,edit_testproject_basic_data,th_notes,test_suite,details,none,
             keywords,alt_del_testsuite, alt_edit_testsuite, alt_move_cp_testcases, alt_move_cp_testsuite, 
             btn_new_testsuite, btn_reorder,btn_execute_automatic_testcases,
             btn_edit_testsuite,btn_del_testsuite,btn_move_cp_testsuite,btn_testcases_table_view,
             btn_del_testsuites_bulk,btn_delete_testcases,btn_reorder_testcases_alpha,
             btn_reorder_testcases_externalid,btn_reorder_testsuites_alpha,actions,
             btn_gen_test_spec,btn_gen_test_spec_new_window,
             btn_gen_test_spec_word,btn_gen_test_suite_spec_word,
             btn_gen_test_suite_spec,btn_gen_test_suite_spec_new_window,
             btn_export_testsuite, btn_export_all_testsuites, btn_import_testsuite, 
             btn_new_tc,btn_move_cp_testcases, btn_import_tc, btn_export_tc, th_testplan_name,
             testsuite_operations, testcase_operations,btn_create_from_issue_xml'}

{$ft=''}
{if isset($gui->form_token)}
  {$ft=$gui->form_token}
{/if}

{$container_id = $gui->container_data.id}
{$tproject_id = $gui->tproject_id}

{$tcImportAction="lib/testcases/tcImport.php?containerID=$container_id"}
{$importToTProjectAction="$basehref$tcImportAction&amp;bIntoProject=1&amp;useRecursion=1&amp;"}
{$importToTSuiteAction="$basehref$tcImportAction&amp;useRecursion=1"}
{$importTestCasesAction="$basehref$tcImportAction"}
{$tcExportAction="lib/testcases/tcExport.php?tproject_id=$tproject_id&containerID=$container_id&amp;form_token=$ft"}
{$exportTestCasesAction="$basehref$tcExportAction"}

{$testSpecFullDocAction="lib/results/printDocument.php?type=testspec&level=testproject&allOptionsOn=1&format=0&id=$container_id&form_token=$ft"}
{$testSpecFullDocAction="$basehref$testSpecFullDocAction"}

{$testSpecFullWordDocAction="lib/results/printDocument.php?type=testspec&level=testproject&allOptionsOn=1&format=4&id=$container_id"}
{$testSpecFullWordDocAction="$basehref$testSpecFullWordDocAction"}

{$testSuiteDocAction="lib/results/printDocument.php?type=testspec&level=testsuite&allOptionsOn=1&format=0&id=$container_id&form_token=$ft"}
{$testSuiteDocAction="$basehref$testSuiteDocAction"}

{$testSuiteWordDocAction="lib/results/printDocument.php?type=testspec&level=testsuite&allOptionsOn=1&format=4&id=$container_id"}
{$testSuiteWordDocAction="$basehref$testSuiteWordDocAction"}


{$tsuiteExportAction="$basehref$tcExportAction&amp;useRecursion=1&amp;form_token=$ft"}

{$tcMantisXMLAction="lib/testcases/tcCreateFromIssueMantisXML.php?containerID=$container_id"}
{$createTCFromIssueMantisXMLAction="$basehref$tcMantisXMLAction"}


{include file="inc_head.tpl" openHead="yes"}
{$ext_location=$smarty.const.TL_EXTJS_RELATIVE_PATH}
<link rel="stylesheet" type="text/css" href="{$basehref}{$ext_location}/css/ext-all.css" />

{include file="inc_del_onclick.tpl" openHead="yes"}
{include file="../custom.tpl"}
<script type="text/javascript">
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
<section class="jumbotron">
  <h2 class="text-center">{$gui->page_title}{$tlCfg->gui_title_separator_1}{$gui->container_data.name|escape}</h2>
</section>
<div class="container">
{include file="inc_update.tpl" result=$gui->sqlResult item=$gui->level
         name=$gui->moddedItem.name refresh=$gui->refreshTree user_feedback=$gui->user_feedback}

{$bDownloadOnly=true}
{$drawReorderButton=true}
{$drawReorderButton=false}

{if $gui->level == 'testproject'}

  {if $gui->modify_tc_rights == 'yes'}
    {$bDownloadOnly=false}

    <div id="tproject_control_panel" style="">


        <form method="post" action="lib/testcases/containerEdit.php">
          <fieldset class="text-center center-block">
            <h3>{$labels.testsuite_operations}</h3>
            <hr>
              <input type="hidden" name="treeFormToken" id="treeFormToken" value="{$ft}" />
              <input type="hidden" name="doAction" id="doAction" value="" />
              <input type="hidden" name="containerID" value="{$gui->container_data.id}" />
              <input type="hidden" name="containerType" id="containerType" value="{$gui->level}" />

          <input type="submit" class="btn btn-success" value="Créer" name="new_testsuite" id="new_testsuite" onclick="doAction.value='new_testsuite'" title="Créer">

          <input type="submit" class="btn btn-warning" value="Trier" name="reorder_testproject_testsuites_alpha" id="reorder_testproject_testsuites_alpha" onclick="doAction.value='reorder_testproject_testsuites_alpha'" title="Trier par ordre alphabétique">

          <a href="javascript:location='{$importToTProjectAction}'" class="btn btn-info"  title="Importer">Importer</a>
      {if $gui->canDoExport}
          <a href="javascript:location='{$tsuiteExportAction}'" class="btn btn-secondary" title="Exporter tous les dossiers de tests">Exporter</a>
      {/if}
          <a href="javascript:window.open('{$testSpecFullDocAction}')" class="btn btn-primary" title="Document de spécification de test (HTML) dans une nouvelle fenêtre">Ouvrir dans une nouvelle fenêtre</a>

          <a href="javascript:window.open('{$testSpecFullWordDocAction}')" class="btn btn-outline-dark" title="Télécharger le document de spécification de test (Pseudo Word)">Télécharger le document</a>
          </fieldset>
        </form>
    </div>
    <hr>
  {/if}

    <br>
    <h3 class="text-center">Propriétés du dossier</h3>
    <hr>
  <table class="table table-hover">
      <thead class="thead-dark">
      <tr>
          <th>Propriété</th>
          <th>Info</th>
      </tr>
      </thead>
      <tbody>
      <tr>
          <td>{$labels.th_product_name}</td>
          <td>
              {if $gui->mgt_modify_product == 'yes'}
                  <a href="lib/project/projectView.php"  target="mainframe"
                     title="{$labels.edit_testproject_basic_data}">{$gui->container_data.name|escape}</a>
              {else}
                  {$gui->container_data.name|escape}
              {/if}
          </td>
      </tr>
      <tr>
          <td>{$labels.th_notes}</td>
          <td>{if $gui->testProjectEditorType == 'none'}{$gui->container_data.notes|nl2br}{else}{$gui->container_data.notes}{/if}</td>
      </tr>
      </tbody>
  </table>

{elseif $gui->level == 'testsuite'}

  {if $gui->modify_tc_rights == 'yes' || $gui->sqlResult neq ''}
      {$tlImages.toggle_direct_link} &nbsp;
      <div class="direct_link" style='display:none'><a href="{$gui->direct_link}" target="_blank">{$gui->direct_link}</a></div>

      <div id="container">


              <form method="post" action="{$basehref}lib/testcases/containerEdit.php">
                  <fieldset class="text-center center-block">
                      <h3>{$labels.testsuite_operations}</h3>
                      <hr>
                  <input type="hidden" name="form_token" id="form_token" value="{$gui->form_token}" />
                  <input type="hidden" name="doAction" id="doAction" value="" />
                  <input type="hidden" name="containerID" value="{$gui->container_data.id}" />
                  <input type="hidden" name="testsuiteID" value="{$gui->container_data.id}" />
                  <input type="hidden" name="testsuiteName" value="{$gui->container_data.name|escape}" />
                  <input type="hidden" name="containerType" value="{$gui->containerType}" />

                  <input type="submit" name="new_testsuite" id="new_testsuite" class="btn btn-success" value="{$labels.btn_new_testsuite}"
                         onclick="doAction.value='new_testsuite'" title="{$labels.btn_new_testsuite}">

                  <input type="submit" src="{$tlImages.edit}" name="edit_testsuite" id="edit_testsuite" class="btn btn-warning" value="{$labels.btn_edit_testsuite}"
                         onclick="doAction.value='edit_testsuite'" title="{$labels.btn_edit_testsuite}">

                  <input type="submit" class="btn btn-info" name="move_testsuite_viewer" value="{$labels.alt_move_cp_testsuite}" id="move_testsuite_viewer"
                         onclick="doAction.value='move_testsuite_viewer'" title="{$labels.alt_move_cp_testsuite}">

                  <input type="submit" class="btn btn-danger" name="delete_testsuite" id="delete_testsuite" value="Supprimer tout"
                         onclick="doAction.value='delete_testsuite'" title="{$labels.alt_del_testsuite}">

                  <input type="submit" class="btn btn-secondary" value="Trier"  name="reorder_testsuites_alpha" id="reorder_testsuites_alpha"
                         onclick="doAction.value='reorder_testsuites_alpha'" title="{$labels.btn_reorder_testsuites_alpha}">

                  <input type="submit" class="btn btn-primary" value="{$labels.btn_testcases_table_view}" name="testcases_table_view" id="testcases_table_view"
                         onclick="doAction.value='testcases_table_view'" title="{$labels.btn_testcases_table_view}">
                      <br><br>
                  <a href="javascript:window.open('{$testSuiteDocAction}')" class="btn btn-outline-dark"
                     title="{$labels.btn_gen_test_suite_spec_new_window}" >Ouvrir dans une nouvelle fenêtre</a>

                  <a href="javascript:window.open('{$testSuiteWordDocAction}')" class="btn btn-light"
                     title="{$labels.btn_gen_test_suite_spec_word}" >{$labels.btn_gen_test_suite_spec_word}</a>

                      <a href="javascript:location='{$importToTSuiteAction}'"  title="{$labels.btn_import_testsuite}" class="btn btn-outline-secondary" >{$labels.btn_import_testsuite}</a>
                      <a href="javascript:location='{$tsuiteExportAction}'"  title="{$labels.btn_export_testsuite}" class="btn btn-outline-primary" >{$labels.btn_export_testsuite}</a>
                  </fieldset>
              </form>
          <hr>

          {* ----- Work with test cases ----------------------------------------------- *}


              <form method="post" action="{$basehref}lib/testcases/tcEdit.php">
                  <fieldset class="text-center center-block">
                      <h3>{$labels.testcase_operations}</h3>
                      <hr>
                  <input type="hidden" name="form_token" id="form_token" value="{$gui->form_token}" />
                  <input type="hidden" name="doAction" id="doAction" value="" />
                  <input type="hidden" name="containerID" value="{$gui->container_data.id}" />
                  <input type="submit"  name="create_tc" id="create_tc" class="btn btn-outline-success" value="{$labels.btn_new_tc}"
                         onclick="doAction.value='create'" title="{$labels.btn_new_tc}">
                  </fieldset>
              </form>
          <br>
              <form method="post" action="{$basehref}lib/testcases/containerEdit.php">
                  <fieldset class="text-center center-block">
                  <input type="hidden" name="form_token" id="form_token" value="{$gui->form_token}" />
                  <input type="hidden" name="doAction" id="doAction" value="" />
                  <input type="hidden" name="testsuiteID" value="{$gui->container_data.id}" />
                  <input type="hidden" name="testsuiteName" value="{$gui->container_data.name|escape}" />

                  <input type="submit" class="btn btn-outline-dark" value="{$labels.alt_move_cp_testcases}" name="move_testcases_viewer" id="move_testcases_viewer"
                         onclick="doAction.value='move_testcases_viewer'" title="{$labels.alt_move_cp_testcases}">

                  <input type="submit" class="btn btn-outline-danger" value="{$labels.btn_delete_testcases}" name="delete_testcases" id="delete_testcases"
                         onclick="doAction.value='delete_testcases'" title="{$labels.btn_delete_testcases}">

                  <input type="submit" class="btn btn-outline-info" value="{$gui->btn_reorder_testcases}" name="reorder_testcases" id="reorder_testcases"
                         onclick="doAction.value='reorder_testcases'" title="{$gui->btn_reorder_testcases}">
                  </fieldset>
              </form>
          <br>
              <form method="post" action="{$basehref}lib/testcases/tcEdit.php">
                  <fieldset class="text-center center-block">
                  <input type="hidden" name="form_token" id="form_token" value="{$gui->form_token}" />
                  <input type="hidden" name="doAction" id="doAction" value="" />
                      <a href="javascript:location='{$importTestCasesAction}'" class="btn btn-outline-secondary" title="{$labels.btn_import_tc}" >{$labels.btn_import_tc}</a>
                      <a href="javascript:location='{$exportTestCasesAction}'" class="btn btn-outline-primary" title="{$labels.btn_export_tc}" >{$labels.btn_export_tc}</a>
                  <a href="javascript:location='{$createTCFromIssueMantisXMLAction}'" class="btn btn-outline-warning" title="{$labels.btn_create_from_issue_xml}" >{$labels.btn_create_from_issue_xml}</a>
                  </fieldset>
              </form>


      </div>
      <hr >

  {/if}
  
  {* ----- show Test Suite data --------------------------------------------- *}
    {$kwView = $gsmarty_href_keywordsView|replace:'%s%':$gui->tproject_id}
<div class="jumbotron">
    <h3>Table des données de la fiche</h3>
    <hr>
    <table class="table">
        <thead class="thead-dark">
        <tr>
            <th>Propriété</th>
            <th>Info</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>{$labels.test_suite}</td>
            <td>{$gui->container_data.name|escape}</td>
        </tr>
        <tr>
            <td>{$labels.details}</td>
            <td>{if $gui->testDesignEditorType == 'none'}{$gui->container_data.details|nl2br}{else}{$gui->container_data.details}{/if}</td>
        </tr>
        <tr>
            <td><a href={$kwView}>{$labels.keywords}</a></td>
            <td>{foreach item=keyword_item from=$gui->keywords_map}
                    {$keyword_item|escape}<br />
                    {foreachelse}
                    {$labels.none}
                {/foreach}</td>
        </tr>
        </tbody>

        {* ------ custom fields ------------------------------------- *}
        <tr>
            <td colspan="2">
                {$gui->cf}
            </td>
        </tr>

    </table>
</div>

    {if $gui->modify_tc_rights eq 'yes'}
    {$bDownloadOnly=false}
  {/if}
{/if} {* test suite *}

{include file="attachments.inc.tpl" 
         attach_attachmentInfos=$gui->attachmentInfos
         attach_id=$gui->id attach_tableName="nodes_hierarchy" 
         attach_downloadOnly=$bDownloadOnly}

</div>
{if $gui->refreshTree}
  {include file="inc_refreshTreeWithFilters.tpl"}
{/if}
</body>
</html>