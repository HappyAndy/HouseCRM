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
    <%@include file="../header.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=path%>/lib/iCheck/1.0.2/skins/all.css"/>
    <title>客户来源</title>
    <style type="text/css">

    </style>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 客户相关 <span
        class="c-gray en">&gt;</span> 客户来源 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px"
                                              href="javascript:location.replace(location.href);" title="刷新"><i
        class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">

    <div class="cl pd-5 bg-1 bk-gray"><span class="l"> <a
            class="btn btn-primary radius" data-title="添加来源" onclick="add()"
            href="javascript:;"><i class="Hui-iconfont">&#xe600;</i> 添加来源</a></span> <span
            class="r">共有数据：<strong>${fn:length(requestScope.sources)}</strong> 条</span></div>
    <div class="mt-20">
        <table class="table table-border table-bordered table-bg table-hover table-sort">
            <thead>
            <tr class="text-c">
                <th width="50">ID</th>
                <th width="70">来源名称</th>
                <th width="80">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${requestScope.sources}" var="source">
                <tr class="text-c">
                    <td>${source.source_id}</td>
                    <td>${source.source_name}</td>
                    <td class="f-14 td-manage"><a style="text-decoration:none" class="ml-5"
                                                  onClick="edit(${source.source_id},'${source.source_name}')"
                                                  href="javascript:;" title="编辑"><i class="Hui-iconfont">
                        &#xe6df;</i></a> <a
                            style="text-decoration:none" class="ml-5"
                            onClick="del(${source.source_id},'${source.source_name}')"
                            href="javascript:;" title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>

</div>
<!--_footer 作为公共模版分离出去-->
<jsp:include page="../footer.jsp"/>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="<%=path%>/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript"
        src="<%=path%>/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="<%=path%>/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="<%=path%>/lib/iCheck/1.0.2/icheck.min.js"></script>
<script type="text/javascript">

    $('.table-sort').dataTable({
        //"aaSorting": [[1, "desc"]],//默认第几个排序
        "bStateSave": true,//状态保存
        "aoColumnDefs": [
            //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
            {"orderable": false, "aTargets": [2]}// 不参与排序的列
        ]
    });

    function edit(source_id,source_name) {
        //formType：输入框类型，支持0（文本）默认1（密码）2（多行文本）
        layer.prompt({title: '修改类型名称',value:source_name, formType: 0},function(val, index){
            if(source_name == val){
                layer.msg('内容未修改');
            }else{
                $.getJSON('<%=path%>/customer-source/update.action?source_id='+source_id+'&source_name='+val,function (result) {
//                    console.log(result)
                    if (result.success == true){
                        layer.msg('修改成功');
                        refresh();
                    }else{
                        layer.msg('修改失败');
                    }
                })

            }
//            layer.msg('得到了'+val);
            layer.close(index);
        });
    }

    function refresh() {
        window.location.replace('<%=path%>/customer-source/list.action');
    }
    function del(source_id,source_name) {
        layer.confirm('删除类型\"'+source_name+'\"？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.getJSON('<%=path%>/customer-source/delete.action?source_id='+source_id,function (result) {
                if (result.success == true) {
                    layer.msg('删除成功', {icon: 1});
                    refresh();
                }else{
                    layer.msg('删除失败', {icon: 2});
                }
            })
        });
    }

    $(function () {

    })

    function add() {
        layer.prompt({title: '添加新来源', formType: 0},function(val, index){
            $.getJSON('<%=path%>/customer-source/add.action?source_name='+val,function (result) {
//                    console.log(result)
                if (result.success == true){
                    layer.msg('添加成功');
                    refresh();
                }else{
                    layer.msg('添加失败');
                }
            })
//            layer.msg('得到了'+val);
            layer.close(index);
        });
    }

    function del(source_id,source_name) {
        layer.confirm('删除类型\"'+source_name+'\"？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.getJSON('<%=path%>/customer-source/delete.action?source_id='+source_id,function (result) {
                if (result.success == true) {
                    layer.msg('删除成功', {icon: 1});
                    refresh();
                }else{
                    layer.msg('删除成功', {icon: 2});
                }
            })
        });
    }

</script>
</body>
</html>