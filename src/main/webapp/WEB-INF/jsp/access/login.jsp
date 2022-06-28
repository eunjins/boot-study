<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page trimDirectiveWhitespaces="true" %>

<!DOCTYPE HTML>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/jsp/common/top.jsp"/>

</head>

<body style="font-family: 'NanumSqaure'">
<div class="account-pages my-5 pt-sm-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6 col-xl-5">
                <div class="card overflow-hidden" style="border: 2px ridge whitesmoke">
                    <div class="bg-login text-center">
                        <div class="bg-login-overlay"></div>
                        <div class="position-relative">
                            <h5 class="text-white" style="font-size: x-large;">디바이스 성능 측정 통합 시스템</h5>
                        </div>
                    </div>
                    <div class="card-body pt-5">
                        <div class="p-2"
                             style="margin-top: 7%;">
                            <form name="loginForm" class="form-horizontal" action="/login" method="POST">
                                <div class="mb-3">
                                    <input type="text" class="form-control" id="id" name="id"
                                           style="font-size: large;" placeholder="아이디">
                                </div>

                                <div class="mb-3">
                                    <input type="password" class="form-control" id="password" name="password"
                                           style="font-size: large" placeholder="비밀번호">
                                </div><br/>

                                <div class="mb-3" id="checkLogIn" style="color: blue"></div>

                                <div class="mt-3">
                                    <button class="btn btn-default btn-primary w-100 waves-effect waves-light"
                                            style="font-size: large" type="button" onclick="login()">
                                        로그인</button>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JAVASCRIPT -->
<jsp:include page="/WEB-INF/jsp/common/bottom.jsp"/>

<script>
    var missMatch = document.getElementById("checkLogIn").innerHTML = "${missMatch}";

    function login() {
        var loginInfo = {
            loginForm: document.loginForm,
            id: document.getElementById("id").value,
            password: document.getElementById("password").value
        };
        console.log(loginInfo);

        if (loginInfo.id == null || loginInfo.password == null
            || loginInfo.id == "" || loginInfo.password == "") {
            document.getElementById("checkLogIn").innerHTML = "로그인 정보를 입력하세요";
        } else {
            loginInfo.loginForm.submit();

        }
    }
</script>

</body>
</html>