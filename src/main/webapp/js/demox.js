function showLoginModal() {
    $("#login_modal").modal('show');
}
function showRegisterModal() {
    $("#login_modal").modal('toggle');
    $("#register_modal").modal('show');
}

function showResetModal() {
    $("#reset_modal").modal('show');
}
function showClearModal() {
    $("#clear_modal").modal('show');
}

function showSignModal() {
    $("#sign_modal").modal('show');
}

function sparkLogin(base) {
  window.location.href=base+"/account?action=sparkLogin";
}

function ajaxLoad(url, data, callback) {
    $.ajax({
        url: url,
        type: 'POST',
        async: true,
        data: data,
        dataType: 'json',
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("加载数据失败" +url+ XMLHttpRequest.status);
        },
        success: function (result) {
            callback(result);
        }
    });
}

function doRegister(base,acc, pswd) {
    var account = {
        userAccount: acc,
        userPassword: pswd
    };
    var localObj = window.location;

    var contextPath = localObj.pathname.split("/")[1];

    ajaxLoad(base+"/account?action=register", account, registerCallback);
}

function registerCallback(data) {
    if (data.error != null) {
        alert(data.error);
    } else {
        alert("账号注册成功，请登录");
        $("#register_modal").modal('toggle');
        $("#login_modal").modal('show');
    }
}

    function doLogin(base,acc, pswd) {
        var account = {
            userAccount: acc,
            userPassword: pswd
        };
        ajaxLoad(base+"/account?action=login", account, function(data) {

            if (data.ret == 1) {
                $("#login_modal").modal('toggle');
                window.location.href = base;
            }else if (data.ret == 0){
                alert(data.msg);
            }else{
                alert("账号不存在，请先注册");
            }


        });
    }




    //window.location.href = "/";
