package kr.co.boot.study.script;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Service
public class AttachServiceImpl implements AttachService {
    @Autowired
    private AttachRepository attachRepository;

    @Override
    public List<Attach> getAttaches(Attach attach) {
        return attachRepository.selectAll(attach);
    }

    @Value("${scriptPath}")
    private String path;

    @Override
    public Attach getAttach(Attach attach) {
        return attachRepository.select(attach);
    }
    
    @Override
    public void registerAttach(MultipartFile sourceFile,
                               MultipartFile classFile, Attach attach) throws IOException {
        String sourceFileExtension = FilenameUtils.getExtension(sourceFile.getOriginalFilename());
        String classFileExtension = FilenameUtils.getExtension(classFile.getOriginalFilename());

        LocalDate date = LocalDate.now();
        if ("java".equals(sourceFileExtension)) {
            String physicalName = String.valueOf(date) + UUID.randomUUID();

            attach.setPhysicName(physicalName);
            attach.setDivision("S");
            attach.setName(FilenameUtils.getBaseName(sourceFile.getOriginalFilename()));

            attachRepository.insert(attach);

            File directory = new File(path);
            if (!directory.isDirectory()) {
                directory.mkdir();
            }

            sourceFile.transferTo(new File(path + File.separator + physicalName));
        }

        if ("class".equals(classFileExtension)) {
            String physicalName = String.valueOf(date) + UUID.randomUUID();

            attach.setPhysicName(physicalName);
            attach.setDivision("C");
            attach.setName(FilenameUtils.getBaseName(classFile.getOriginalFilename()));

            attachRepository.insert(attach);

            File directory = new File(path);
            if (!directory.isDirectory()) {
                directory.mkdir();
            }

            classFile.transferTo(new File(path + File.separator + physicalName));
        }
    }
}
