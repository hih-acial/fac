{* 
TestLink Open Source Project - http://testlink.sourceforge.net/
@filesource containerDelete.tpl
Purpose: smarty template - delete containers in test specification
*}
{include file="inc_head.tpl"}
{lang_get var='labels'
          s='test_case,th_link_exec_status,question_del_testsuite,
             btn_yes_del_comp,btn_no'}
{include file="../custom.tpl"}
<body>
<section class="jumbotron">
  <h2 class="text-center">{$page_title}{$smarty.const.TITLE_SEP}{$objectName|escape}</h2>
</section>
{include file="inc_update.tpl" result=$sqlResult item=$level action='delete' refresh=$refreshTree}

<div class="container">

{if $sqlResult == '' && $objectID != ''}
  {if $warning != ""}
    {if $system_message != ""}
      <div class="user_feedback">{$system_message}</div>
      <br />
    {/if}
    <table class="table">
    <tr>
      <th>{$labels.test_case}</th>
      <th>{$labels.th_link_exec_status}</th>
    </tr>
    {section name=idx loop=$warning}
      <tr>
        <td>{$warning[idx]|escape}&nbsp;</td>
        <td>{lang_get s=$link_msg[idx]}<td>
      </tr>
    {/section}
    </table>
    {if $delete_msg != ''}  
      <h2>{$delete_msg}</h2>
    {/if}
  {/if}
  
  <form method="post" action="{$basehref}lib/testcases/containerEdit.php?sure=yes&amp;objectID={$objectID}">
    {if $can_delete}
      <p>{$labels.question_del_testsuite}</p>
      <input class="btn btn-danger" type="submit" name="delete_testsuite" value="{$labels.btn_yes_del_comp}" />
    
      <input class="btn btn-secondary" type="button" name="cancel_delete_testsuite" value="{$labels.btn_no}"
          onclick='location.href=fRoot+
          "lib/testcases/archiveData.php?&amp;edit=testsuite&amp;id={$objectID}";' />
    {/if}
  </form>
{/if}

{if $refreshTree}
  {include file="inc_refreshTreeWithFilters.tpl"}
{/if}
</div>
</body>
</html>