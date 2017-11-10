{*
TestLink Open Source Project - http://testlink.sourceforge.net/
@filesource cfieldsEdit.tpl

Important Development note:
Input names:
            cf_show_on_design
            cf_show_on_execution
            cf_enable_on_design
            cf_enable_on_execution
            cf_show_on_testplan_design
            cf_enable_on_testplan_design


can not be changed, because there is logic on cfields_edit.php
that dependens on these names.
As you can see these names are build adding 'cf_' prefix to name
of columns present on custom fields tables.
This is done to simplify logic.

*}

{$cfg_section=$smarty.template|basename|replace:".tpl":"" }
{config_load file="input_dimensions.conf" section=$cfg_section}

{$managerURL="lib/cfields/cfieldsEdit.php"}
{$viewAction="lib/cfields/cfieldsView.php"}

{lang_get s='warning_delete_cf' var="warning_msg" }
{lang_get s='delete' var="del_msgbox_title" }

{lang_get var="labels"
          s="btn_ok,title_cfields_mgmt,warning_is_in_use,warning,name,label,type,possible_values,
             warning_empty_cfield_name,warning_empty_cfield_label,testproject,assigned_to_testprojects,
             enable_on_design,show_on_exec,enable_on_exec,enable_on_testplan_design,
             available_on,btn_upd,btn_delete,warning_no_type_change,enable_on,
             btn_add,btn_cancel,show_on_design,show_on_testplan_design,btn_add_and_assign_to_current,"}

{include file="inc_head.tpl" jsValidate="yes" openHead="yes"}
{include file="inc_del_onclick.tpl"}
{include file="../custom.tpl"}
<script type="text/javascript">
/* All this stuff is needed for logic contained in inc_del_onclick.tpl */
var del_action=fRoot+'{$managerURL}'+'?do_action=do_delete&cfield_id=';
</script>

<script type="text/javascript">
var alert_box_title = "{$labels.warning|escape:'javascript'}";
var warning_empty_cfield_name = "{$labels.warning_empty_cfield_name|escape:'javascript'}";
var warning_empty_cfield_label = "{$labels.warning_empty_cfield_label|escape:'javascript'}";

// -------------------------------------------------------------------------------
// To manage hide/show combo logic, depending of node type
var js_enable_on_cfg = new Array();
var js_show_on_cfg = new Array();

// DOM Object ID (oid)
js_enable_on_cfg['oid_prefix'] = new Array();
js_enable_on_cfg['oid_prefix']['boolean_combobox'] = 'cf_enable_on_';
js_enable_on_cfg['oid_prefix']['container'] = 'container_cf_enable_on_';
js_enable_on_cfg['oid'] = new Array();
js_enable_on_cfg['oid']['combobox'] = 'cf_enable_on';
js_enable_on_cfg['oid']['container'] = 'container_cf_enable_on';


// will containg show (1 /0 ) info for every node type
js_enable_on_cfg['execution'] = new Array();
js_enable_on_cfg['design'] = new Array();
js_enable_on_cfg['testplan_design'] = new Array();  // BUGID 1650 (REQ)


// DOM Object ID (oid)
js_show_on_cfg['oid_prefix'] = new Array();
js_show_on_cfg['oid_prefix']['boolean_combobox'] = 'cf_show_on_';
js_show_on_cfg['oid_prefix']['container'] = 'container_cf_show_on_';

// will containg show (1 /0 ) info for every node type
js_show_on_cfg['execution'] = new Array();
js_show_on_cfg['design'] = new Array();
js_show_on_cfg['testplan_design'] = new Array();  // BUGID 1650 (REQ)

{foreach key=node_type item=cfg_def from=$gui->cfieldCfg->enable_on_cfg.execution}
  js_enable_on_cfg['execution'][{$node_type}]={$cfg_def};
{/foreach}

{foreach key=node_type item=cfg_def from=$gui->cfieldCfg->enable_on_cfg.design}
  js_enable_on_cfg['design'][{$node_type}]={$cfg_def};
{/foreach}

{foreach key=node_type item=cfg_def from=$gui->cfieldCfg->enable_on_cfg.testplan_design}
  js_enable_on_cfg['testplan_design'][{$node_type}]={$cfg_def};
{/foreach}


{foreach key=node_type item=cfg_def from=$gui->cfieldCfg->show_on_cfg.execution}
  js_show_on_cfg['execution'][{$node_type}]={$cfg_def};
{/foreach}

{foreach key=node_type item=cfg_def from=$gui->cfieldCfg->show_on_cfg.design}
  js_show_on_cfg['design'][{$node_type}]={$cfg_def};
{/foreach}

{foreach key=node_type item=cfg_def from=$gui->cfieldCfg->show_on_cfg.testplan_design}
  js_show_on_cfg['testplan_design'][{$node_type}]={$cfg_def};
{/foreach}
// -------------------------------------------------------------------------------

var js_possible_values_cfg = new Array();
{foreach key=cf_type item=cfg_def from=$gui->cfieldCfg->possible_values_cfg}
  js_possible_values_cfg[{$cf_type}]={$cfg_def};
{/foreach}


function validateForm(f)
{
  if (isWhitespace(f.cf_name.value))
  {
    alert_message(alert_box_title,warning_empty_cfield_name);
    selectField(f, 'cf_name');
    return false;
  }

  if (isWhitespace(f.cf_label.value))
  {
    alert_message(alert_box_title,warning_empty_cfield_label);
    selectField(f, 'cf_label');
    return false;
  }
  return true;
}

/*
  function: configure_cf_attr
            depending of node type, custom fields attributes
            will be set to disable, is its value is nonsense
            for node type choosen by user.

  args :
         id_nodetype: id of html input used to choose node type
                      to which apply custom field


  returns: -

*/
function configure_cf_attr(id_nodetype,enable_on_cfg,show_on_cfg)
{
  var o_nodetype=document.getElementById(id_nodetype);
  var o_enable=new Array();
  var o_enable_container=new Array();
  var o_display=new Array();
  var o_display_container=new Array();


  var oid;
  var keys2loop=new Array();
  var idx;
  var key;
  var option_item;
  var enabled_option_counter=0;
  var style_display;
  var TCASE_NODE=3;   // Sorry MAGIC NUMBER
  
  keys2loop[0]='execution';
  keys2loop[1]='design';
  keys2loop[2]='testplan_design'; 

  style_display='';
  for(idx=0;idx < keys2loop.length; idx++)
  {
    key=keys2loop[idx];
    oid='option_' + key;
    option_item = document.getElementById(oid);

    // Dev Note:
    // Only Firefox (@20100829) is able to hide/show an option present on a HTML select.
    // IE and Chrome NOT 
    // Need to understand then if is better to remove all this code
    if( enable_on_cfg[key][o_nodetype.value] == 0 )
    {
      option_item.style.display='none';
    }
    else
    {
      option_item.style.display='';
      enabled_option_counter++;
    }
  }
  
  // Set Always to Test Spec Design that is valid for TL elements
  if( enabled_option_counter == 0 )
  {
    style_display='none';
  }
  document.getElementById(enable_on_cfg['oid']['container']).style.display=style_display;
  // responsible of BUGID 4000
  // document.getElementById(enable_on_cfg['oid']['combobox']).value='design';

  // ------------------------------------------------------------
  // Display on
  // ------------------------------------------------------------

  // exception if node type = test case && enable_on == execution
  // the display on execution combo has not to be displayed.

  for(idx=0;idx < keys2loop.length; idx++)
  {
    key=keys2loop[idx];
    oid=show_on_cfg['oid_prefix']['boolean_combobox']+key;
    
    o_display[key]=document.getElementById(oid);
    if( o_display[key] != null)
    {
      oid=show_on_cfg['oid_prefix']['container']+key;
      o_display_container[key]=document.getElementById(oid);
      
      if( show_on_cfg[key][o_nodetype.value] == 0 )
      {
        o_display[key].disabled='disabled';
        o_display_container[key].style.display='none';
        o_display[key].value=0;
      }
      else
      {
				// this logic is used to HIDE 'Display On Test Execution' combo
        if( o_nodetype.value == TCASE_NODE && key == 'execution' &&
        		document.getElementById(enable_on_cfg['oid']['combobox']).value == key
        )
        {
        	o_display[key].value=1;
        	o_display[key].disabled='disabled';
        	o_display_container[key].style.display='none';
				}
				else
				{
      		o_display[key].disabled='';
      		o_display_container[key].style.display='';
      	}
      }
    }
  }
  // ------------------------------------------------------------
} // configure_cf_attr



/*
  function: cfg_possible_values_display
            depending of Custom Field type, Possible Values attribute
            will be displayed or not.

  args : cf_type: id of custom field type, choosen by user.

         id_possible_values_container : id of html container
                                        where input for possible values
                                        lives. Used to manage visibility.

  returns:

*/
function cfg_possible_values_display(cfg,id_cftype,id_possible_values_container)
{

  o_cftype=document.getElementById(id_cftype);
  o_container=document.getElementById(id_possible_values_container);

  if( cfg[o_cftype.value] == 0 )
  {
    o_container.style.display='none';
  }
  else
  {
    o_container.style.display='';
  }
}

/*
  function: initShowOnExec
            called every time value of 'cf_enable_on' is changed
            to initialize  show_on_ attribute.
 
  args:
  
  returns: 

*/
function initShowOnExec(id_master,show_on_cfg)
{
  var container_oid=show_on_cfg['oid_prefix']['container']+'execution';
  var combo_oid=show_on_cfg['oid_prefix']['boolean_combobox']+'execution';
  
  var o_container=document.getElementById(container_oid);
  var o_combo=document.getElementById(combo_oid);
  
  var o_master=document.getElementById(id_master);
  
  if( o_master.value == 'execution')
  {
    o_container.style.display='none';
    o_combo.value=1;
  }
  else
  {
    o_container.style.display='';
  }
}
</script>
</head>

<body onload="configure_cf_attr('combo_cf_node_type_id',js_enable_on_cfg,js_show_on_cfg);">
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
            <h1 class="title text-center">
                {$labels.title_cfields_mgmt}
                {include file="inc_help.tpl" helptopic="hlp_customFields" show_help_icon=true}
            </h1>
            <hr>
            <h2 class="text-center">{$operation_descr|escape}</h2>
            {include file="inc_update.tpl" user_feedback=$user_feedback}

            {if $gui->cfield_is_used}
                <div class="user_feedback">{$labels.warning_no_type_change}</div>
            {/if}

            <div class="workBack">

                {if $user_action eq "do_delete"}
                    <form method="post" name="cfields_edit" action="{$viewAction}">
                        <div class="groupBtn">
                            <input type="submit" name="ok" value="{$labels.btn_ok}" />
                        </div>
                    </form>

                {else}
                    <section>
                        <div class="container container-fluid well">
                            <form class="form-horizontal" method="post" name="cfields_edit" action="lib/cfields/cfieldsEdit.php"
                                  onSubmit="return validateForm(this);">
                                <input type="hidden" id="hidden_id" name="cfield_id" value="{$gui->cfield.id}" />

                                <div class="form-group">
                                    <label class="col-lg-2 control-label" for="cf_name">{$labels.name} <span style="color:red;">*</span></label>
                                    <div class="col-lg-10">
                                        <input class="form-control" type="text" id="cf_name" name="cf_name"
                                               size="{#CFIELD_NAME_SIZE#}"
                                               maxlength="{#CFIELD_NAME_MAXLEN#}"
                                               value="{$gui->cfield.name|escape}" required />
                                        {include file="error_icon.tpl" field="cf_name"}
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-lg-2 control-label" for="cf_label">{$labels.label} <span style="color:red;">*</span></label>
                                    <div class="col-lg-10">
                                        <input class="form-control" type="text" id="cf_label" name="cf_label"
                                               size="{#CFIELD_LABEL_SIZE#}"
                                               maxlength="{#CFIELD_LABEL_MAXLEN#}"
                                               value="{$gui->cfield.label|escape}" required />
                                        {include file="error_icon.tpl" field="cf_label"}
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="combo_cf_node_type_id" class="col-lg-2 control-label"> {$labels.available_on}</label>
                                    <div class="col-lg-10">
                                        {if $gui->cfield_is_used} {* Type CAN NOT BE CHANGED *}
                                            {assign var="idx" value=$gui->cfield.node_type_id}
                                            {$gui->cfieldCfg->cf_allowed_nodes.$idx}
                                            <input type="hidden" id="combo_cf_node_type_id"
                                                   value={$gui->cfield.node_type_id} name="cf_node_type_id" />
                                        {else}
                                            <select class="form-control" onchange="configure_cf_attr('combo_cf_node_type_id',
  				                                    js_enable_on_cfg,
  				                                    js_show_on_cfg);"
                                                    id="combo_cf_node_type_id"
                                                    name="cf_node_type_id">
                                                {html_options options=$gui->cfieldCfg->cf_allowed_nodes selected=$gui->cfield.node_type_id}
                                            </select>
                                        {/if}
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="combo_cf_type" class="col-lg-2 control-label"> {$labels.type}</label>
                                    <div class="col-lg-10">
                                        {if $gui->cfield_is_used}
                                            {$idx=$gui->cfield.type}
                                            {$gui->cfield_types.$idx}
                                            <input type="hidden" id="hidden_cf_type"
                                                   value={$gui->cfield.type} name="cf_type" />
                                        {else}
                                            <select class="form-control" onchange="cfg_possible_values_display(js_possible_values_cfg,
  				                                              'combo_cf_type',
  				                                              'possible_values');"
                                                    id="combo_cf_type"
                                                    name="cf_type">
                                                {html_options options=$gui->cfield_types selected=$gui->cfield.type}
                                            </select>
                                        {/if}
                                    </div>
                                </div>

                                {if $gui->show_possible_values }
                                    {$display_style=""}
                                {else}
                                    {$display_style="none"}
                                {/if}

                                <div class="form-group" id="possible_values" style="display:{$display_style};">
                                    <label class="col-lg-2 control-label" for="cf_possible_values">{$labels.possible_values}</label>
                                    <div class="col-lg-10">
                                        <input class="form-control" type="text" id="cf_possible_values"
                                               name="cf_possible_values"
                                               size="{#CFIELD_POSSIBLE_VALUES_SIZE#}"
                                               maxlength="{#CFIELD_POSSIBLE_VALUES_MAXLEN#}"
                                               value="{$gui->cfield.possible_values}" />
                                    </div>
                                </div>

                                {* ------------------------------------------------------------------------------- *}
                                {* NEW *}
                                <div class="form-group" id="container_cf_enable_on">
                                    <label for="cf_enable_on" class="col-lg-2 control-label"> {$labels.enable_on}</label>
                                    <div class="col-lg-10">
                                        <select class="form-control" name="cf_enable_on" id="cf_enable_on"
                                                onchange="initShowOnExec('cf_enable_on',js_show_on_cfg);">
                                            {foreach item=area_cfg key=area_name from=$gui->cfieldCfg->cf_enable_on}
                                                {assign var="access_key" value="enable_on_$area_name"}
                                                <option value={$area_name} id="option_{$area_name}"
                                                        {if $area_cfg.value == 0} style="display:none;" {/if}
                                                        {if $gui->cfield.$access_key} selected="selected"	{/if}>{$area_cfg.label}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group" id="container_cf_show_on_execution" {$gui->cfieldCfg->cf_show_on.execution.style}>
                                    <label class="col-lg-2 control-label" for="cf_show_on_execution">{$labels.show_on_exec}</label>
                                    <div class="col-lg-10">
                                        <select class="form-control" id="cf_show_on_execution"  name="cf_show_on_execution">
                                            {html_options options=$gsmarty_option_yes_no selected=$gui->cfield.show_on_execution}
                                        </select>
                                    </div>
                                </div>
                                {* BUGID *}
                                {if isset($gui->cfield_is_linked) && $gui->cfield_is_linked}
                                    <table class="common">
                                        <tr> <th>{$labels.assigned_to_testprojects} </th>
                                            {foreach item=tproject from=$gui->linked_tprojects}
                                        <tr> <td>{$tproject.name|escape}</td> </tr>
                                        {/foreach}
                                    </table>

                                {/if}

                                <div class="groupBtn col-lg-offset-4 col-md-offset-4">
                                    <input type="hidden" name="do_action" value="" />
                                    {if $user_action eq 'edit'  or $user_action eq 'do_update'}
                                        <input class="btn btn-success" type="submit" name="do_update" value="{$labels.btn_upd}"
                                               onclick="do_action.value='do_update'"/>

                                        {*  {if $gui->cfield_is_used eq 0} *}
                                        {* Allow delete , just give warning *}
                                        <input class="btn btn-danger" type="button" name="do_delete" value="{$labels.btn_delete}"
                                               onclick="delete_confirmation({$gui->cfield.id},'{$gui->cfield.name|escape:'javascript'|escape}',
                                                       '{$del_msgbox_title}','{$warning_msg}');">
                                        {* {/if} *}

                                    {else}
                                        <input class="btn btn-success" type="submit" name="do_update" value="{$labels.btn_add}"
                                               onclick="do_action.value='do_add'"/>

                                        <input class="btn btn-primary" type="submit" name="do_add_and_assign" id="do_add_and_assign" value="{$labels.btn_add_and_assign_to_current}"
                                               onclick="do_action.value='do_add_and_assign'"/>
                                    {/if}
                                    <input class="btn btn-default" type="button" name="cancel" value="{$labels.btn_cancel}"
                                           onclick="location.href=fRoot+'lib/cfields/cfieldsView.php';" />

                                </div>
                            </form>
                        </div>

                    </section>

                    <hr />
                {/if}

            </div>
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