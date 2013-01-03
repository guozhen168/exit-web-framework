<#assign shiro=JspTaglibs["/WEB-INF/taglib/shiro.tld"] />
<script>
	$(document).ready(function(){
		$(".close").click(
			function () {
				$(this).parent().fadeTo(400, 0, function () {
					$(this).slideUp(400);
				});
				return false;
			}
		);
		$("#selectAll").click(function(){
			var checks = $("#resource_list tbody").find("input[type='checkbox'][id!='selectAll']");
			checks.attr('checked', $(this).is(':checked'));
			checks.click();
		});
	});
	
	function search(page){
		var param = $.form.getParameters("#search_form",true);
		param["page.size"] = $("#size").val();
		param["page.page"] = page || 0;
		$.maskLoad({
			url:'account/resource/view',
			param:param,
			target:'#main_content'
		});
	}
</script>
<div id="resource_panel">
	<div id="search_resource_dailog">
		<form id="search_form" action="account/resource/view"  method="post">
			<div class="column">
		        <label for="filter_RLIKES_name">
					资源名称:
		        </label>
		        <div class="field">
		            <input type="text" id="filter_RLIKES_name" name="filter_RLIKES_name" class="text_input_big" size="25" value="${RequestParameters.filter_RLIKES_name!""}"/>
		        </div>
		        <label for="filter_EQS_type">
					资源类型:
		        </label>
		        <div class="field">
		        	<select class="selection" name="filter_EQS_type" id="filter_EQS_type" size="25">
		        		<option value="">
							全部
		                </option>
		           		<#list resourceType as rt>
			           		<option value="${rt.value}" <#if RequestParameters.filter_EQS_type?has_content && RequestParameters.filter_EQS_type == rt.value >selected="selected"</#if> >
								${rt.name}
			                </option>
		           		</#list>
		           </select>
		        </div>
		    </div>
		    <div class="column">
		        <label for="filter_RLIKES_value">
					拦截值:
		        </label>
		        <div class="field">
		          <input type="text" id="filter_RLIKES_value" name="filter_RLIKES_value" class="text_input_big" size="25" value="${RequestParameters.filter_RLIKES_value!""}"/>
		        </div>
		        <label for="filter_RLIKES_permission">
					角色访问:
		        </label>
		        <div class="field">
		           <input type="text" id="filter_RLIKES_permission" name="filter_RLIKES_permission" class="text_input_big" size="25" value="${RequestParameters.filter_RLIKES_permission!""}"/>
		         </div>
		    </div>
		    <div class="column">
		        <label for="filter_EQS_parent.id">
					所属父类:
		        </label>
		        <div class="field">
		          <select class="selection" height="150" search="true" name="filter_EQS_parent.id" id="filter_EQS_parent.id" size="66">
		          	<option value="">
						无
	                </option>
	           		<#list resourcesList as rl>
		           		<option value="${rl.id}" <#if RequestParameters['filter_EQS_parent.id']?has_content && RequestParameters['filter_EQS_parent.id'] == rl.id >selected="selected"</#if> >
							${rl.name}
		                </option>
	           		</#list>
	              </select>
		        </div>
		    </div>
		</form>
		<div class="clear">
			<a href="javascript:$.form.resetForm('#search_form')" title="清空表单"><span class="button right">重 置</span></a>
			<a href="javascript:search();" title="查询输入信息"><span class="button right">查 询</span></a>
		</div>
	</div>
	
	<div class="panel_title">
	 	<span class="resource24_icon">资源管理</span>
	</div>
	
	<div class="panel_content">
  	  <#if message?has_content>
	  	  <div class="notification information">
	  	  	<a href="#" class="close"><img src="resources/images/icons/16/close.png" title="关闭信息" alt="关闭"></a>
	  	  	${message}
	  	  </div>
  	  </#if>
	  <form id="delete_form" action="account/resource/delete" method="post">
		  <table width="100%" id="resource_list">
		    	<thead>
		        	<tr>
		        		<th>
		        			<div style="width:15px;height:15px;margin:0 auto;">
		        				<input type="checkbox" id="selectAll" class="checker"/>
		        			</div>
		        		</th>
		            	<th>
		                	资源名称
		            	</th>
		                <th>
		                	拦截值
		            	</th>
		                <th>
		                	角色访问
		            	</th>
		                <th>
		                	资源类型
		            	</th>
		            	<th>
		            		所属父类
		            	</th>
		            	<th>
		            		备注
		            	</th>
		            	<th>
		            		操作
		            	</th>
		            </tr>
		        </thead>
		        <tbody>
		        	<#list page.content as e>
		            	<tr>
		            		<td>
		            			<div style="width:15px;height:15px;margin:0 auto;">
		            				<input type="checkbox" name="ids" value="${e.id}" class="checker"/>
		            			</div>
		            		</td>
		                	<td>
		                    	${e.name!""}
		                    </td>
		                    <td>
		                    	${e.value!""}
		                    </td>
		                    <td>
		                    	${e.permission!""}
		                    </td>
		                    <td>
		                    	${e.typeName!""}
		                    </td>
		                    <td>
		                    	${e.parentName!""}
		                    </td>
		                    <td>
		                    	${e.remark!""}
		                    </td>
		                    <td align="center">
		                    	<@shiro.hasPermission name="resource:read">
		                    		<a href="account/resource/read?id=${e.id}" icon="resource24_icon"  width="610" target="dialog" dialogId="edit_resource" modal="true" title="修改资源/${e.name}" class="operat edit16_icon">
		                    	</@shiro.hasPermission>
		                    </td>
		                </tr>
		            </#list>
		        </tbody>
		    </table>
		</form>
	</div>
	<div class="panel_footer">
		<@shiro.hasPermission name="resource:save">
			<a href="account/resource/read" icon="resource24_icon" width="610" target="dialog" dialogId="edit_resource" modal="true" title="添加资源">
				<span class="button left">添 加</span>
			</a>
		</@shiro.hasPermission>
		<@shiro.hasPermission name="resource:delete">
	    	<a href="javascript:$.form.submitMaskForm('#delete_form',{maskEl:'#resource_panel',target:'#main_content',promptMsg:'确定要删除吗?'})" title="删除选中资源">
	    		<span class="button left">删 除</span>
	    	</a>
	    </@shiro.hasPermission>
	    <a href="#search_resource_dailog" width="610" icon="resource24_icon" target="dialog" dialogId="search_dailog" title="查询资源列表">
	    	<span class="button left">查 询</span>
	    </a>
	</div>
	
	<#if page.totalElements gt 0>
		<div class="panel_pagging">
		 	<div class="page_bar">
		    	每页显示:<input type="text" size="2" id="size" name="size" class="text_input_small" value="${page.size}"/> 共有${page.totalPages}页/${page.totalElements}条记录
		    </div>
		    <div class="page_bar">
		    	<#if page.hasPreviousPage()>
			    	<a href="javascript:search(0)">
			        	首页
			        </a>
			        <a href="javascript:search(${page.number - 1})">
			        	上一页
			        </a>
		        </#if>
		        <#if page.hasNextPage()>
			        <a href="javascript:search(${page.number + 1})">
			        	下一页
			        </a>
			        <a href="javascript:search(${page.totalPages})">
			        	尾页
			        </a>
		        </#if>
		    </div>
		</div>
	</#if>
</div>