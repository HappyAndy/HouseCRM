<%--
  Created by IntelliJ IDEA.
  User: Kevin
  Date: 2017/2/16
  Time: 10:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<head>
    <%--<jsp:include page="header.jsp"/>--%>
    <%@include file="header.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/lib/icheck/icheck.css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/lib/icheck/jquery.icheck.min.js" ></script>
    <title>客户列表</title>
    <style type="text/css">
        .modal-body input{
            margin: 5px;
        }
    </style>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 客户相关 <span
        class="c-gray en">&gt;</span> 客户信息 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px"
                                              href="javascript:location.replace(location.href);" title="刷新"><i
        class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <div class="text-c">
        <button onclick="removeIframe()" class="btn btn-primary radius">关闭选项卡</button>
        <span class="select-box inline">
		<select name="" class="select">
			<option value="0">客户类型</option>
            <s:iterator value="#request.types" var="type" status="status">
                <option value=${status.count}>${type}</option>
            </s:iterator>
		</select>
		</span> 日期范围：
        <input type="text" onfocus="WdatePicker({ maxDate:'#F{$dp.$D(\'logmax\')||\'%y-%M-%d\'}' })" id="logmin"
               class="input-text Wdate" style="width:120px;">
        -
        <input type="text" onfocus="WdatePicker({ minDate:'#F{$dp.$D(\'logmin\')}',maxDate:'%y-%M-%d' })" id="logmax"
               class="input-text Wdate" style="width:120px;">
        <input type="text" name="" id="" placeholder=" 姓名" style="width:250px" class="input-text">
        <button name="" id="search" class="btn btn-success" type="submit"><i class="Hui-iconfont">&#xe665;</i> 搜索
        </button>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20"><span class="l"><a href="javascript:;" onclick="datadel()"
                                                               class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <a
            class="btn btn-primary radius" data-title="添加资讯" data-href="article-add.html" onclick="Hui_admin_tab(this)"
            href="javascript:;"><i class="Hui-iconfont">&#xe600;</i> 添加客户</a></span> <span
            class="r">共有数据：<strong>${fn:length(requestScope.customers)}</strong> 条</span></div>
    <div class="mt-20">
        <table class="table table-border table-bordered table-bg table-hover table-sort">
            <thead>
            <tr class="text-c">
                <th width="25"><input type="checkbox" name="" value=""></th>
                <th width="50">ID</th>
                <th width="70">姓名</th>
                <th width="50">性别</th>
                <th width="80">身份</th>
                <th width="70">来源</th>
                <th width="70">销售人员</th>
                <th width="60">类型</th>
                <th width="100">手机</th>
                <th width="160">邮箱</th>
                <th width="80">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${requestScope.customers}" var="customer">
                <tr class="text-c">
                    <td><input type="checkbox" value="" name=""></td>
                    <td>${customer.customer_id}</td>
                    <td class="text-l"><u style="cursor:pointer" class="text-primary" onClick="showDetail(${customer.customer_id})"
                                          title="详细信息">${customer.customer_name}</u></td>
                    <td>${customer.customer_sex}</td>
                    <td>${customer.condition_name}</td>
                    <td>${customer.source_name}</td>
                    <td>${customer.user_name}</td>
                    <td>${customer.type_name}</td>
                    <td>${customer.customer_mobile}</td>
                    <td><a href="mailto:${customer.customer_email}">${customer.customer_email}</a></td>
                    <td class="f-14 td-manage"><a style="text-decoration:none" class="ml-5"
                                                  onClick="article_edit('资讯编辑','article-add.html','${customer.customer_id}')"
                                                  href="javascript:;" title="编辑"><i class="Hui-iconfont">
                        &#xe6df;</i></a> <a
                            style="text-decoration:none" class="ml-5"
                            onClick="article_del(this,'${customer.customer_id}')"
                            href="javascript:;" title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>
    <div id="modal-detail" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content radius">
                <div class="modal-header">
                    <h3 class="modal-title">客户详细信息</h3>
                    <a class="close" data-dismiss="modal" aria-hidden="true" href="javascript:void(0);">×</a>
                </div>
                <div class="modal-body skin-minimal">
                    <label for="customer_name">姓名：</label><input id="customer_name" type="text" class=" input-text radius" placeholder="客户姓名">
                    <div class="radio-box"><input type="radio" id="radio-male" name="demo-radio1"> <label for="radio-male">男</label></div>
                    <div class="radio-box"><input type="radio" id="radio-female" name="demo-radio1"> <label for="radio-female">女</label></div><br>
                    <label for="condition_name">身份：</label><input type="text" id="condition_name" class=" input-text radius" placeholder="客户姓名">
                    <label for="condition_name">来源：</label><input type="text" id="source_name" class=" input-text radius" placeholder="客户姓名">
                    <label for="condition_name">销售：</label><input type="text" id="user_name" class=" input-text radius" placeholder="客户姓名">
                    <label for="condition_name">类型：</label><input type="text" id="type_name" class=" input-text radius" placeholder="客户姓名">
                    <label for="condition_name">电话：</label><input type="text" id="customer_mobile" class=" input-text radius" placeholder="客户姓名">
                    <label for="condition_name">邮箱：</label><input type="text" id="customer_email" class=" input-text radius" placeholder="客户姓名">
                    <label for="condition_name">QQ：</label><input type="text" id="customer_qq" class=" input-text radius" placeholder="客户姓名">
                    <label for="condition_name">地址：</label><input type="text" id="customer_address" class=" input-text radius" placeholder="客户姓名">
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" data-dismiss="modal">确定</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!--_footer 作为公共模版分离出去-->
<jsp:include page="footer.jsp"/>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="<%=request.getContextPath()%>/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript"
        src="<%=request.getContextPath()%>/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
    $('.table-sort').dataTable({
        "aaSorting": [[1, "desc"]],//默认第几个排序
        "bStateSave": true,//状态保存
        "aoColumnDefs": [
            //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
            {"orderable": false, "aTargets": [0, 8]}// 不参与排序的列
        ]
    });

    /* Modal打开之前执行*/
    $(function () {
        $("#modal-detail").on("show.bs.modal",function () {

        });
    })

    function showDetail(customer_id) {
        $.getJSON("${pageContext.request.contextPath}/customer/detail?id="+customer_id,function (result) {
//            $.Huimodalalert(result,2000);
            console.log(result);
            $("#modal-detail").modal("show");
        });
    }

    /*资讯-添加*/
    function article_add(title, url, w, h) {
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*资讯-编辑*/
    function article_edit(title, url, id, w, h) {
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*资讯-删除*/
    function article_del(obj, id) {
        layer.confirm('确认要删除吗？', function (index) {
            $.ajax({
                type: 'POST',
                url: '',
                dataType: 'json',
                success: function (data) {
                    $(obj).parents("tr").remove();
                    layer.msg('已删除!', {icon: 1, time: 1000});
                },
                error: function (data) {
                    console.log(data.msg);
                },
            });
        });
    }

    /*资讯-审核*/
    function article_shenhe(obj, id) {
        layer.confirm('审核文章？', {
                btn: ['通过', '不通过', '取消'],
                shade: false,
                closeBtn: 0
            },
            function () {
                $(obj).parents("tr").find(".td-manage").prepend('<a class="c-primary" onClick="article_start(this,id)" href="javascript:;" title="申请上线">申请上线</a>');
                $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已发布</span>');
                $(obj).remove();
                layer.msg('已发布', {icon: 6, time: 1000});
            },
            function () {
                $(obj).parents("tr").find(".td-manage").prepend('<a class="c-primary" onClick="article_shenqing(this,id)" href="javascript:;" title="申请上线">申请上线</a>');
                $(obj).parents("tr").find(".td-status").html('<span class="label label-danger radius">未通过</span>');
                $(obj).remove();
                layer.msg('未通过', {icon: 5, time: 1000});
            });
    }
    /*资讯-下架*/
    function article_stop(obj, id) {
        layer.confirm('确认要下架吗？', function (index) {
            $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="article_start(this,id)" href="javascript:;" title="发布"><i class="Hui-iconfont">&#xe603;</i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="label label-defaunt radius">已下架</span>');
            $(obj).remove();
            layer.msg('已下架!', {icon: 5, time: 1000});
        });
    }

    /*资讯-发布*/
    function article_start(obj, id) {
        layer.confirm('确认要发布吗？', function (index) {
            $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="article_stop(this,id)" href="javascript:;" title="下架"><i class="Hui-iconfont">&#xe6de;</i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已发布</span>');
            $(obj).remove();
            layer.msg('已发布!', {icon: 6, time: 1000});
        });
    }
    /*资讯-申请上线*/
    function article_shenqing(obj, id) {
        $(obj).parents("tr").find(".td-status").html('<span class="label label-default radius">待审核</span>');
        $(obj).parents("tr").find(".td-manage").html("");
        layer.msg('已提交申请，耐心等待审核!', {icon: 1, time: 2000});
    }

</script>
</body>
</html>