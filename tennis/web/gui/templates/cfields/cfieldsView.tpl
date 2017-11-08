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
<div id="wrapper" class="toggled">
    <!-- Sidebar -->
    <div id="sidebar-wrapper">
        <ul class="sidebar-nav">
            <li class="sidebar-brand">
                <a href="index.php" target="_parent">
                    TESTLINK V.3.0
                </a>
            </li>
            <li>
                <a data-toggle="collapse" data-parent="#accordion" href="#collapse" style="font-size: large" aria-expanded="false" class="collapsed">Espace campagne</a>
                <ul id="collapse" class="panel-collapse collapse" style="display: none;">

                    <li>
                        <a href="lib/plan/planView.php">Gestion des campagnes de test</a>
                    </li>

                    <li>
                        <a href="lib/plan/buildView.php?tplan_id=2">Gestion des versions du produit</a>

                    </li>
                    <li>
                        <a href="lib/plan/planMilestonesView.php">Gestion des indicateurs d'avancement</a>
                    </li>
                    <li>
                        <a href="lib/general/frmWorkArea.php?feature=reqSpecMgmt">Gestion des exigences</a>
                    </li>
                    <li>
                        <a href="lib/requirements/reqOverview.php">Récapitulatif d’exigences</a>
                    </li>
                    <li>
                        <a href="lib/general/frmWorkArea.php?feature=searchReq">Recherche d’exigences</a>
                    </li>
                    <li>
                        <a href="lib/general/frmWorkArea.php?feature=searchReqSpec">Recherche de dossier d’exigences</a>
                    </li>
                    <li>
                        <a href="lib/general/frmWorkArea.php?feature=assignReqs" style="">Lier/Délier exigences et fiches de test</a>
                    </li>

                    <li>
                        <a href="lib/requirements/reqMonitorOverview.php?tproject_id=1">Surveillance d’exigences</a>
                    </li>
                    <li>
                        <a href="lib/general/frmWorkArea.php?feature=printReqSpec">Génération du cahier d’exigences</a>
                    </li>
                </ul>
            </li>
            <li>
                <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" style="font-size: large" aria-expanded="false" class="collapsed">Espace test</a>
                <ul id="collapseTwo" class="panel-collapse collapse" style="display: none;">
                    <li>
                        <a href="lib/general/frmWorkArea.php?feature=planAddTC">Ajout de fiches de test</a>
                    </li>

                    <li>
                        <a href="lib/general/frmWorkArea.php?feature=tc_exec_assignment">Assignation d’exécution de fiches de test</a>
                    </li>
                    <li>
                        <a href="lib/general/frmWorkArea.php?feature=editTc">
                            Gestion des fiches de test
                        </a>
                    </li>
                    <li>
                        <a href="lib/testcases/tcSearch.php?doAction=userInput&amp;tproject_id=1">Recherche de fiches de test</a>

                    </li>
                    <li>
                        <a href="lib/general/frmWorkArea.php?feature=keywordsAssign">Affectation des mots-clés</a>

                    </li>
                    <li>
                        <a href="lib/results/tcCreatedPerUserOnTestProject.php?do_action=uinput&amp;tproject_id=1">Fiches de test créées par utilisateur</a>

                    </li>
                    <li>
                        <a href="lib/platforms/platformsAssign.php?tplan_id=2">Affectation des plateformes</a>
                    </li>

                    <li>
                        <a href="lib/general/frmWorkArea.php?feature=test_urgency">Définition de l’urgence des tests</a>
                    </li>
                    <li>
                        <a href="lib/general/frmWorkArea.php?feature=planUpdateTC">Mise à jour des versions de fiches de test à exécuter</a>
                    </li>
                    <li>
                        <a href="lib/general/frmWorkArea.php?feature=newest_tcversions">Affichage nouvelles versions des fiches de test disponibles</a>
                    </li>
                </ul>
            </li>
            <li>
                <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree" style="font-size: large" aria-expanded="false" class="collapsed">Espace exécution</a>
                <ul id="collapseThree" class="panel-collapse collapse" style="display: none;">
                    <li>
                        <a href="lib/general/frmWorkArea.php?feature=executeTest">Gestion des exécutions</a>
                    </li>
                    <li>
                        <a href="lib/testcases/tcAssignedToUser.php">Mes fiches de test à exécuter</a>
                    </li>
                    <li>
                        <a href="lib/general/frmWorkArea.php?feature=showMetrics">Rapports et métriques</a>
                    </li>
                    <li>
                        <a href="lib/results/metricsDashboard.php">Tableau de bord des métriques</a>
                    </li>
                </ul>
            </li>
            <li>
                <a data-toggle="collapse" data-parent="#accordion" href="#collapseFive" style="font-size: large" aria-expanded="false" class="collapsed">Projet de test</a>
                <ul id="collapseFive" class="panel-collapse collapse" style="display: none;">
                    <li>
                        <a href="lib/cfields/cfieldsView.php">Gestion des champs personnalisés</a>
                    </li>
                    <li>
                        <a href="lib/issuetrackers/issueTrackerView.php">Gestion des Gestionnaires d’anomalies</a>
                    </li>
                    <li>
                        <a href="lib/project/projectView.php">Gestion des projets</a>
                    </li>
                    <li>
                        <a href="lib/usermanagement/usersAssign.php?featureType=testproject&amp;featureID=1">Affectation des droits sur le projet</a>
                    </li>
                    <li>
                        <a href="lib/cfields/cfieldsTprojectAssign.php">Affectation des champs personnalisés</a>
                    </li>

                    <li>
                        <a href="lib/keywords/keywordsView.php?tproject_id=1">Gestion des mots-clés</a>
                    </li>
                    <li>
                        <a href="lib/platforms/platformsView.php">Gestion des plateformes</a>
                    </li>
                </ul>
            </li>
        </ul>

    </div>
    <!-- /#sidebar-wrapper -->
    <a href="#menu-toggle" class="btn btn-dark" id="menu-toggle"><i class="glyphicon glyphicon-list"></i>Menu</a>


    <!-- Page Content -->
    <div id="page-content-wrapper">
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
    </div>
    <!-- /#page-content-wrapper -->

</div>

<!-- Menu Toggle Script -->
<script>
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
</script>

</body>
</html>