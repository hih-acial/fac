{*
TestLink Open Source Project - http://testlink.sourceforge.net/

delete test case in test specification

@filesource	tcDelete.tpl
@internal revisions
20110529 - TICKET 4322: New Option to block delete of executed test cases.
*}
{lang_get var="labels"
          s='btn_yes_iw2del,btn_no,th_version,th_linked_to_tplan,title_delete_testcases,
             th_executed,question_del_tc,platform'}
{include file="inc_head.tpl"}
{include file="../custom.tpl"}
<body>

<section class="jumbotron">
	<h2 class="text-center">{$gui->main_descr|escape}</h2>
</section>

<div class="container">
{include file="inc_update.tpl" user_feedback=$gui->user_feedback 
         result=$gui->sqlResult action=$gui->action item="test case"
         refresh=$gui->refreshTree}

{if $gui->sqlResult == ''}
	{if $gui->delete_mode == 'single'}
	  {if $gui->exec_status_quo != ''}
	      <table class="table" >
	  		<tr>
	  			<th>{$labels.th_version}</th>
	  			<th>{$labels.th_linked_to_tplan}</th>
	  			{if $gui->display_platform}<th>{$labels.platform}</th> {/if}
	  			<th>{$labels.th_executed}</th>
            </tr>
	  		{foreach from=$gui->exec_status_quo key=testcase_version_id item=on_tplan_status}
	  			{foreach from=$on_tplan_status key=tplan_id item=status_on_platform}
	  				{foreach from=$status_on_platform key=platform_id item=status}
	  			    <tr>
	  				    <td style="width:4%;text-align:right;">{$status.version}</td>
	  				    <td align="left">{$status.tplan_name|escape}</td>
	  			      {if $gui->display_platform}
	  			        <td align="left">{$status.platform_name|escape}</td>
	  			      {/if}
	  				    <td style="width:4%;text-align:center;">
	  				    {if $status.executed != ""}<img src="{$tlImages.checked}" />{/if}</td>
	  				  </tr>
	  			  {/foreach}
	  			{/foreach}
	  		{/foreach}
	      </table>

          <h3>{$gui->delete_message}</h3>
    {/if}
    
    {if $gui->delete_enabled}
	  <h3>{$labels.question_del_tc}</h3>
	  <form method="post" 
	        action="{$basehref}lib/testcases/tcEdit.php?testcase_id={$gui->testcase_id}&tcversion_id={$gui->tcversion_id}">
	  	<input class="btn btn-danger" type="submit" id="do_delete" name="do_delete" value="{$labels.btn_yes_iw2del}" />
	  	<input class="btn btn-secondary" type="button" name="cancel_delete"
	  	                     onclick="{$gui->cancelActionJS};" value="{$labels.btn_no}" />
	  </form>
    {/if}
 
  
  {else}
	  {if $gui->exec_status_quo != ''}
	      <table class="simple" >
	  		<tr>
	  			<th>&nbsp;</th>
	  			<th>{$labels.th_version}</th>
	  			<th>{$labels.th_linked_to_tplan}</th>
	  			<th>{$labels.th_executed}</th>
	  			</tr>
	  		{foreach from=$gui->exec_status_quo key=testcase_version_id item=on_tplan_status}
	  			{foreach from=$on_tplan_status key=tplan_id item=status_on_platform}
	  				{foreach from=$status_on_platform key=platform_id item=status}
	  			    <tr>
	  				    <td align="right">{$status.version}</td>
	  				    <td align="left">{$status.tplan_name|escape}</td>
	  				    <td align="center">{if $status.executed neq ""}<img src="{$smarty.const.TL_THEME_IMG_DIR}/apply_f2_16.png" />{/if}</td>
	  				  </tr>
	  			  {/foreach}
	  			{/foreach}
	  		{/foreach}
	      </table>
      	{$gui->delete_message}
    {/if}
    
    {if $gui->delete_enabled} {* TICKET 4322 *}
	  <p>{$labels.question_del_tc}</p>
	  <form method="post" 
	        action="{$basehref}lib/testcases/tcEdit.php?testcase_id={$gui->testcase_id}&tcversion_id={$gui->tcversion_id}">
	  	<input class="btn btn-danger" type="submit" id="do_delete" name="do_delete" value="{$labels.btn_yes_iw2del}" />
	  	<input class="btn btn-secondary" type="button" name="cancel_delete"
	  	                     onclick='location.href=fRoot+"lib/testcases/archiveData.php?version_id=undefined&edit=testcase&id={$gui->testcase_id}";'
	  	                     value="{$labels.btn_no}" />
	  </form>
  	{/if}
  {/if}	  
{/if}
</div>
</body>
</html>