package kr.co.boot.study.util;

import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class StatusCode {
    private static final int NOT_MODIFIED = 304;
    private static final int BAD_REQUEST = 400;
    private static final int NOT_FOUND = 404;
    private static final int INTERNAL_SERVER_ERROR = 500;
    private static final String NOT_MODIFIED_MSG = "변경된 사실 없음";
    private static final String BAD_REQUEST_MSG = "잘못된 요청";
    private static final String NOT_FOUND_MSG = "요청 페이지 찾을 수 없음";
    private static final String INTERNAL_SERVER_ERROR_MSG = "내부 서버 오류";
    private static Map<Integer, String> statusRepository = new HashMap<>();

    static {
        statusRepository.put(NOT_MODIFIED, NOT_MODIFIED_MSG);
        statusRepository.put(BAD_REQUEST, BAD_REQUEST_MSG);
        statusRepository.put(NOT_FOUND, NOT_FOUND_MSG);
        statusRepository.put(INTERNAL_SERVER_ERROR, INTERNAL_SERVER_ERROR_MSG);
    }

    public Map<Integer, String> getStatusRepository() {
        return statusRepository;
    }
}
