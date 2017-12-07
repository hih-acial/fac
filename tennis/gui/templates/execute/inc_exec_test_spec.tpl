{* 
TestLink Open Source Project - http://testlink.sourceforge.net/
$Id: inc_exec_test_spec.tpl,v 1.22.2.1 2010/11/18 15:17:45 mx-julian Exp $
Purpose: draw execution controls (input for notes and results)
Author : franciscom

*}  
    {$tableColspan="4"}
    {if $tlCfg->exec_cfg->steps_exec}
      {$tableColspan="6"}
    {/if}
    
    {$getReqAction="lib/requirements/reqView.php?showReqSpecTitle=1&requirement_id="}
    {$testcase_id=$args_tc_exec.testcase_id}
    {$tcversion_id=$args_tc_exec.id}
    


    <div class="col-lg-12">
        <div class="col-lg-3"><h5>{$args_labels.test_exec_summary}</h5></div>
        <div class="col-lg-3">{if $gui->testDesignEditorType == 'none'}{$args_tc_exec.summary|nl2br}{else}{$args_tc_exec.summary}{/if}</div>
    </div>

<div class="col-lg-12">
    <div class="col-lg-3"><h5>{$args_labels.preconditions}</h5></div>
    <div class="col-lg-3">{if $gui->testDesignEditorType == 'none'}{$args_tc_exec.preconditions|nl2br}{else}{$args_tc_exec.preconditions}{/if}</div>
</div>

<div class="col-lg-12">
    <div class="col-lg-3"><h5>{$args_labels.execution_type}</h5></div>
    <div class="col-lg-3">{$args_execution_types[$args_tc_exec.execution_type]}</div>
</div>

<div class="col-lg-12">
    <div class="col-lg-3"><h5>{$args_labels.estimated_execution_duration}</h5></div>
    <div class="col-lg-3">{if $args_tc_exec.estimated_exec_duration==0}Non renseigné{else}{$args_tc_exec.estimated_exec_duration}{/if}</div>
</div>

{if $args_design_time_cf[$testcase_id].before_steps_results != ''}
    <div class="col-lg-12">
        <div class="col-lg-3"><h5>{$args_design_time_cf[$testcase_id].before_steps_results}</h5></div>
        <div class="col-lg-3">ok</div>
    </div>
{/if}

{if isset($args_req_details)}
    <div class="col-lg-12">
        <div class="col-lg-3"><h5>{$args_labels.reqs}</h5></div>
        <div class="col-lg-3">
        <ol>
        {foreach from=$args_req_details key=id item=req_elem}
            <li>{$tlCfg->gui_separator_open}{$req_elem.req_spec_title}{$tlCfg->gui_separator_close}
                <a href="javascript:openLinkedReqWindow({$req_elem.id})"title="{$args_labels.click_to_open}">
                    {$req_elem.req_doc_id|escape}{$tlCfg->gui_title_separator_1}{$req_elem.title|escape}
                </a>
            </li>&nbsp;
        </ol>
            {/foreach}
        </div>
    </div>
{/if}
{if $args_tc_exec.steps != '' && !is_null($args_tc_exec.steps)}
    <h4>Table des étapes d'exécution</h4>
    <hr>
    <table class="table">
        {include file="testcases/inc_steps.tpl"
        layout=$args_cfg->exec_cfg->steps_results_layout
        edit_enabled=false
        ghost_control=false
        add_exec_info=$tlCfg->exec_cfg->steps_exec
        steps=$args_tc_exec.steps}
    </table>
    <hr>
{/if}
{* relations - 20140814 *}
{if $args_relations != '' && !is_null($args_relations)}
            {include file="execute/exec_tc_relations.inc.tpl"
            argsColSpan=$tableColspan argsRelSet=$args_relations}
{/if}

{if $args_design_time_cf[$testcase_id].standard_location != ''}
<div id="cfields_design_time_tcversionid_{$tcversion_id}" class="col-lg-12">
    {$args_design_time_cf[$testcase_id].standard_location}
</div>
{/if}
{* ------------------------------------------------------------------------------------- *}
{if $args_enable_custom_field and $args_tc_exec.active == 1}
{if isset($args_execution_time_cf[$testcase_id]) && $args_execution_time_cf[$testcase_id] != ''}
<div class="col-lg-12" id="cfields_exec_time_tcversionid_{$tcversion_id}">
    {$args_execution_time_cf[$testcase_id]}
</div>
{/if}
{/if} {* if $args_enable_custom_field *}
{* ------------------------------------------------------------------------------------- *}
{if $args_testplan_design_time_cf[$testcase_id] != ''}
<div id="cfields_testplan_design_time_tcversionid_{$tcversion_id}"  class="col-lg-12">
    {$args_testplan_design_time_cf[$testcase_id]}
</div>
{/if}

      {if $args_tcAttachments[$testcase_id] neq null}
        {include file="inc_attachments.tpl"
                 attach_tableName="nodes_hierarchy"
                 attach_downloadOnly=true
                 attach_attachmentInfos=$args_tcAttachments[$testcase_id]
                 attach_tableClassName="bordered"
                 attach_tableStyles="background-color:#dddddd;width:100%"}
      {/if}


    {if isset($args_keywords)}
        <div class="col-lg-12">
            <div class="col-lg-3"><h5>{$args_labels.keywords}</h5></div>
            <div class="col-lg-3">
                <ul>
                    {foreach item=keyword_item from=$args_keywords name=itemKeywords}
                    <li>{$keyword_item.keyword|escape}{if !$smarty.foreach.itemKeywords.last},&nbsp;{/if}</li>
                    {/foreach}
                </ul>
            </div>
        </div>
    {/if}


