import java.io.BufferedReader;
import java.io.*;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import org.apache.commons.io.FileUtils;



public class example{
	public static void main(String args[])throws IOException {
		File folder = new File("C:/Users/akhil/Documents/MATLAB/Allfiles/output_original_files/handwritten/");
		String source_folder = "C:/Users/akhil/Documents/MATLAB/Allfiles/Individual_Words_predictions2/";
		
		String destination_folder = "C:/Users/akhil/Documents/MATLAB/Allfiles/predictions_for_training_file/handwritten/";
		String[] files = folder.list();
		System.out.println("files : "+files[0]);
		
		 for (String file : files) {
				String[] file_name = file.split(".pdf");
				String final_file_name = file_name[0]+".arff";
				String source = source_folder + final_file_name;
				String destination = destination_folder + final_file_name;
				File source_file = new File(source);
				File destination_file = new File(destination);
				FileUtils.copyFile(source_file,destination_file);
	
		
		
		}
	}
}
