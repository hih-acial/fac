{*
TestLink Open Source Project - http://testlink.sourceforge.net/
@filesource containerMove.tpl
Purpose: smarty template - form for move/copy container in test specification

@since 1.9.14
*}
{lang_get s='container' var='parent'}
{lang_get var="labels"
          s="cont_move_first,sorry_further,title_move_cp,cont_copy_first,defined_exclam,
             cont_move_second,cont_copy_second,choose_target,
             copy_copy_keywords,
             copy_copy_requirement_assignments,
             btn_move,btn_cp,as_first_testsuite,as_last_testsuite"}

{include file="inc_head.tpl" openHead="yes"}
{include file="../custom.tpl"}
<script type="text/javascript">
jQuery( document ).ready(function() {
jQuery(".chosen-select").chosen({ width: "50%", search_contains: true });
});
</script>

</head>
<body>
{lang_get s=$level var=level_translated}
<section class="jumbotron">
    <h2 class="text-center">{$level_translated}{$smarty.const.TITLE_SEP}{$object_name|escape} </h2>
</section>

<div class="container">
<h3 class="text-center">{$labels.title_move_cp}</h3>
    <hr>
{if $containers eq ''}
	{$labels.sorry_further} {$parent} {$labels.defined_exclam}
{else}
	<form method="post" action="{$basehref}lib/testcases/containerEdit.php?objectID={$objectID|escape}">
        <fieldset>
            <legend>{$labels.cont_move_first} {$level_translated} {$labels.cont_move_second} {$parent|escape}.<br />
                {$labels.cont_copy_first} {$level_translated} {$labels.cont_copy_second} {$parent|escape}.</legend>

		<p>{$labels.choose_target} {$parent|escape}:
			<select name="containerID" id="containerID" class="chosen-select">
				{html_options options=$containers}
			</select>
		</p>

	<p><input type="radio" name="target_position"
	          value="top" {$top_checked} />{$labels.as_first_testsuite}
  	<br /><input type="radio" name="target_position"
	          value="bottom" {$bottom_checked} />{$labels.as_last_testsuite}


		<p>
			<input type="checkbox" name="copyKeywords" id="copyKeywords"
			  checked="checked" value="1" />
			{$labels.copy_copy_keywords}
		<br/>
			<input type="checkbox" name="copyRequirementAssignments"
			  id="copyRequirementAssignments"
			  checked="checked" value="1" />
			{$labels.copy_copy_requirement_assignments}
		</p>

		<div>
			<input class="btn btn-primary" type="submit" name="do_move" value="{$labels.btn_move}" />
			<input class="btn btn-warning" type="submit" name="do_copy" value="{$labels.btn_cp}" />
			<input type="hidden" name="old_containerID" value="{$old_containerID}" />
		</div>
        </fieldset>
	</form>
{/if}
</div>
</body>
</html>
