var loginFlag = 0;
$(function() {
    $(document).keydown(function(event){
        if(event.keyCode==13){
            var mobile = $("#mobile").val();
            var pwd = $("#pwd").val();
            if(mobile!=null&&mobile.length>3&&pwd!=null&&pwd.length>3){mobile
                if(loginFlag==0){
                    $(".loginbtn1").val("正在登录...");
                    loginFlag = 1;
                    $("form").submit();
                }
            }
        }
    });

    $("#userMail").blur(function(){
        //.trim()==""
        if($("#userMail").val()==null||$("#userMail").val()==""){
            $("#userMail").addClass("warm");
        }else{
            $("#userMail").removeClass("warm");
        }
    });
    $("#userPwd").blur(function(){
        if($("#userPwd").val()==null||$("#userPwd").val()==""){
            $("#userPwd").addClass("warm");
        }else{
            $("#userPwd").removeClass("warm");
        }
    });
    var input0 = $('input :eq(0)');
    var input1 = $('input :eq(1)');
    if(input0.val()!=null&&input0.val().length==0){
        input0.focus();
    }else if(input1.val()!=null&&input1.val().length==0){
        input1.focus();
    }else{
        input0.focus();
    }

    $("#userMail").change(function(){
        removeErrorInfo();
    });
    $("#userPwd").change(function(){
        removeErrorInfo();
    });
});

document.onkeydown = function(event) {
    var e = event || window.event || arguments.callee.caller.arguments[0];
    if (e.keyCode == 13) {
        login();
        return false;
    }
};

function login() {
    var flag = true;
    //.trim()
    var userMail = $("#userMail").val();
    var userPwd = $("#userPwd").val();
    if(userMail==""||userMail==null){
        $("#userMail").addClass("warm");
        $("#userMail").focus();
        flag=false;
        return;
    }

    if(userPwd==""||userPwd==null){
        $('#userPwd').addClass("warm");
        $('#userPwd').focus();
        flag=false;
        return;
    }

    if(flag){
        $("#loginForm").submit();
    }
}
function resetBtn(){
    $("input").val("");
}
function removeErrorInfo(){
    $("#loginerrorinfo").html("");
}