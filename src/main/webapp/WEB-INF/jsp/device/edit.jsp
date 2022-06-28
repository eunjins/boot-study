<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en">

<head>
    <!-- jquery.vectormap css -->
    <link href="/assets/libs/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet"
          type="text/css"/>

    <jsp:include page="/WEB-INF/jsp/common/top.jsp"/>

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
                            <h2 class="page-title mb-0 font-size-40">디바이스 상세 정보</h2>
                        </div>
                    </div>
                </div>
                <!-- end page title -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <form action="/devices/${device.id}" method="POST">
                                    <input type="hidden" name="_method" value="put"/>
                                    <input type="hidden" name="id" value="${device.id}"/>
                                    <div class="mb-3 row">
                                        <label class="col-md-2 col-form-label" style="padding-left: 30px">디바이스 ID</label>
                                        <label class="col-md-6 col-form-label">${device.id}</label>
                                    </div>
                                    <div class="mb-3 row">
                                        <label for="example-search-input" class="col-md-2 col-form-label"
                                               style="padding-left: 30px">디바이스 명</label>
                                        <div class="col-md-6">
                                            <input class="form-control" type="text" name="name" value="${device.name}"
                                                   id="example-search-input">
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label class="col-md-2 col-form-label" style="padding-left: 30px">호스트 명</label>
                                        <label class="col-md-6 col-form-label">${device.hostName}</label>
                                    </div>
                                    <div class="mb-3 row">
                                        <label class="col-md-2 col-form-label" style="padding-left: 30px">IP 주소</label>
                                        <label class="col-md-6 col-form-label">${device.ipAddress}</label>
                                    </div>
                                    <div class="mb-3 row">
                                        <label class="col-md-2 col-form-label" style="padding-left: 30px">JDK 버전</label>
                                        <label class="col-md-6 col-form-label">${device.jdkVersion}</label>
                                    </div>
                                    <div class="mb-3 row">
                                        <label class="col-md-2 col-form-label" style="padding-left: 30px">등록 일자</label>
                                        <label class="col-md-6 col-form-label">${device.insertDate}</label>
                                    </div>
                                    <label for="example-search-input" class="col-md-2 col-form-label"
                                           style="padding-left: 18px">상태</label>
                                    <c:choose>
                                        <c:when test="${device.status eq 'Y'}">
                                            <div class="form-check form-check-inline mb-2" style="padding-bottom: 15px">
                                                <input class="form-check-input" type="radio" name="status"
                                                       id="flexRadioDefault1" value="Y" checked="checked">
                                                <label class="form-check-label" for="flexRadioDefault1">활성화</label>
                                            </div>
                                            <div class="form-check form-check-inline mb-2" style="padding-bottom: 15px">
                                                <input class="form-check-input" type="radio" name="status"
                                                       id="flexRadioDefault2" value="N">
                                                <label class="form-check-label" for="flexRadioDefault2">비활성화</label>
                                            </div>
                                        </c:when>
                                        <c:when test="${device.status eq 'N'}">
                                            <div class="form-check form-check-inline mb-2" style="padding-bottom: 15px">
                                                <input class="form-check-input" type="radio" name="status"
                                                       id="flexRadioDefault3" value="Y">
                                                <label class="form-check-label" for="flexRadioDefault3">활성화</label>
                                            </div>
                                            <div class="form-check form-check-inline mb-2" style="padding-bottom: 15px">
                                                <input class="form-check-input" type="radio" name="status"
                                                       id="flexRadioDefault4" value="N" checked="checked">
                                                <label class="form-check-label" for="flexRadioDefault4">비활성화</label>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                    <div class="mb-3 row">
                                        <div class="col-md-12 col-form-label" id="notify" style="padding-left: 30px; color: blue"></div>
                                    </div>

                                    <div class="row">
                                        <div class="button-items">
                                            <a href="${contextPath}/devices/${device.id}">
                                                <button type="button"
                                                        class="btn btn-default btn-primary waves-effect waves-light"
                                                        style="float: right">취소
                                                </button>
                                            </a>
                                            <button type="button" class="btn btn-default btn-primary"
                                                    style="float: right; margin-right: 2%" onclick="editCheck()">
                                                수정
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
                                                            <h4 class="modal-title" id="staticBackdropLabel">수정 확인
                                                            </h4>
                                                            <button type="button" class="btn-close"
                                                                    data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body"
                                                             style="font-size: large; color: blue; text-align: center">
                                                            디바이스를 수정 하시겠습니까?
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="submit"
                                                                    class="btn btn-default btn-primary waves-effect waves-light"
                                                                    style="float: right; margin-right: 5%;
                                                                    padding-left: 4%; padding-right: 4%">예
                                                            </button>
                                                            <button type="button"
                                                                    class="btn btn-default btn-primary waves-effect waves-light"
                                                                    data-bs-dismiss="modal"
                                                                    style="float: right">아니오
                                                            </button>

                                                        </div>
                                                    </div>
                                                    <!-- /.modal-content -->
                                                </div>
                                                <!-- /.modal-dialog -->
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end col -->
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
<script>
    var existName = "${existName}";
    if ("${existName}".equals("Y")) {
        document.getElementById("notify").innerHTML = "이미 존재하는 디바이스명 입니다";
    }

    function editCheck() {
        let deviceName = document.getElementById("example-search-input").value;
        console.log(deviceName);

        if (deviceName == null
            || deviceName.trim() == "") {
            document.getElementById("notify").innerHTML = "디바이스 명을 입력하세요";
        } else {
            jQuery(document).ready(function () {
                $("#staticBackdrop").modal("show");
            });
        }
    }
</script>
<!-- Buttons examples -->
<script src="/assets/libs/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
<script src="/assets/libs/datatables.net-buttons-bs4/js/buttons.bootstrap4.min.js"></script>
<script src="/assets/libs/jszip/jszip.min.js"></script>
<script src="/assets/libs/pdfmake/build/pdfmake.min.js"></script>
<script src="/assets/libs/pdfmake/build/vfs_fonts.js"></script>
<script src="/assets/libs/datatables.net-buttons/js/buttons.html5.min.js"></script>
<script src="/assets/libs/datatables.net-buttons/js/buttons.print.min.js"></script>
<script src="/assets/libs/datatables.net-buttons/js/buttons.colVis.min.js"></script>

<!-- jquery.vectormap map -->
<script src="/assets/libs/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="/assets/libs/admin-resources/jquery.vectormap/maps/jquery-jvectormap-us-merc-en.js"></script>

<script type="text/javascript" src="https://cdn.fusioncharts.com/fusioncharts/latest/fusioncharts.js"></script>
<script type="text/javascript"
        src="https://cdn.fusioncharts.com/fusioncharts/latest/themes/fusioncharts.theme.fusion.js"></script>

</body>

</html>