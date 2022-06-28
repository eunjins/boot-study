package kr.co.boot.study.script;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service
public interface AttachService {
    public List<Attach> getAttaches(Attach attach);

    public Attach getAttach(Attach attach);

    public void registerAttach(MultipartFile sourceFile,
                               MultipartFile classFile, Attach attach) throws IOException;
}
