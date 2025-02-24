public class Test {
  public static void main (String [] args) {
    if (args != null && args.length > 0) {
      System.out.println("Argument: " + args[0]); 
      System.out.println("Hello World");
    } else {
      System.out.println("No Args passed...");
    }
  }
}
