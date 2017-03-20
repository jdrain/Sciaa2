import java.io.BufferedReader;
import java.io.*;
import java.io.FileWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import weka.core.*;

import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.classifiers.evaluation.NominalPrediction;
import weka.core.SerializationHelper;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;


import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;



 
public class NoiseTextPrediction {
	
 
	public static void main(String[] args) throws Exception {
		
		
		
		String rootPath="C:/Users/akhil/Documents/WEKA/stroke_width_pattern_noise/"; 
		Classifier cls = (Classifier) weka.core.SerializationHelper.read(rootPath+"all_trees.RandomForest.model");
		//below path is where .arff files are stored ....
		File folder = new File("C:/Users/akhil/Documents/WEKA/stroke_width_pattern_noise/training files/");
		File[] listOfFiles = folder.listFiles();
		String[] list = folder.list();
		System.out.println(list[0]);
		
		
		
		
		for (int i = 0; i < listOfFiles.length; i++) {
			if (listOfFiles[i].isFile()) {
								
								
								String fileName = "C:/Users/akhil/Documents/WEKA/stroke_width_pattern_noise/training files/"+list[i];
								System.out.println("starting --> fileName : "+fileName);
								DataSource source = new DataSource(fileName);
								//predict instance class values
								Instances originalTrain= source.getDataSet();//load or create Instances to predict
								originalTrain.setClassIndex(originalTrain.numAttributes() - 1); 
								//which instance to predict class value
								
								Workbook workbook = new XSSFWorkbook();
								Sheet studentsSheet = workbook.createSheet("Students");
								int rowIndex=0;
								String FILE_PATH = "C:/Users/akhil/Documents/WEKA/stroke_width_pattern_noise/output/"+list[i]+".xlsx";
								
								for(int s1=0;s1<originalTrain.numInstances();s1++){
									
								
									//perform your prediction
									double value=cls.classifyInstance(originalTrain.instance(s1));

									//get the name of the class value
									String prediction=originalTrain.classAttribute().value((int)value); 
									double[] percentage=cls.distributionForInstance(originalTrain.instance(s1));
												
									
									 System.out.println("The predicted value of instance "+
											Integer.toString(s1)+
											": "+prediction+":"+percentage[1]); 
											
										
									Row row = studentsSheet.createRow(rowIndex++);
									row.createCell(1).setCellValue(prediction);	
											
										
								}
								
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
								
								
								
								
				
			} else if (listOfFiles[i].isDirectory()) {
				System.out.println("Directory " + listOfFiles[i].getName());
			}
		}
		
		
}

}

