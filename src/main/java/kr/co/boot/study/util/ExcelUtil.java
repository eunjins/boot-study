package kr.co.boot.study.util;

import kr.co.boot.study.device.Device;
import kr.co.boot.study.device.DeviceService;
import kr.co.boot.study.measure.Measure;
import kr.co.boot.study.measure.MeasureService;
import kr.co.boot.study.script.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Component
public class ExcelUtil {
    @Value("${excelPath}")
    private String excelPath;

    @Autowired
    private MeasureService measureService;

    @Autowired
    private DeviceService deviceService;

    public File createExcel(Script script) throws IOException {
        List<Measure> measures =
                measureService.getMeasures(new Measure(script.getNo()));

        XSSFWorkbook workbook = new XSSFWorkbook();

        XSSFSheet sheet = workbook.createSheet(measures.get(0).getName());

        sheet.setColumnWidth(0, 1400);
        sheet.setColumnWidth(1, 8000);
        sheet.setColumnWidth(2, 4000);

        XSSFCellStyle centerStyle = workbook.createCellStyle();
        centerStyle.setAlignment(HorizontalAlignment.CENTER);
        centerStyle.setBorderLeft(BorderStyle.MEDIUM);
        centerStyle.setBorderRight(BorderStyle.MEDIUM);

        XSSFCellStyle title = workbook.createCellStyle();
        title.setAlignment(HorizontalAlignment.CENTER);

        title.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        title.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        title.setBorderTop(BorderStyle.MEDIUM);
        title.setBorderLeft(BorderStyle.MEDIUM);
        title.setBorderRight(BorderStyle.MEDIUM);
        title.setBorderBottom(BorderStyle.MEDIUM);

        XSSFCellStyle rowStyle = workbook.createCellStyle();
        rowStyle.setBorderLeft(BorderStyle.MEDIUM);
        rowStyle.setBorderRight(BorderStyle.MEDIUM);

        XSSFCellStyle noStyle = workbook.createCellStyle();
        noStyle.setBorderLeft(BorderStyle.MEDIUM);
        noStyle.setBorderRight(BorderStyle.MEDIUM);
        XSSFDataFormat dataFormat = (XSSFDataFormat) workbook.createDataFormat();
        noStyle.setDataFormat(dataFormat.getFormat("#,###0"));

        XSSFCellStyle bottomStyle = workbook.createCellStyle();
        bottomStyle.setBorderTop(BorderStyle.MEDIUM);

        XSSFRow row = sheet.createRow(1);
        Cell cell = row.createCell(1);
        cell.setCellValue("측정 결과 명");
        cell.setCellStyle(title);

        cell = row.createCell(2);
        cell.setCellValue("스크립트 명");
        cell.setCellStyle(title);

        row = sheet.createRow(2);

        cell = row.createCell(1);
        cell.setCellValue(measures.get(0).getName());
        cell.setCellStyle(rowStyle);

        cell = row.createCell(2);
        cell.setCellValue(script.getName());
        cell.setCellStyle(rowStyle);

        row = sheet.createRow(3);

        cell = row.createCell(1);
        cell.setCellStyle(bottomStyle);

        cell = row.createCell(2);
        cell.setCellStyle(bottomStyle);

        row = sheet.createRow(4);
        cell = row.createCell(0);
        cell.setCellValue("번호");
        cell.setCellStyle(title);

        cell = row.createCell(1);
        cell.setCellValue("디바이스 명");
        cell.setCellStyle(title);

        cell = row.createCell(2);
        cell.setCellValue("실행 시간 (ms)");
        cell.setCellStyle(title);

        int i = 0;
        for (i = 0; i < measures.size(); i++) {
            row = sheet.createRow(i + 5);

            Device device = deviceService.getDevice(
                    new Device(measures.get(i).getDeviceId()));
            measures.get(i).setDeviceName(device.getName());

            Cell noCell = row.createCell(0);
            noCell.setCellValue(i + 1);
            noCell.setCellStyle(centerStyle);

            Cell deviceCell = row.createCell(1);
            deviceCell.setCellValue(measures.get(i).getDeviceName());
            deviceCell.setCellStyle(rowStyle);

            Cell execTimeCell = row.createCell(2);
            if ("N".equals(measures.get(i).getDistributeStatus())) {
                execTimeCell.setCellValue("배포 실패");
                execTimeCell.setCellStyle(centerStyle);
            } else if ("N".equals(measures.get(i).getStatus())) {
                execTimeCell.setCellValue("측정 실패");
                execTimeCell.setCellStyle(centerStyle);
            } else  {
                execTimeCell.setCellValue(measures.get(i).getExecTime());
                execTimeCell.setCellStyle(noStyle);
            }
        }

        row = sheet.createRow(i + 5);
        row.createCell(0).setCellStyle(bottomStyle);
        row.createCell(1).setCellStyle(bottomStyle);
        row.createCell(2).setCellStyle(bottomStyle);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDate localDate = LocalDate.parse(script.getUploadPoint(), formatter);
        String date = localDate.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String fileName = measures.get(0).getName() + "_" + date + ".xlsx";

        File directory = new File(excelPath);
        if (!directory.isDirectory()) {
            directory.mkdir();
        }

        FileOutputStream fileOutputStream = null;
        try {
            fileOutputStream = new FileOutputStream(excelPath + File.separator + fileName);
            workbook.write(fileOutputStream);
        } catch (Exception e) {
            throw e;
        } finally {
            try {
                fileOutputStream.close();
            } catch (Exception e) {
                e.printStackTrace();
                throw e;
            }
        }

        return new File(excelPath + File.separator + fileName);
    }

    public void deleteExcel(String fileName) throws IOException {
        File file = new File(excelPath + File.separator + fileName);
        file.delete();
    }
}