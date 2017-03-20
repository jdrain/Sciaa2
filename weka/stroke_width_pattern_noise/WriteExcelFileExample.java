package com.jcg.example;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


public class WriteExcelFileExample {
	
	public static rowIndex=0;
	
	Workbook workbook = new XSSFWorkbook();

    Sheet studentsSheet = workbook.createSheet("Students");

    
    public static WriteExcelFileExample getInstance() {
        return INSTANCE;
    }

    private WriteExcelFileExample() {
    }

    public static void output(String filename, String prediction){
		
		public static final String FILE_PATH = filename;
    //We are making use of a single instance to prevent multiple write access to same file.
		public static final WriteExcelFileExample INSTANCE = new WriteExcelFileExample();
		Row row = studentsSheet.createRow(rowIndex++);
		row.createCell(1).setCellValue(prediction);
        
    }

    public static void writeStudentsListToExcel(List studentList){

        // Using XSSF for xlsx format, for xls use HSSF
        
        int rowIndex = 0;
        for(Student student : studentList){
            Row row = studentsSheet.createRow(rowIndex++);
            int cellIndex = 0;
            //first place in row is name
            row.createCell(cellIndex++).setCellValue(student.getName());

            //second place in row is marks in maths
            row.createCell(cellIndex++).setCellValue(student.getMaths());

            //third place in row is marks in Science
            row.createCell(cellIndex++).setCellValue(student.getScience());

            //fourth place in row is marks in English
            row.createCell(cellIndex++).setCellValue(student.getEnglish());

        }

        //write this workbook in excel file.
        try {
            FileOutputStream fos = new FileOutputStream(FILE_PATH);
            workbook.write(fos);
            fos.close();

            System.out.println(FILE_PATH + " is successfully written");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }


    }
}
