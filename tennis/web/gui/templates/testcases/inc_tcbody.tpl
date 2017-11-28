{*
TestLink Open Source Project - http://testlink.sourceforge.net/
$Id: inc_tcbody.tpl,v 1.2 2010/10/24 07:21:23 mx-julian Exp $
viewer for test case in test specification

*}

<div class="card border-dark mb-3">
    <div data-toggle="collapse" data-parent="#accordion" href="#collapse1" class="card-header text-center collapsed" style="cursor: pointer" aria-expanded="false">
        <h4  class="card-title text-center " > Propriétés de la fiche de test</h4>
    </div>
    <div id="collapse1" class="collapse card-body text-dark">
        <div class="col-lg-12">
        <div class="col-lg-4"><h5 class="card-title">{$inc_tcbody_labels.version}&nbsp; {$inc_tcbody_testcase.version|escape}</h5> </div>
            <div class="col-lg-8">
                <a href="javascript:showHideByClass('div','ghostTC');" class="clickable"><i class="fa fa-eye">   {$inc_tcbody_labels.show_ghost_string}</i></a> &nbsp; | &nbsp;
                <a href="javascript:showHideByClass('div','time_stamp_creation');"><i class="fa fa-info-circle">   {$inc_tcbody_labels.display_author_updater}</i></a></div>

        </div>
        <div class="col-lg-12">
        <div class="ghostTC" style="display:none;">
            <div class="alert alert-info" role="alert">
                {$inc_tcbody_testcase.ghost}
            </div>
        </div>
        </div>
        <div class="col-lg-12">
            <div class="time_stamp_creation" style="display:none;">
                <div class="alert alert-info" role="alert">
                    {if $inc_tcbody_author_userinfo != ''}
                        <p>{$inc_tcbody_labels.title_created}&nbsp;{localize_timestamp ts=$inc_tcbody_testcase.creation_ts}&nbsp;
                        {$inc_tcbody_labels.by}&nbsp;{$inc_tcbody_author_userinfo->getDisplayName()|escape}</p>
                    {/if}
                    {if $inc_tcbody_testcase.updater_id != ''}
                        <p>{$inc_tcbody_labels.title_last_mod}&nbsp;{localize_timestamp ts=$inc_tcbody_testcase.modification_ts}
                        &nbsp;{$inc_tcbody_labels.by}&nbsp;{$inc_tcbody_updater_userinfo->getDisplayName()|escape}</p>
                    {/if}
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-4"><p>{$inc_tcbody_labels.summary}</p></div>
            <div class="col-lg-8"><p>{if $inc_tcbody_editor_type == 'none'}{$inc_tcbody_testcase.summary|nl2br}{else}{$inc_tcbody_testcase.summary}{/if}</p></div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-4"><p>{$inc_tcbody_labels.preconditions}</p></div>
            <div class="col-lg-8"><p>{if $inc_tcbody_editor_type == 'none'}{$inc_tcbody_testcase.preconditions|nl2br}{else}{$inc_tcbody_testcase.preconditions}{/if}</p></div>
        </div>
    </div>
</div>
<br>
<h3>Table des étapes d'exécution</h3>
<hr>
<table class="table">

{if $inc_tcbody_close_table}
</table>
{/if}