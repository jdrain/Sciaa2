// arg1= input path i.e path where arff files are stored. example: C:/Users/akhil/Documents/MATLAB/November/Aiken_ARFF/Small
//arg2 = pass the arff file name which will be used for the second phase of the code.
//arg3 = pass the input path where the original files are present.
//arg4 = pass the output path where the original files should be stored.

import java.io.BufferedReader;
import java.io.*;
import java.io.FileNotFoundException;
import java.io.FileReader;
import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.classifiers.evaluation.NominalPrediction;
import weka.core.SerializationHelper;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;
 
public class SmallImageClassification {
	
 
	public static void main(String[] args) throws Exception {
		
		
		// rootPath should be pointed to the folder where the model is present.
		String rootPath="C:/Users/akhil/Documents/WEKA/models/"; 
		Classifier cls = (Classifier) weka.core.SerializationHelper.read(rootPath+"Step1.randomforest.model");
		//below path is where .arff files are stored ....
		File folder = new File(args[0]);
		System.out.println(args[0]);
		System.out.println(args[1]);
		System.out.println(args[2]);
		System.out.println(args[3]);
		File[] listOfFiles = folder.listFiles();
		String[] list = folder.list();
		System.out.println(list[0]);
		System.out.println(list[1]);
		System.out.println(list[2]);
		System.out.println(list[4]);
		//below arff file name is created after the first phase of the project and it is agian passed to the second model which will predict if a full site form image is printed or not... 
		PrintWriter writer = new PrintWriter(args[1], "UTF-8");
		writer.println("@RELATION SCIAA");
		writer.println("@ATTRIBUTE H90  	NUMERIC");
		writer.println("@ATTRIBUTE H80   	NUMERIC");
		writer.println("@ATTRIBUTE H70  	NUMERIC");
		writer.println("@ATTRIBUTE H60  	NUMERIC");
		writer.println("@ATTRIBUTE H50  	NUMERIC");
		writer.println("@ATTRIBUTE total_printed   NUMERIC");
		writer.println("@ATTRIBUTE total_handwritten   NUMERIC");
		writer.println("@ATTRIBUTE total   NUMERIC");
		writer.println("@ATTRIBUTE  class    {printed, handwritten}");
		
		writer.println("@DATA");
		for (int i = 0; i < listOfFiles.length; i++) {
			if (listOfFiles[i].isFile()) {
								System.out.println("folder name : "+list[i]);
				
								String fileName = args[0]+list[i];
								DataSource source = new DataSource(fileName);
								//predict instance class values
								Instances originalTrain= source.getDataSet();//load or create Instances to predict
								originalTrain.setClassIndex(originalTrain.numAttributes() - 1); 
								//which instance to predict class value
								int handwritten90 = 0;
								int handwritten80 = 0;
								int handwritten70 = 0;
								int handwritten60 = 0;
								int handwritten50 = 0;
								int number_printed_images = 0;
								int number_handwritten_images = 0;
								int total_number_images = 0;
								for(int s1=0;s1<originalTrain.numInstances();s1++){
									
								
									//perform your prediction
									double value=cls.classifyInstance(originalTrain.instance(s1));

									//get the name of the class value
									String prediction=originalTrain.classAttribute().value((int)value); 
									double[] percentage=cls.distributionForInstance(originalTrain.instance(s1));
												
									
									/* System.out.println("The predicted value of instance "+
											Integer.toString(s1)+
											": "+prediction+":"+percentage[1]); */
									if(percentage[1]>=0.90){
										handwritten90++;
									}else if(percentage[1]>=0.80){
										handwritten80++;
									}else if(percentage[1]>= 0.70){
										handwritten70++;
									}else if(percentage[1]>= 0.60){
										handwritten60++;
									}else if(percentage[1]> 0.50){
										handwritten50++;
									}
									
										
								}
								total_number_images= originalTrain.numInstances();
								number_handwritten_images = (handwritten90 + handwritten80 + handwritten70 + handwritten60 + handwritten50);
								number_printed_images = (total_number_images - number_handwritten_images);
								System.out.println("handwritten90++; " + handwritten90);
								System.out.println("handwritten80++; " + handwritten80);
								System.out.println("handwritten70++; " + handwritten70);
								System.out.println("handwritten60++; " + handwritten60);
								System.out.println("handwritten50++; " + handwritten50);
								System.out.println("number_printed_images : " + number_printed_images);
								System.out.println("number_handwritten_images : " + number_handwritten_images);
								System.out.println("total_number_images : " + total_number_images);
								
								writer.print(handwritten90);
								writer.print(",");
								writer.print(handwritten80);
								writer.print(",");
								writer.print(handwritten70);
								writer.print(",");
								writer.print(handwritten60);
								writer.print(",");
								writer.print(handwritten50);
								writer.print(",");
								writer.print(number_printed_images);
								writer.print(",");
								writer.print(number_handwritten_images);
								writer.print(",");
								writer.print(total_number_images);
								writer.print(",");
								writer.print("?");
								//at the time of prediction ? should be placed.
								writer.println("");
								
				
			} else if (listOfFiles[i].isDirectory()) {
				System.out.println("Directory " + listOfFiles[i].getName());
			}
		}
		writer.close();
		
		//phase 2 of the program ... this will predict whether the file is printed or handwritten and based on that, it will create two folders where printed and handwritten files are stored individually
		
		Classifier cls2 = (Classifier) weka.core.SerializationHelper.read(rootPath+"Step2.small.naiveBayesMultinomial.model");
		//bleow filename is the 
		DataSource source2 = new DataSource(args[1]);
								//predict instance class values
		Instances originalTrain2= source2.getDataSet();//load or create Instances to predict
		
		originalTrain2.setClassIndex(originalTrain2.numAttributes() - 1);
		
		
		
		
		for(int s1=0;s1<originalTrain2.numInstances();s1++){
									
									
									//perform your prediction
									double value=cls2.classifyInstance(originalTrain2.instance(s1));

									//get the name of the class value
									String prediction2=originalTrain2.classAttribute().value((int)value); 
									double[] percentage=cls2.distributionForInstance(originalTrain2.instance(s1));
									
									//args[4] we pass the output path where you want the original files to be placed.	
									String outputpath = args[3];
																		
									//seperating printed and handwritten images. in the word format
									String[] folder_name = list[s1].split(".arff");
									System.out.println(folder_name[0]);
									String[] site_form_type = folder_name[0].split("\\.");
									System.out.println(site_form_type[2]);
									//this path is the path of the files ... i.e files which are split into individual words
									String original_folder= "C:/Users/akhil/Documents/MATLAB/Allfiles/Individual_Words_smaller_larger_files/larger/"; 
									File srcFolder = new File(original_folder);
									
									
									//below path is where the orginal files are present
									String original_full_files = args[2];
									original_full_files = original_full_files + site_form_type[2] + "/";
									original_full_files = original_full_files + folder_name[0]+".png";
									File original_files_folder = new File(original_full_files);
										
									if(prediction2.equals("printed")){
										
									
											// below code checks if the Printed folder is available, if not will create the directory and all the orignal printed files are placed here 	
										   outputpath = outputpath + "Printed/";
										   File theDir = new File(outputpath);
										   if(!theDir.exists()){
												theDir.mkdir();
											}
											
										   File destinationFile = new File(outputpath, folder_name[0]+".png");
										   
										   //recursive copy
										   InputStream input = new FileInputStream(original_files_folder);
										   OutputStream output = new FileOutputStream(destinationFile); 
														 
										   byte[] buffer1 = new byte[1024];
										
										   int length1;
											//copy the file content in bytes 
										   while ((length1 = input.read(buffer1)) > 0){
											   output.write(buffer1, 0, length1);
											}
							 
											input.close();
											output.close();
										
										////original file copying before code ends here
										
										//below path is for storing the smaller(68-1 type files) printed orginal files which are segmented into words 
										/* String destination_folder_creation = "C:/Users/akhil/Documents/MATLAB/Allfiles/larger_output/printed/"+folder_name[0]; 
										File fold_name = new File(destination_folder_creation);
										fold_name.mkdir();
										
										
										String folder_path = original_folder + folder_name[0];
										File abc = new File(folder_path);
										String files[] = abc.list();
			
										for (String file : files) {
										   //construct the src and dest file structure
										   
										   
										   
										   File srcFile = new File(abc, file);
										   File destFile = new File(destination_folder_creation, file);
										   //recursive copy
										   InputStream in = new FileInputStream(srcFile);
										   OutputStream out = new FileOutputStream(destFile); 
														 
										   byte[] buffer = new byte[1024];
										
										   int length;
											//copy the file content in bytes 
										   while ((length = in.read(buffer)) > 0){
											   out.write(buffer, 0, length);
											}
							 
											in.close();
											out.close();
										} */
										
										System.out.println("printed" + folder_name[0]);
									}else{
										
										// below code checks if the Printed folder is available, if not will create the directory and all the orignal printed files are placed here
											outputpath = outputpath + "Handwritten/";
											File theDir = new File(outputpath);
											if(!theDir.exists()){
												theDir.mkdir();
											}
											
										   File destinationFile = new File(outputpath, folder_name[0]+".png");
										   //recursive copy
										   InputStream input = new FileInputStream(original_files_folder);
										   OutputStream output = new FileOutputStream(destinationFile); 
														 
										   byte[] buffer1 = new byte[1024];
										
										   int length1;
											//copy the file content in bytes 
										   while ((length1 = input.read(buffer1)) > 0){
											   output.write(buffer1, 0, length1);
											}
							 
											input.close();
											output.close();
										
										////original file copying before code ends here
										
										/* //below path is for storing the smaller(68-1 type files) printed orginal files which are segmented into words 
										String destination_folder_creation = "C:/Users/akhil/Documents/MATLAB/Allfiles/larger_output/handwritten/"+folder_name[0]; 
										File fold_name = new File(destination_folder_creation);
										fold_name.mkdir();
										
										String folder_path = original_folder + folder_name[0];
										File abc = new File(folder_path);
										String files[] = abc.list();
			
										for (String file : files) {
										   //construct the src and dest file structure
										   
										   File srcFile = new File(abc, file);
										   File destFile = new File(destination_folder_creation, file);
										   //recursive copy
										   InputStream in = new FileInputStream(srcFile);
										   OutputStream out = new FileOutputStream(destFile); 
														 
										   byte[] buffer = new byte[1024];
										
										   int length;
											//copy the file content in bytes 
										   while ((length = in.read(buffer)) > 0){
											   out.write(buffer, 0, length);
											}
							 
											in.close();
											out.close();
										} */
										
										
										System.out.println("handwritten"+ folder_name[0]);
									}
								
								
								
								
								} 
							
		
		
}

}