
/**
 * This sample program for the JAVA interface for the Bertec DLL shows how to use the data gathering process
 * with the Bertec Device JAVA package. The command line program allows you to use either callbacks
 * or data polling, logging output to a file or to the screen for a given number of seconds.
 */
import BertecDeviceJava.BertecDevice.StatusEvent;
import BertecDeviceJava.BertecDevice.DataEvent;
import java.io.*;

public class Main {

   /**
    * The CallbackDataHandlerClass is where the data from the device is handled. In this example, the
    * output is just simply written as a trivial CSV file.
    * In order to make it a little simpler, the member pFile is exposed as public, so that it can be
    * directly used outside of the class. This means that this class is created even if data polling
    * (not callbacks) are used.
    */
   public static class CallbackDataHandlerClass implements BertecDeviceJava.BertecDevice.DataEventListener {

      /**
       * The output file. This is also used when doing data polling.
       */
      public PrintWriter pFile;
      public int iLimitNChannels = 0;

      /**
       * The data callback event is called each time there is data. This is enabled by using the
       * BertecDeviceNET.DataEventHandler event notification mechanism.
       */
      public void dataEventReceived(DataEvent event) {
         OnDataCallback(event.samples, event.channels, event.data);
      }

      /**
       * This is the common function that is called from the above event handler, and from down
       * below where polling is done.
       */
      public void OnDataCallback(int samples, int channels, double[] data) {
         if (samples >= 0) {
            int lastCol = channels - 1;
            if (iLimitNChannels > 0) {
               lastCol = iLimitNChannels - 1;
            }
            int index = 0;
            for (int row = 0; row < samples; ++row) {
               for (int col = 0; col < channels; ++col) {
                  if (iLimitNChannels == 0 || col < iLimitNChannels) {
                     pFile.print(data[index]);
                     if ((col == lastCol)) {
                        pFile.print("\r\n");
                     } else {
                        pFile.print(",");
                     }
                  }
                  ++index;
               }
            }
         } else {  // error handling
            pFile.println("*** Got error code " + samples);
         }
      }
   }

   /**
    * The status callback event is called each time there is change in the status of the DLL.
    * This code just prints out the new status to the console.
    */
   public static class CallbackStatusChangeHandlerClass implements BertecDeviceJava.BertecDevice.StatusEventListener {

      public void statusEventReceived(StatusEvent event) {
         System.out.println("Status event " + event.status);
      }
   }

   /**
    * Java complains if you try to call Thread.sleep without a try-catch block, so for the sake of making the example
    * code less cluttered, this wrapper function is introduced.
    */
   public static void sleepWrap(int runTimeMSeconds) {
      try {
         Thread.yield();
         Thread.sleep(runTimeMSeconds);
         Thread.yield();
      } catch (InterruptedException ie) {
      }
   }

   static void ShowHelp() {
      System.out.println("Bertec Device Example (JAVA):");
      System.out.println("-f <filename>   output to the given filename");
      System.out.println("-t <seconds>    run for the given # of seconds");
      System.out.println("-s <num>        use num for acquire rate");
      System.out.println("-l <num>        limit to first num channels per row");
      System.out.println("-c              do callbacks");
      System.out.println("-p              do polling");
      System.out.println("-a              turn on autozeroing");
      System.out.println("-z              zero load before data gather");
   }

