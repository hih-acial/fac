{* 
TestLink Open Source Project - http://testlink.sourceforge.net/
@filesource exec_tc_relations.inc.tpl
@internal revisions
@since 1.9.13
*}
{lang_get var='rel_labels' 
          s='relation_id,relation_type_extended,relation_set_by,test_case,relations,
             execution_history, execution, design'}


    {if $argsRelSet.num_relations > 0}
        <h4>Relations des cas de test</h4>
    <table class="table">
      <thead class="bg-info">
      <tr>
          <th><nobr>{$rel_labels.relation_id} / {$rel_labels.relation_type_extended}</nobr></th>
          <th colspan="1">{$rel_labels.test_case}</th>
      </tr>
      </thead>
      <tbody>
      {foreach item=rx from=$argsRelSet.relations}
        {$rel_status=$rx.related_item.status}
        <tr>
          <td class="bold"><nobr>{$rx.id} / {$rx.type_localized|escape}</nobr></td>
          <td>
          <img class="clickable" src="{$tlImages.history_small}"
               onclick="openExecHistoryWindow({$rx.related_tcase.testcase_id});"
               title="{$labels.execution_history}" />
          <img class="clickable" src="{$tlImages.exec_icon}"
               onclick="openExecutionWindow({$rx.related_tcase.testcase_id},{$rx.related_tcase.id},{$gui->build_id},{$gui->tplan_id},{$gui->platform_id});"
               title="{$labels.execution}" />
          <img class="clickable" src="{$tlImages.edit}"
               onclick="openTCaseWindow({$rx.related_tcase.testcase_id},{$rx.related_tcase.id});"
               title="{$labels.design}" />            
          <a href="javascript:openTCaseWindow({$rx.related_tcase.testcase_id},{$rx.related_tcase.id})">
             {$rx.related_tcase.fullExternalID|escape}:
             {$rx.related_tcase.name|escape}</a>
          </td>
        </tr>
      {/foreach}
      </tbody>
    </table>
    {/if}
