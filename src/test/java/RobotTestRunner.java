import java.io.File;
import java.io.IOException;

public class RobotTestRunner {

    public static void main(String[] args) {
        // Set the directory where your Robot Framework test files are located
        String robotTestsDir = "C:\\Users\\Lenovo\\IdeaProjects\\GrokAPI\\src\\test\\resources\\TestCases"; // Change this to your folder path
        File dir = new File(robotTestsDir);

        // Check if directory exists and contains .robot files
        if (dir.exists() && dir.isDirectory()) {
            // List all .robot files in the directory
            String[] robotFiles = dir.list((dir1, name) -> name.endsWith(".robot"));
            if (robotFiles != null && robotFiles.length > 0) {
                try {
                    // Build the command to run Robot Framework on all files
                    StringBuilder command = new StringBuilder();
                    command.append("robot --listener allure_robotframework:allure-results ");

                    for (String file : robotFiles) {
                        command.append(" ").append(dir.getAbsolutePath()).append(File.separator).append(file);
                    }

                    // Execute the command using ProcessBuilder
                    ProcessBuilder processBuilder = new ProcessBuilder(command.toString().split(" "));
                    processBuilder.directory(dir); // Set the working directory for the command
                    Process process = processBuilder.start();
                    int exitCode = process.waitFor(); // Wait for the command to finish

                    if (exitCode == 0) {
                        System.out.println("Robot Framework tests ran successfully!");
                    } else {
                        System.out.println("Robot Framework tests failed with exit code " + exitCode);
                    }

                } catch (IOException | InterruptedException e) {
                    e.printStackTrace();
                    System.out.println("An error occurred while executing Robot Framework tests.");
                }
            } else {
                System.out.println("No .robot files found in the directory: " + robotTestsDir);
            }
        } else {
            System.out.println("The specified directory does not exist: " + robotTestsDir);
        }
    }
}
