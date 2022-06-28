package kr.co.boot.study.script;

import okhttp3.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.stereotype.Repository;

import java.io.File;
import java.io.IOException;

@Repository
public class ScriptFileRepositoryImpl implements ScriptFileRepository {
    private static final MediaType MULTIPART = MediaType.parse("multipart/form-data");

    @Value("${protocol}")
    private String http;

    @Value("${port}")
    private String port;

    @Value("${url}")
    private String url;

    @Override
    public boolean distribute(File classFile, String encryptResult, String ip) throws Exception {
        String requestUrl = http + ip + port + url;

        OkHttpClient client = new OkHttpClient();

        RequestBody requestBody = new MultipartBody.Builder()
                .setType(MultipartBody.FORM)
                .addFormDataPart("encryptId", encryptResult)
                .addFormDataPart("scriptFile", classFile.getName()
                        , RequestBody.create(MULTIPART, classFile)).build();

        Request request = new Request.Builder()
                .url(requestUrl)
                .post(requestBody)
                .build();

        Response response = client.newCall(request).execute();

        ResponseBody responseBody = response.body();
        JSONObject jsonResponse = new JSONObject(responseBody.string());
        if (!"200".equals(jsonResponse.getString("code"))) {
            throw new IOException(jsonResponse.getString("message"));
        }

        return true;
    }
}
