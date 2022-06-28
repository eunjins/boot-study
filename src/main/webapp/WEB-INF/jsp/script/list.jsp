<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en">

<head>
    <!-- App favicon -->
    <link rel="shortcut icon" href="/assets/images/favicon.ico">

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
                            <h2 class="page-title mb-0 font-size-40">스크립트 측정 결과 목록</h2>
                        </div>
                    </div>
                </div>
                <!-- end page title -->
                <!-- start row -->
                <div class="row">
                    <div class="col-xl-12">
                        <div class="row">
                            <div class="col-sm-12 col-md-12" style="text-align: right">
                                <div id="datatable_filter" class="dataTables_filter">
                                    <label>
                                        <select id="select_condition"
                                                name="datatable_type" aria-controls="datatable"
                                                class="custom-select form-control form-select">
                                            <option value="measureName">측정 결과 명</option>
                                            <option value="scriptName">스크립트 명</option>
                                            <option value="uploadPoint">업로드 일자</option>
                                        </select>
                                    </label>
                                    <label id="search_bar">
                                        <input id="search_message" type="search"
                                               class="form-control"
                                               placeholder="검색어를 입력하세요"
                                               aria-controls="datatable" style="text-align: left">
                                    </label>
                                    <button id="button_search" type="button"
                                            class="btn btn-default btn-primary waves-effect waves-light">검색
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <div class="col-sm-12">
                                    <table id="datatable"
                                           class="table table-striped table-bordered dt-responsive nowrap dataTable no-footer dtr-inline"
                                           style="border-collapse: collapse; border-spacing: 0px; width: 100%; text-align: center; outline-style: solid;
                                                  outline-width: thin" ; role="grid" aria-describedby="datatable_info">
                                        <thead>
                                        <tr role="row" bgcolor="#4169e1" style="color: #FFFFFF">
                                            <th class="sorting_asc" tabindex="0" aria-controls="datatable" rowspan="1"
                                                colspan="1" style="width: 5%;" aria-sort="ascending"
                                                aria-label="Name: activate to sort column descending">번호
                                            </th>
                                            <th class="sorting" tabindex="0" aria-controls="datatable" rowspan="1"
                                                colspan="1" style="width: 30%;"
                                                aria-label="Position: activate to sort column ascending">측정 결과 명
                                            </th>
                                            <th class="sorting" tabindex="0" aria-controls="datatable" rowspan="1"
                                                colspan="1" style="width: 30%;"
                                                aria-label="Office: activate to sort column ascending">스크립트 명
                                            </th>
                                            <th class="sorting" tabindex="0" aria-controls="datatable" rowspan="1"
                                                colspan="1" style="width: 22%;"
                                                aria-label="Office: activate to sort column ascending">업로드 일시
                                            </th>
                                            <th class="sorting" tabindex="0" aria-controls="datatable" rowspan="1"
                                                colspan="1"
                                                aria-label="Office: activate to sort column ascending">상태
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody id="table">
                                        </tbody>
                                    </table>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12 col-md-12">
                                        <div class="dataTables_paginate paging_simple_numbers"
                                             id="datatable_paginate">
                                            <ul class="pagination justify-content-center" id="pageNo">
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="button-items">
                                        <a href="${contextPath}/scripts/form">
                                            <button id="add_button" type="button" disabled="disabled"
                                                    class="btn btn-default btn-primary waves-effect waves-light"
                                                    style="float: right">등록
                                            </button>
                                        </a>
                                    </div>
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
    <!-- END layout-wrapper -->
</div>
<!-- end container-fluid -->
<!-- JAVASCRIPT -->
<jsp:include page="/WEB-INF/jsp/common/bottom.jsp"/>
<!-- JAVASCRIPT -->
<script>
    var pageNo = 0;
    var allScriptNo;

    search();

    document.getElementById("button_search").addEventListener("click", initPage, false);
    document.getElementById("button_search").addEventListener("click", search, false);
    document.getElementById("select_condition").addEventListener("change", condition, false);

    function initPage() {
        pageNo = 0;
    }

    function changePage(pageButtonId) {
        pageNo = parseInt(pageButtonId);

        search();
    }

    function condition() {
        const selectCondition = document.getElementById("select_condition").value;
        if (selectCondition == "uploadPoint") {
            document.getElementById("search_bar").innerHTML = '<input id="search_message" class="form-control" type="date" value="">';
        } else {
            document.getElementById("search_bar").innerHTML = '<input id="search_message" type="search"' +
                'class="form-control"' +
                'placeholder="검색어를 입력하세요"' +
                'aria-controls="datatable" style="text-align: left">';
        }
    }

    function search() {
        let searchKeyword = "";
        const selectCondition = document.getElementById("select_condition").value;
        if (selectCondition == "measureName") {
            searchKeyword = {"measureName": document.getElementById("search_message").value, "pageNo": pageNo};
        } else if (selectCondition == "scriptName") {
            searchKeyword = {"scriptName": document.getElementById("search_message").value, "pageNo": pageNo};
        } else {
            searchKeyword = {"uploadPoint": document.getElementById("search_message").value, "pageNo": pageNo};
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/scripts",
            type: "POST",
            data: JSON.stringify(searchKeyword),
            headers: {"Content-Type": "application/json;charset=UTF-8"},
            success: function (rows) {
                drawTable(rows);
            }
        })
    }

    function drawTable(responseJSON) {
        let scripts = responseJSON.scripts;
        let scriptMeasure = responseJSON.scriptMeasure;
        let addButton = responseJSON.addButton;

        allScriptNo = scripts.length;

        let tableHtml = "";


        for (let i = 0; i < allScriptNo; i++) {
            tableHtml +=
                '<tr class="odd">' +
                '<td class="dtr-control sorting_1" tabindex="0">' + (i + (pageNo * 10) + 1) + '</td>' +
                '<td style="text-align: left">' + scriptMeasure[i].name +
                '</td>' +
                '<td style="text-align: left">' + scripts[i].name + '</td>' +
                '<td>' + scripts[i].uploadPoint + '</td>' +
                '<td>';

            if (scriptMeasure[i].status == 'N') {
                tableHtml += '측정중';
            } else {
                tableHtml += '<a href="${contextPath}/scripts/' + scripts[i].no + '">결과 보기</a>';
            }
            tableHtml += '</td>' +
                '</tr>';

        }
        const table = document.getElementById("table");
        table.innerHTML = tableHtml;

        let pageTable = document.getElementById("pageNo");

        pageTable.innerHTML = responseJSON.navigator;

        const targetButton = document.getElementById("add_button");
        if (addButton == 'Y') {
            targetButton.disabled = false;
        } else {
            targetButton.disabled = true;
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

<script src="/assets/js/app.js"></script>

</body>

</html>