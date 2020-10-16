public class MegaBytesConverter {
    public static void printMegaBytesAndKiloBytes(int kiloBytes) {

        int megaBytes = kiloBytes / 1024;
        int remainingKilobytes = kiloBytes % 1024;

        String result = kiloBytes < 0 ? "Invalid Value" : kiloBytes + " KB = " + megaBytes + " MB and " + remainingKilobytes + " KB";
        System.out.println(result);
    }
}
