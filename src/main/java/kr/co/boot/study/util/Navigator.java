package kr.co.boot.study.util;

import org.springframework.stereotype.Component;

@Component
public class Navigator {
    public String getNavigator(int allNo, int pageNo) {
        StringBuffer navigator = new StringBuffer("");

        if (pageNo == 0) {
            navigator.append("<li class='pagenate_button page-item disabled' ><a id = 'firstPage' ");
        } else {
            navigator.append("<li class='pagenate_button page-item' ><a id = 'firstPage' ");
        }

        navigator.append("href='#' ");
        navigator.append("aria-controls='datatable' ");
        navigator.append("tabindex='0' ");
        navigator.append("class='page-link' onclick='changePage(" + 0 + ")'>&laquo;</a></li> ");

        if ((pageNo / 5) == 0) {
            navigator.append("<li class='paginate_button page-item previous disabled' ");
        } else {
            navigator.append("<li class='paginate_button page-item previous' ");
        }

        navigator.append("id='datatable_previous'>");
        navigator.append("<a href='#' id='backPage' ");
        navigator.append("aria-controls='datatable'");
        navigator.append("        data-dt-idx='0' tabindex='0'");
        navigator.append("        class='page-link' onclick='changePage(" + (((pageNo / 5) * 5) - 5) + ")'>&lt;</a></li>");

        int endPageNo = 0;

        if (((allNo - 1) / 10) + 1 < ((pageNo / 5) * 5) + 5) {
            endPageNo = (allNo - 1) / 10 + 1;
        } else {
            endPageNo = ((pageNo / 5) * 5) + 5;
        }

        int count = 1;
        for (int i = ((pageNo / 5) * 5); i < endPageNo; i++) {
            if (pageNo == i) {
                navigator.append("<li class='paginate_button page-item active'><a href='#' onclick='changePage(" + i + ")'");
            } else {
                navigator.append("<li class='paginate_button page-item'><a href='#' onclick='changePage(" + i + ")'");
            }

            navigator.append(" aria-controls='datatable'");
            navigator.append("        data-dt-idx='" + (count++) + "'");
            navigator.append("        tabindex='0'");
            navigator.append("        class='page-link' >" + (i + 1) + "</a></li>");
        }

        if (endPageNo < (allNo - 1) / 10 + 1) {
            navigator.append("<li class='paginate_button page-item next' id='datatable_next'>");
        } else {
            navigator.append("<li class='paginate_button page-item next disabled' id='datatable_next'>");
        }

        navigator.append("        <a id='nextPage' onclick='changePage(" + (((pageNo / 5) * 5) + 5) + ")'");
        navigator.append("        href='#' aria-controls='datatable' data-dt-idx='" + (count) + "'");
        navigator.append("        tabindex='0' class='page-link' >&gt;</a></li>");

        if (pageNo < (allNo - 1) / 10) {
            navigator.append("<li class='pagenate_button page-item' >");
        } else {
            navigator.append("<li class='pagenate_button page-item disabled' >");
        }

        navigator.append("<a id='lastPage' onclick='changePage(" + ((allNo - 1) / 10) + ")' ");
        navigator.append("href='#' ");
        navigator.append(" aria-controls='datatable' ");
        navigator.append("tabindex='0' ");
        navigator.append("class='page-link'>&raquo;</a></li>");

        return navigator.toString();
    }
}
