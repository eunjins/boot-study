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
    <!-- NanumSquare -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css">
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
                            <h2 class="page-title mb-0 font-size-40">스크립트 측정 결과</h2>
                        </div>
                    </div>
                </div>
                <!-- end page title -->
                <!-- start row -->
                <div class="row">
                    <div class="col-xl-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="mb-3 row">
                                    <div class="col-md-6">
                                        <label class="col-md-4 col-form-label" style="padding-left: 30px">
                                            측정 결과 명
                                        </label>
                                        <label class="col-md-6 col-form-label"
                                               style="text-align: left">${measures[0].name}</label>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <div class="col-md-6">
                                        <label class="col-md-4 col-form-label" style="padding-left: 30px">
                                            스크립트 명
                                        </label>
                                        <label class="col-md-6 col-form-label"
                                               style="text-align: left">${script.name}</label>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <div class="col-md-6">
                                        <label class="col-md-4 col-form-label" style="padding-left: 30px">
                                            업로드 일시
                                        </label>
                                        <label class="col-md-6 col-form-label"
                                               style="text-align: left">${script.uploadPoint}</label>
                                    </div>

                                </div>
                                <c:forEach items="${attaches}" var="attach">
                                    <c:choose>
                                        <c:when test="${attach.division eq 'S'}">
                                            <div class="mb-3 row">
                                                <div class="col-md-6">
                                                    <label class="col-md-4 col-form-label" style="padding-left: 30px">
                                                        소스 파일
                                                    </label>
                                                    <label class="col-md-6 col-form-label">
                                                        <a href="/scripts/file/${attach.no}">${attach.name}.java</a>
                                                    </label>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:when test="${attach.division eq 'C'}">
                                            <div class="mb-3 row">
                                                <div class="col-md-6">
                                                    <label class="col-md-4 col-form-label" style="padding-left: 30px">
                                                        클래스 파일
                                                    </label>
                                                    <label class="col-md-6 col-form-label">
                                                        <a href="/scripts/file/${attach.no}">${attach.name}.class</a>
                                                    </label>
                                                </div>

                                                <div class="col-md-6">
                                                    <a href="${contextPath}/scripts/excel/${script.no}">
                                                        <button type="button"
                                                                class="btn btn-default btn-primary waves-effect waves-light"
                                                                style="float: right; margin-right: 10px"><span>엑셀 다운로드</span>
                                                        </button>
                                                    </a>
                                                </div>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                                <div id="datatable-buttons_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">
                                    <div class="row">
                                        <div class="col-sm-12" style="padding-top: 10px;">
                                            <table
                                                    class="table table-striped table-bordered dt-responsive nowrap no-footer dtr-inline"
                                                    style="border-collapse: collapse; border-spacing: 0px; width: 100%; text-align: center; outline-style: solid;
                                                    outline-width: thin" ;
                                                    role="grid" aria-describedby="datatable_info">
                                                <thead>
                                                <tr role="row" bgcolor="#4169e1" style="color: #FFFFFF">
                                                    <th class="sorting_asc" tabindex="0" aria-controls="datatable"
                                                        rowspan="1"
                                                        colspan="1" style="width: 50px;" aria-sort="ascending"
                                                        aria-label="번호: activate to sort column descending">
                                                        <div style="text-align: center">번호</div>
                                                    </th>
                                                    <th class="sorting" tabindex="0" aria-controls="datatable"
                                                        rowspan="1"
                                                        colspan="1" style="width: 270px;"
                                                        aria-label="디바이스 명: activate to sort column ascending">
                                                        <div style="text-align: center">디바이스 명</div>
                                                    </th>
                                                    <th class="sorting" tabindex="0" aria-controls="datatable"
                                                        rowspan="1"
                                                        colspan="1" style="width: 270px;"
                                                        aria-label="실행 시간 (ms): activate to sort column ascending">
                                                        <div style="text-align: center">실행 시간 (ms)</div>
                                                    </th>
                                                </tr>
                                                </thead>
                                                <tbody id="measureList">
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div id="row">
                                    <div class="col-md-12" style="padding-top: 15px">
                                        <table id="chartable"
                                               class="table table-bordered dt-responsive nowrap dataTable no-footer dtr-inline"
                                               style="border-collapse: collapse; border-spacing: 0px; width: 100%;"
                                               role="grid" aria-describedby="datatable_info">
                                            <div class="col-sm-12" id="chart-container"></div>
                                        </table>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="button-items" style="padding-top: 10px">
                                        <a href="${contextPath}/scripts">
                                            <button type="button"
                                                    class="btn btn-default btn-primary waves-effect waves-light"
                                                    style="float: right">목록
                                            </button>
                                        </a>
                                    </div>
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
    </div>
    <!-- END layout-wrapper -->
