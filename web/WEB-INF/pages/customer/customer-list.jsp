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
    <title>客户列表</title>
    <style type="text/css">
        .modal-body input {
            margin: 5px;
            width: 22%;
        }

        .modal-body label {
            display: inline-block;
            width: 50px;
            text-align: right;
        }

        .modal .lb-sex {
            width: 40px;
            text-align: left;
            padding-left: 10px;
        }

        .modal hr {
            margin-top: 6px;
            height: 1px;
            border: none;
            border-top: 1px solid #dddddd;
        }

        .modal .input-2 {
            width: 38%;
        }

        .modal .input-3 {
            width: 17%;
        }

        .modal .input-4 {
            width: 88%;
        }

        .modal #customer_info {
            margin-bottom: 0px;
        }
        .inline{
            display: inline;
        }
        #QRCode{
            position: relative;

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
        <span>选择查询方式：</span>
        <span class="select-box inline">
		<select id="queryBy" name="queryBy" class="select">
			<option value="customer_name">客户姓名</option>
			<option value="customer_company">客户公司</option>
		</select>
		</span>&nbsp;&nbsp;&nbsp;&nbsp;
        <div id="addTime" class="inline" style="display: none;">
            <input type="text" onfocus="WdatePicker({ maxDate:'#F{$dp.$D(\'logmax\')||\'%y-%M-%d\'}' })" id="logmin"
                   class="input-text Wdate" style="width:120px;">
            -
            <input type="text" onfocus="WdatePicker({ minDate:'#F{$dp.$D(\'logmin\')}',maxDate:'%y-%M-%d' })" id="logmax"
                   class="input-text Wdate" style="width:120px;">
        </div>
        <input type="text" name="queryBy-input" id="queryBy-input" placeholder=" 姓名" style="width:200px" class="input-text">
        <button name="search" id="search"onclick="search()" class="btn btn-success" type="submit"><i class="Hui-iconfont">&#xe665;</i> 搜索
        </button>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20"><span class="l"> <a
            class="btn btn-primary radius" data-title="添加客户" onclick="showDetail('add',0)"
            href="javascript:;"><i class="Hui-iconfont">&#xe600;</i> 添加客户</a></span>
        <span class="l ml-10"> <a
            class="btn btn-secondary radius" data-title="导出" onclick=""
            href="<%=path%>/customer-info/export.action?user_id=<s:property value="#session.userInfo.user_id"/>&role_id=<s:property value="#session.userInfo.role_id"/>"><i class="Hui-iconfont">&#xe644;</i> 导出</a></span> <span
            class="r">共有数据：<strong>${fn:length(requestScope.customers)}</strong> 条</span></div>
    <div class="mt-20">
        <table class="table table-border table-bordered table-bg table-hover table-sort">
            <thead>
            <tr class="text-c">
                <th width="50">ID</th>
                <th width="70">姓名</th>
                <th width="50">性别</th>
                <th width="80">状态</th>
                <th width="70">来源</th>
                <th width="70">所属员工</th>
                <th width="60">类型</th>
                <th width="100">手机</th>
                <th width="160">邮箱</th>
                    <th width="80">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${requestScope.customers}" var="customer">
                <tr class="text-c">
                    <td>${customer.customer_id}</td>
                    <td class="text-l"><u style="cursor:pointer" class="text-primary"
                                          onClick="showDetail('name',${customer.customer_id})"
                                          title="详细信息">${customer.customer_name}</u></td>
                    <td>${customer.customer_sex}</td>
                    <td>${customer.condition_name}</td>
                    <td>${customer.source_name}</td>
                    <td>${customer.user_name}</td>
                    <td>${customer.type_name}</td>
                    <td>${customer.customer_mobile}</td>
                    <td><a href="mailto:${customer.customer_email}">${customer.customer_email}</a></td>
                    <td class="f-14 td-manage"><a style="text-decoration:none" class="ml-5"
                                                  onClick="showDetail('edit',${customer.customer_id})"
                                                  href="javascript:;" title="编辑"><i class="Hui-iconfont">
                        &#xe6df;</i></a> <a
                            style="text-decoration:none" class="ml-5"
                            onClick="del('${customer.customer_id}','${customer.customer_name}')"
                            href="javascript:;" title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>
    <div id="modal-detail" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content radius" style="width: 610px;">
                <div class="modal-header">
                    <h3 class="modal-title">客户详细信息</h3>
                    <a class="close" data-dismiss="modal" aria-hidden="true" href="javascript:void(0);">×</a>
                </div>
                <div class="modal-body skin-minimal">
                    <div id="customer_info" class="Huialert Huialert-info">信息状态提示</div>
                    <form id="customer_form" name="customer_form" method="post" action="#">
                        <input type="hidden" id="customer_id" name="customer_id">
                        <label for="customer_name">姓名：</label><input id="customer_name" type="text" name="customer_name"
                                                                     class=" input-text radius" placeholder="客户姓名">
                        <div style="display: inline-block"><label for="">性别：</label>
                            <input id="male" value="male" type="radio" name="customer_sex"><label class="lb-sex" for="male">男</label>
                            <input id="female" value="female" type="radio" name="customer_sex"><label class="lb-sex" for="female">女</label>
                        </div>
                        <br>
                        <label>状态：</label>
                        <span class="select-box inline">
                    <select id="condition_id" name="condition_id" class="select">
                        <option value="0">客户状态</option>
                        <s:iterator value="#request.conditions" var="condition">
                            <option value=${condition.condition_id}>${condition.condition_name}</option>
                        </s:iterator>
                    </select>
                    </span>
                        <label>类型：</label>
                        <span class="select-box inline">
                    <select id="type_id" name="type_id" class="select">
                        <option value="0">客户类型</option>
                        <s:iterator value="#request.types" var="type">
                            <option value=${type.type_id}>${type.type_name}</option>
                        </s:iterator>
                    </select>
                    </span>
                        <label>来源：</label>
                        <span class="select-box inline">
                    <select id="source_id" name="source_id" class="select">
                        <option value="0">客户来源</option>
                        <s:iterator value="#request.sources" var="source">
                            <option value=${source.source_id}>${source.source_name}</option>
                        </s:iterator>
                    </select>
                    </span>
                        <hr>
                        <label for="customer_tel">电话：</label><input type="text" id="customer_tel" name="customer_tel"
                                                                    class=" input-text radius" placeholder="电话">
                        <label for="customer_mobile">手机：</label><input type="text" id="customer_mobile" name="customer_mobile"
                                                                       class=" input-text radius" placeholder="手机">
                        <label for="customer_qq">QQ：</label><input type="text" id="customer_qq" name="customer_qq"
                                                                   class=" input-text radius" placeholder="QQ">
                        <label for="customer_msn">MSN：</label><input type="text" id="customer_msn" name="customer_msn"
                                                                     class=" input-text radius" placeholder="MSN">
                        <label for="birth_day">生日：</label><input type="text" id="birth_day" name="birth_day"
                                                                 onfocus="WdatePicker({ maxDate:'%y-%M-%d' })"
                                                                 class="input-text Wdate radius" placeholder="生日">
                        <label for="customer_job">职业：</label><input type="text" id="customer_job" name="customer_job"
                                                                    class=" input-text radius" placeholder="职业">
                        <label for="customer_email">邮箱：</label><input type="text" id="customer_email" name="customer_email"
                                                                      class="input-2 input-text radius"
                                                                      placeholder="邮箱">
                        <label for="customer_blog">博客：</label><input type="text" id="customer_blog" name="customer_blog"
                                                                     class="input-2 input-text radius" placeholder="博客">
                        <label for="customer_company">公司：</label><input type="text" id="customer_company" name="customer_company"
                                                                        class="input-2 input-text radius"
                                                                        placeholder="公司">
                        <label for="customer_address">地址：</label><input type="text" id="customer_address" name="customer_address"
                                                                        class="input-2 input-text radius"
                                                                        placeholder="地址">
                        <hr>
                        <label for="customer_remark">标记：</label><input type="text" id="customer_remark" name="customer_remark"
                                                                       class="input-4 input-text radius"
                                                                       placeholder="标记">
                        <div class="errorInfo" ></div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button id="btn-submit" onclick="customer_submit()" class="btn btn-primary">确定</button>
                    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
                </div>
            </div>
        </div>
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
            {"orderable": false, "aTargets": [9]}// 不参与排序的列
        ]
    });

    $.validator.addMethod("checkQQ",function(value,element,params){
        var checkQQ = /^[1-9][0-9]{4,19}$/;
        return this.optional(element)||(checkQQ.test(value));
    },"*请输入正确的QQ号码！");

    $.validator.addMethod("checkTel", function(value, element) {
        var length = value.length;
        var tel = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
        return this.optional(element) || (length == 11 && tel.test(value));
    }, "请正确填写您的手机号码");

    function validate(){
        return $("#customer_form").validate({
            rules:{
                customer_name:{
                    required:true,
                    minlength:2,
                    maxlength:4,
                },
                condition_id:{
                    required:true,
                    range:[1,${fn:length(requestScope.conditions)}]
                },type_id:{
                    required:true,
                    range:[1,${fn:length(requestScope.types)}]
                },source_id:{
                    required:true,
                    range:[1,${fn:length(requestScope.sources)}]
                },customer_tel:{
                    required:true,
                    digits:true
                },
                customer_mobile:{
                    required:true,
                    minlength:11,
                    maxlength:11,
                    checkTel:true
                },
                customer_email:{
                    email:true
                },
                customer_qq :{
                    required:true,
                    checkQQ:true
                },
                onsubmit:true,// 是否在提交是验证
                onfocusout:true,// 是否在获取焦点时验证
                onkeyup :true,// 是否在敲击键盘时验证
            },
            messages: {
                customer_name:{
                    required:"必填",
                    minlength:"至少2",
                    maxlength:"最多4",
                },
                condition_id:{
                    required:"必填",
                    range:"选择不正确"
                },type_id:{
                    required:"必填",
                    range:"选择不正确"
                },source_id:{
                    required:"必填",
                    range:"选择不正确"
                },
                customer_tel: {
                    required: "必填",
                    digits:"只能输数字"
                },
                customer_mobile: {
                    required: "必填",
                    minlength:"手机号不正确",
                    maxlength:"手机号不正确",
                    checkTel:"手机号不正确"
                },customer_email:{
                    email:"邮箱格式不正确"
                },customer_qq :{
                    requred:"请输入QQ号",
                    checkQQ:"QQ输入有误"
                }
            },
            errorPlacement: function(error, element){
                console.log(error[0].innerHTML)
//                error.appendTo($(".errorInfo"));
//                $(".errorInfo").text(error[0].innerHTML);
            }

        });
    }

    $(function () {

        //表单验证
        validate();

        //启动iCheck
        $(("[type='radio']")).iCheck({
            checkboxClass: 'icheckbox_minimal-blue',
            radioClass: 'iradio_square-blue'
        });
        /* Modal打开之前执行*/
        $("#modal-detail").on("show.bs.modal", function () {

        });

        //查询条件
        $("#queryBy").change(function () {
            var queryBy = $("#queryBy").val();
            $("#queryBy-input").show();
            $("#addTime").hide();
            if(queryBy == "customer_name"){
                $("#queryBy-input").attr('placeholder',' 姓名');
            }else if(queryBy == "customer_company"){
                $("#queryBy-input").attr('placeholder',' 客户公司');
            }
        })
    })

    function search() {
        var key = $("#queryBy").val();
        var value = $("#queryBy-input").val();
        var url = "<%=path%>/customer-info/search.action?user_id=<s:property value="#session.userInfo.user_id"/>&role_id=<s:property value="#session.userInfo.role_id"/>&"+key+"="+value;
        window.location.replace(url);
    }

    function del(customer_id,customer_name) {
        layer.confirm("确认删除客户\""+customer_name+"\"吗？",{btn:['确定','取消']},function () {
            $.getJSON("<%=path%>/customer-info/delete.action?customer_id=" + customer_id, function (result) {
                if(result.success == true){
                    layer.msg('成功');
                    location.reload();
                }else{
                    layer.msg('失败');
                }
            })
        })

    }

    function getCustomerDetail(customer_id) {
        layer.load();
        $.getJSON("<%=path%>/customer-info/detail.action?id=" + customer_id, function (result) {
//            $.Huimodalalert(result,2000);
            console.log(result);
            if (result.customer_sex == '男') {
                $("#male").iCheck('check');
            } else {
                $("#female").iCheck('check');
            }
            $("#customer_id").val(result.customer_id);
            $("#condition_id").val(result.condition_id);
            $("#type_id").val(result.type_id);
            $("#customer_name").val(result.customer_name);
            $("#source_id").val(result.source_id);
            $("#user_name").val(result.user_name);
            $("#customer_mobile").val(result.customer_mobile);
            $("#customer_email").val(result.customer_email);
            $("#customer_qq").val(result.customer_qq);
            $("#customer_address").val(result.customer_address);
            $("#customer_remark").val(result.customer_remark);
            $("#customer_job").val(result.customer_job);
            $("#customer_blog").val(result.customer_blog);
            $("#customer_tel").val(result.customer_tel);
            $("#customer_msn").val(result.customer_msn);
            $("#birth_day").val(result.birth_day);
            $("#customer_company").val(result.customer_company);
            console.log($("#customer_info").text());
            $("#customer_info").text("客户由\"" + result.customer_addman + "\"在\"" + result.customer_addtime + "\"添加，由\"" + result.change_man + "\"在\"" + result.customer_changtime + "\"修改！");
            layer.closeAll('loading');
        });
    }

    //添加新客户
    function customer_submit() {
        var flag = validate();
        if(!flag.form()){
            layer.msg('数据格式有误，请修改后再试',{icon: 2})
            return;
        }else{
            var sex = $('#male').is(':checked')?'男':'女';
            $("input[name='customer_sex']").val(sex);
            var form = $("#customer_form").serialize();
            $.post("<%=path%>/customer-info/update.action",form,function (result) {
                layer.msg(result,{icon: 1, time: 1000})
                location.reload()
            })
        }
    }