   /**
    * @param args the command line arguments
    */
   public static void main(String[] args) {

      String filename = "";
      boolean useCallbacks = false;
      boolean usePolling = false;
      int runTimeMSeconds = 0;
      int limitChannels = 0;
      int acquireRate = 0;
      boolean useAutozeroing = false;
      boolean startWithZeroLoad = false;

      if (args.length < 1) {
         ShowHelp();
         return;
      }


      boolean nextIsParm = false;
      String parm = "", command = "";
      String parmsHaveNext = "ftls";
      for (String item : args) {
         if (nextIsParm) {
            parm = item;
            nextIsParm = false;
         } else if (item.startsWith("-")) {
            command = item.substring(1);
            if (parmsHaveNext.contains(command)) {
               nextIsParm = true;
               continue;
            }
         }

         if (command.equals("f") && !parm.isEmpty()) {
            filename = parm;
         }

         if (command.equals("t") && !parm.isEmpty()) {
            runTimeMSeconds = 1000 * Integer.parseInt(parm);
         }

         if (command.equals("l") && !parm.isEmpty()) {
            limitChannels = Integer.parseInt(parm);
         }

         if (command.equals("s") && !parm.isEmpty()) {
            acquireRate = Integer.parseInt(parm);
         }

         if (command.equals("c")) {
            useCallbacks = true;
            usePolling = false;
         }

         if (command.equals("p")) {
            useCallbacks = false;
            usePolling = true;
         }

         if (command.equals("a")) {
            useAutozeroing = true;
         }

         if (command.equals("z")) {
            startWithZeroLoad = true;
         }

         parm = "";
      }

      if ((runTimeMSeconds < 1) || (usePolling == useCallbacks) || (filename.isEmpty())) {
         ShowHelp();
         return;
      }


      // We create the handler class here, even if not doing callbacks, in order to use the pFile member.
      CallbackDataHandlerClass dataCallback = new CallbackDataHandlerClass();
      dataCallback.iLimitNChannels = limitChannels;
      try {
         dataCallback.pFile = new PrintWriter(filename);
      } catch (IOException e) {
      }

      CallbackStatusChangeHandlerClass statusCallback = new CallbackStatusChangeHandlerClass();

      // This will actually connect to the devices and work with them. The BertecDeviceJava.BertecDevice
      // object gives you all the functionality you need.
      BertecDeviceJava.BertecDevice hand = new BertecDeviceJava.BertecDevice();

      for (int i = 0; i < hand.getTransducerCount(); ++i) {
         System.out.println("Plate serial " + hand.getTransducerSerialNumber(i));
      }

      if (acquireRate > 0) {
         hand.setAcquireRate(acquireRate);
      }

      hand.setAutoZeroing(useAutozeroing ? 1 : 0);

      hand.setPollingBufferSize(1.000);
      hand.Start();

      if (startWithZeroLoad) {
         System.out.print("Zeroing Load...");
         hand.ZeroNow();
         sleepWrap(1600);
         System.out.println(" done");
         hand.ClearPollBuffer();
      }

      // When using callbacks, we can simply use the sleep function call to suspend our main thread
      // while the callback thread does all the work for us. 
      if (useCallbacks) {
         System.out.println("Using callbacks to gather data.");
         hand.addStatusEventListener(statusCallback);
         hand.addDataEventListener(dataCallback);

         // in your code, you could do real work here.
         sleepWrap(runTimeMSeconds);
      }

      // When polling, this is slightly more work since we need to go and check the timer ourselves.
      // Also note that the data buffer must be set up before hand, since DataPoll will NOT allocate it for you.
      if (usePolling) {
         System.out.println("Using polling to gather data.");
         long targetTime = System.currentTimeMillis() + runTimeMSeconds;
         double[] data = new double[8000];
         int[] channels = new int[1];  // since Java doesn't have pass-by-ref for atomic items, we have to do it this way.
         // the first (and only) array item will be the channel count.

         while (System.currentTimeMillis() < targetTime) {
            int samples = 0;
            do {
               samples = hand.DataPoll(channels, data);
               if (samples == 0) {
                  sleepWrap(250);  // if your main process is in a tight loop like this one, you can overrun the device
               }
            } while (samples == 0);

            if (samples == 0) {
               System.out.println("Got NO samples!");
            } else {
               dataCallback.OnDataCallback(samples, channels[0], data);
            }
         }
      }

      hand.Stop();
      System.out.println("Data gather complete, shutting down.");

      // And we close the file.
      dataCallback.pFile.close();
      dataCallback.pFile = null;
      dataCallback=null;

      hand.dispose();
      hand = null;
   }
}