</div>
<!-- end container-fluid -->
<!-- JAVASCRIPT -->
<jsp:include page="/WEB-INF/jsp/common/bottom.jsp"/>
<!-- Buttons examples -->
<script src="/assets/libs/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
<script src="/assets/libs/datatables.net-buttons-bs4/js/buttons.bootstrap4.min.js"></script>
<script src="/assets/libs/jszip/jszip.min.js"></script>
<script src="/assets/libs/pdfmake/build/pdfmake.min.js"></script>
<script src="/assets/libs/pdfmake/build/vfs_fonts.js"></script>
<script src="/assets/libs/datatables.net-buttons/js/buttons.html5.min.js"></script>
<script src="/assets/libs/datatables.net-buttons/js/buttons.print.min.js"></script>
<script src="/assets/libs/datatables.net-buttons/js/buttons.colVis.min.js"></script>
<!-- Responsive examples -->
<script src="/assets/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
<script src="/assets/libs/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>
<!-- Datatable init js -->
<script src="/assets/js/pages/datatables.init.js"></script>
<script type="text/javascript" src="https://cdn.fusioncharts.com/fusioncharts/latest/fusioncharts.js"></script>
<script type="text/javascript"
        src="https://cdn.fusioncharts.com/fusioncharts/latest/themes/fusioncharts.theme.fusion.js"></script>
<script type="text/javascript">
    var deviceNames = [];
    var execTimes = [];

    const chartData = [
        <c:forEach items="${measures}" var="measure" varStatus="object">
            <c:if test="${measure.distributeStatus eq 'Y'}">
            {
                "label": "${measure.deviceName}",
                "value": "${measure.execTime}",
                "color": "#" + Math.floor(Math.random() * 16777215).toString(16)
            },
            </c:if>
        </c:forEach>
    ];

    const chartConfig = {
        type: 'column3d',
        renderAt: 'chart-container',
        width: '100%',
        height: '400',
        dataFormat: 'json',
        dataSource: {
            "chart": {
                "yAxisName": "실행 시간 (ms)",
                "theme": "fusion",
                "showBorder": 1
            },
            "data": chartData
        }
    };
    FusionCharts.ready(function () {
        var fusioncharts = new FusionCharts(chartConfig);
        fusioncharts.render();
    });

</script>
<script type="text/javascript">
    let measureList = document.getElementById("measureList");
    let listHtml = "";
    <c:forEach items="${measures}" var="measure" varStatus="object">
    listHtml += '<tr class="odd">' +
        '<td class="dtr-control sorting_1" tabindex="0" style="text-align: center">${object.count}</td>' +
        '<td style="text-align: left">${measure.deviceName}</td>';
        <c:if test="${measure.distributeStatus eq 'N'}">
            listHtml += '<td id=execTime style="text-align:right">' + '배포 실패' + '</td>' + '</tr>';
        </c:if>
        <c:if test="${measure.distributeStatus eq 'Y' && measure.status eq 'N'}">
            listHtml += '<td id=execTime style="text-align:right">' + '측정 실패' + '</td>' + '</tr>';
        </c:if>
        <c:if test="${measure.status eq 'Y' && measure.distributeStatus eq 'Y'}">
            listHtml += '<td id=execTime style="text-align:right">' + Number(${measure.execTime}).toLocaleString('en') + '</td>' + '</tr>';
        </c:if>
    </c:forEach>

    measureList.innerHTML = listHtml;

</script>

</body>

</html>