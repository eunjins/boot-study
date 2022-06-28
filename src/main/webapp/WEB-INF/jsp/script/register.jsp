<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en">

<head>
    <jsp:include page="/WEB-INF/jsp/common/top.jsp"/>
    <!-- DataTables -->
    <link href="/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css">
    <link href="/assets/libs/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css" rel="stylesheet"
          type="text/css">
    <!-- Responsive datatable examples -->
    <link href="/assets/libs/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css" rel="stylesheet"
          type="text/css">
</head>
<body data-layout="horizontal" data-layout-size="boxed"
      style="font-family: 'NanumSquare'; font-size: medium; font-weigth: bold">
<div class="container-fluid">
    <!-- Begin page -->
    <div id="layout-wrapper">
        <jsp:include page="/WEB-INF/jsp/common/menu.jsp"/>
        <!-- ============================================================== -->
        <!-- Start right Content here -->
        <!-- ============================================================== -->
        <div class="main-content">
            <div class="page-content">
                <!-- start page title -->
                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box d-flex align-items-center justify-content-between">
                            <h2 class="page-title mb-0 font-size-40">스크립트 등록</h2>
                        </div>
                    </div>

                </div>
                <!-- end page title -->
                <!-- start row -->
                <div class="row">
                    <div class="col-xl-12">
                        <div class="card">
                            <div class="card-body">
                                <form action="/scripts/distribute" method="POST" enctype="multipart/form-data"
                                      name="registerForm">
                                    <div class="mb-3 row">
                                        <label class="col-md-1 col-form-label"></label>
                                        <label class="col-md-2 col-form-label">측정 결과 명</label>
                                        <div class="col-md-7">
                                            <input class="form-control" type="text" value="" name="name"
                                                   id="measureName">
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label class="col-md-1 col-form-label"></label>
                                        <label class="col-md-2 col-form-label">소스 파일</label>
                                        <div class="col-md-7">
                                            <div class="input-group">
                                                <input type="file" class="form-control hidden" name="sourceFile"
                                                       accept=".java" id="sourcefile">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label class="col-md-1 col-form-label"></label>
                                        <label class="col-md-2 col-form-label">클래스 파일</label>
                                        <div class="col-md-7">
                                            <div class="input-group">
                                                <input type="file" class="form-control" name="classFile"
                                                       accept=".class" id="classfile">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-12 row">
                                    </div>
                                    <label class="col-md-1 col-form-label"></label>
                                    <label class="col-md-6 col-form-label">
                                        <div class=col-form-label" id="register" style="color: blue"></div>
                                    </label>
                                    <div class="button-items">
                                        <a href="${contextPath}/scripts">
                                            <button type="button"
                                                    class="btn btn-default btn-primary waves-effect waves-light"
                                                    style="float: right">목록
                                            </button>
                                        </a>
                                        <label style="float: right"> </label>
                                        <button type="button"
                                                class="btn btn-default btn-primary waves-effect waves-light"
                                                onclick="distribute()" style="float: right; margin-right: 2%">배포
                                        </button>
                                    </div>

                                    <div class="modal-contatiner" id="modal">
                                        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
                                             data-bs-keyboard="false" tabindex="-1"
                                             aria-labelledby="staticBackdropLabel" style="display: none;"
                                             aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title" id="staticBackdropLabel">스크립트 배포
                                                        </h4>
                                                        <button type="button" style="display:none"
                                                                data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body"
                                                         style="font-size: large; color: blue; text-align: center">
                                                        <div class="spinner-border text-primary" role="status"></div>
                                                        <div style="padding-top: 10px">스크립트를 배포 중 입니다. 잠시만 기다려주세요.</div>
                                                    </div>
                                                    <div class="modal-footer">
                                                    </div>
                                                </div>
                                                <!-- /.modal-content -->
                                            </div>
                                            <!-- /.modal-dialog -->
                                        </div>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end row -->
            </div>
            <!-- End Page-content -->
        </div>
        <!-- end main content-->
    </div>
    <!-- END layout-wrapper -->
</div>
<!-- end container-fluid -->
<!-- JAVASCRIPT -->
<jsp:include page="/WEB-INF/jsp/common/bottom.jsp"/>
<!-- jquery.vectormap map -->
<script src="/assets/libs/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="/assets/libs/admin-resources/jquery.vectormap/maps/jquery-jvectormap-us-merc-en.js"></script>
<script>
    document.getElementById("register").innerHTML = "${distributeFail}";

    var registerInfo;

    function distribute() {
        registerInfo = {
            registerForm: document.registerForm,
            name: document.getElementById("measureName").value,
            sourcefile: document.getElementById("sourcefile").value,
            classfile: document.getElementById("classfile").value
        };

        if (registerInfo.name == null
            || registerInfo.name.trim() == "") {
            document.getElementById("register").innerHTML = "측정 결과 명을 입력하세요";
        } else if (registerInfo.sourcefile == null || registerInfo.sourcefile == "" ||
            registerInfo.classfile == null || registerInfo.classfile == "") {
            document.getElementById("register").innerHTML = "스크립트 파일을 선택하세요";
        } else if (registerInfo.sourcefile.split(".").pop() != "java" ||
            registerInfo.classfile.split(".").pop() != "class") {
            document.getElementById("register").innerHTML = "스크립트 확장자를 확인하세요"
        } else if (registerInfo.sourcefile.split("\\").pop().split(".")[0] !=
                   registerInfo.classfile.split("\\").pop().split(".")[0]) {
            document.getElementById("register").innerHTML = "스크립트 파일을 확인하세요"
        } else {
            jQuery(document).ready(function () {
                $("#staticBackdrop").modal("show");
            });

            registerInfo.registerForm.submit();
        }
    }
</script>

</body>

</html>