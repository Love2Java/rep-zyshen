<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${fns:getConfig('productName')}首页</title>

<link rel="stylesheet" href="${ctxContent}/ui/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${ctxContent}/css/font-awesome.min.css">
<link rel="stylesheet" href="${ctxContent}/css/index.css">
<link rel="stylesheet" href="${ctxContent}/css/skins/_all-skins.css">
<link href="${ctxContent}/ui/layui/css/layui.css" rel="stylesheet" />

</head>

<body class="hold-transition skin-blue sidebar-mini" style="overflow: hidden;">
	<div id="ajax-loader" style="cursor: progress; position: fixed; top: -50%; left: -50%; width: 200%; height: 200%; background: #fff; z-index: 10000; overflow: hidden;">
		<img src="${ctxContent}/img/ajax-loader.gif" style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; margin: auto;" />
	</div>
	<div class="wrapper">
		<!--头部信息-->
		<header class="main-header">
		    <a href="#" target="_blank" class="logo">
		        <span class="logo-mini"></span>
		        <span class="logo-lg" style="font-size:22px;">${fns:getConfig('productName')}</span>
		    </a>
		<nav class="navbar navbar-static-top">
		    <a class="sidebar-toggle"><span class="sr-only">Toggle navigation</span></a>
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<!-- <li class="dropdown messages-menu">
				    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
				    <i class="fa fa-envelope-o "></i>
				    <span class="label label-success">4</span>
				    </a>
				</li>
				<li class="dropdown notifications-menu">
				    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
				    <i class="fa fa-bell-o"></i>
				    <span class="label label-warning">10</span>
				    </a>
				</li>
				<li class="dropdown tasks-menu">
				    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
				    <i class="fa fa-flag-o"></i>
				    <span class="label label-danger">9</span>
				    </a>
				</li> -->
				<li class="dropdown user user-menu">
				    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
				    <img src="${ctxContent}/img/user2-160x160.jpg" class="user-image" alt="User Image">
				    <span class="hidden-xs">登录用户：${sessionScope.user.getName()}</span>
				    </a>
					<ul class="dropdown-menu pull-right">
						<li>
						    <a class="menuItem" data-id="welcome" href="${ctx}/sys/user/info">
						    <i class="fa fa-user"></i>用户信息
						    </a>
						</li>
						<li>
						    <a href="javascript:changPwd();">
						    <i class="fa fa-trash-o"></i>修改密码
						    </a>
						</li>
						<li class="divider"></li>
						<li><a href="${ctx}/logout"><i class="ace-icon fa fa-power-off"></i>安全退出</a></li>
					</ul>
				</li>
			</ul>
		</div>
		</nav></header>
		<!--左边导航-->
		<div class="main-sidebar" >
			<div class="sidebar">
				<form action="#" method="get" class="sidebar-form">
					<div class="input-group">
						<input type="text" name="q" class="form-control" placeholder="Search...">
						<span class="input-group-btn">
						    <a class="btn btn-flat"> <i class="fa fa-search"></i></a>
						</span>
					</div>
				</form>
				<ul class="sidebar-menu" id="sidebar-menu">
					<!--<li class="header">导航菜单</li>-->
				</ul>
			</div>
		</div>
		<!--中间内容-->
		<div id="content-wrapper" class="content-wrapper">
			<div class="content-tabs">
				<button class="roll-nav roll-left tabLeft">
					<i class="fa fa-backward"></i>
				</button>
				<nav class="page-tabs menuTabs">
				<div class="page-tabs-content" style="margin-left: 0px;">
					<a href="javascript:;" class="menuTab active" data-id="welcome">用户信息</a>
				</div>
				</nav>
				<button class="roll-nav roll-right tabRight">
					<i class="fa fa-forward" style="margin-left: 3px;"></i>
				</button>
				<div class="btn-group roll-nav roll-right">
					<button class="dropdown tabClose" data-toggle="dropdown">
						页签操作 <i class="fa fa-caret-down" style="padding-left: 3px;"></i>
					</button>
					<ul class="dropdown-menu dropdown-menu-right">
						<li><a class="tabReload" href="javascript:void();">刷新当前</a></li>
						<li><a class="tabCloseCurrent" href="javascript:void();">关闭当前</a></li>
						<li><a class="tabCloseAll" href="javascript:void();">全部关闭</a></li>
						<li><a class="tabCloseOther" href="javascript:void();">除此之外全部关闭</a></li>
					</ul>
				</div>
				<button class="roll-nav roll-right fullscreen">
					<i class="fa fa-arrows-alt"></i>
				</button>
			</div>
			<div class="content-iframe" style="overflow: hidden;">
				<div class="mainContent" id="content-main">
					<iframe class="LRADMS_iframe" width="100%" height="100%" src="${ctx}/sys/user/info" frameborder="0" data-id="welcome"></iframe>
				</div>
			</div>
		</div>
	</div>
	<script>
	var ctx = "${ctx}";
	</script>
	<script src="${ctxContent}/ui/jquery/jquery.min.js"></script>
	<script src="${ctxContent}/ui/bootstrap/js/bootstrap.min.js"></script>
	<script src="${ctxContent}/js/index.js"></script>
	<script src="${ctxContent}/js/function.js"></script>
	<script src="${ctxContent}/ui/layui/lay/dest/layui.all.js"></script>
	<script>
	function changPwd(){
		openEditDlg("修改密码", "${ctx}/sys/user/modifyPwd", 450, 250);
	}
	</script>
</body>

</html>