//    //修改客户信息
//    function customer_edit() {
//        layer.msg("Edit",{icon: 1, time: 1000})
//    }

    function showDetail(action,customer_id) {
        console.log(action+"--"+customer_id)
        $('input,select,textarea',$('form[name="customer_form"]')).val("");
        $("#modal-detail").modal("show");
        if(action == 'add'){
            $(".modal-title").text("添加新客户");
            $("#customer_info").hide();
            $("#btn-submit").show();
            $('#male, #female').iCheck('enable');
            $('#male').iCheck('check');
            $('input,select,textarea',$('form[name="customer_form"]')).removeAttr('disabled');
            $('input,select,textarea',$('form[name="customer_form"]')).removeAttr('readonly');
        }else if(action == 'name'){
            getCustomerDetail(customer_id);
            $(".modal-title").text("客户详细信息");
            $("#customer_info").show();
            $("#btn-submit").hide();
            $('#male, #female').iCheck('disable');
            $('select',$('form[name="customer_form"]')).attr('disabled','disabled');
            $('input,textarea',$('form[name="customer_form"]')).attr('readonly',true);
            $("#birth_day").attr('disabled','disabled');
        }else if(action == 'edit'){
            getCustomerDetail(customer_id);
            $(".modal-title").text("修改客户信息");
            $("#customer_info").show();
            $("#btn-submit").show();
            $('#male, #female').iCheck('enable');
            $('input,select,textarea',$('form[name="customer_form"]')).removeAttr('disabled');
            $('input,select,textarea',$('form[name="customer_form"]')).removeAttr('readonly');
        }
    }


</script>
</body>
</html>