<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://yrartnoc.com/taglib" prefix="t" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改菜单</title>
    
    <jsp:include page="../../_import.jsp"/>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content  animated fadeInRight">
    	<div class="row">
    		<div class="col-lg-12">
    			<div class="ibox">
                    <div class="ibox-title">
                        <h5>修改菜单</h5>
                    </div>
                    <div class="ibox-content">
	                    <t:alert message="${message}"/>
	                    
						<form id="edit-form" class="form-horizontal" action="<c:url value="/pubMenu/update"/>" method="post">
							<div class="form-group">
                            	<label class="col-lg-2 control-label">名称</label>
                               	<div class="col-lg-8">
                               		<input type="text" placeholder="名称" class="form-control" name="title" value="${menu.title}">
                               		<input type="text" class="hide" name="id" value="${menu.id}">
                               	</div>
                           	</div>
                           	<div class="form-group">
                           		<label class="col-lg-2 control-label">图标class</label>
                              	<div class="col-lg-8">
                              		<input type="text" placeholder="图标class" class="form-control" name="icon" value="${menu.icon}">
                              	</div>
                          	</div>
                          	<div class="form-group">
                          		<label class="col-lg-2 control-label">是否显示</label>
                          		<div class="col-lg-8">
                          			<select class="form-control" name="isShow">
                          				<option>-</option>
                          				<option value="1" <c:if test="${menu.isShow=='1'}">selected="selected"</c:if> >显示</option>
                          				<option value="0" <c:if test="${menu.isShow=='0'}">selected="selected"</c:if> >不显示</option>
                          			</select>
                          		</div>
                          	</div>
                          	<div class="form-group">
                            	<label class="col-lg-2 control-label">路径</label>
                               	<div class="col-lg-8">
                               		<input type="text" placeholder="路径" class="form-control" name="path" value="${menu.path}">
                               	</div>
                           	</div>
                           	<div class="form-group">
                            	<label class="col-lg-2 control-label">备注</label>
                               	<div class="col-lg-8">
                               		<input type="text" placeholder="备注" class="form-control" name="remark" value="${menu.remark}">
                               	</div>
                           	</div>
	                        <div class="hr-line-dashed"></div>
                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-2">
                                    <button class="btn btn-primary" type="submit">保存</button>
                                    <a class="btn btn-white" href="<c:url value="/pubMenu/list"/>">返回</a>
                                </div>
                            </div>
						</form>
                    </div>
                </div>
    		
    		</div>
    	</div>
    </div>

	<!-- jQuery Validation plugin javascript-->
    <script src="<c:url value="/static/js/plugins/validate/jquery.validate.min.js"/>"></script>
    <script src="<c:url value="/static/js/plugins/validate/messages_zh.min.js"/>"></script>
    <script src="<c:url value="/static/js/public_validator.js"/>"></script>

<script>

$(document).ready(function () {
  	var icon = "<i class='fa fa-times-circle'></i> ";
  	$("#edit-form").validate({
  		rules: {
			title:{
				required:true,
				maxlength:30
			},
			icon:{
				maxlength:20
			},
			path:{
				required:true,
				maxlength:100
			},
			remark:{
				maxlength:255
			}
		},
		messages: {
			title:{
				required:"请输入菜单名称",
				maxlength:"最多输入30个字符"
			},
			icon:{
				maxlength:"图标class最多输入20个字符"
			},
			path:{
				required:"请输入路径",
				maxlength:"访问路径最多输入100个字符"
			},
			remark:{
				maxlength:"备注最多输入255个字符"
			}
		}
  	});
}); 
</script>

</body>

</html>
