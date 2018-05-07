/// <summary>
/// This sample program for the .NET interface for the Bertec DLL shows how to use the data gathering process
/// with the Bertec Device .NET DLL. The command line program allows you to use either callbacks
/// or data polling, logging output to a file or to the screen for a given number of seconds.
/// </summary>
using System;
using System.IO;
using System.Collections.Generic;
using System.Text;

namespace BertecExampleNET
{
   /// <summary>
   /// The CallbackDataHandlerClass is where the data from the device is handled. In this example, the
   /// output is just simply written as a trivial CSV file.
   /// In order to make it a little simpler, the member pFile is exposed as public, so that it can be
   /// directly used outside of the class. This means that this class is created even if data polling
   /// (not callbacks) are used.
   /// </summary>
   class CallbackDataHandlerClass
   {
      /// <summary>
      /// The output file. This is also used when doing data polling.
      /// </summary>
      public StreamWriter pFile;

      public int iLimitNChannels=0;

      /// <summary>
      /// The data callback event is called each time there is data. This is enabled by using the
      /// BertecDeviceNET.DataEventHandler event notification mechanism.
      /// </summary>
      public void OnDataCallback(int samples, int channels, double[] data)
      {
         if (samples >= 0)
         {
            int lastCol = channels - 1;
            if (iLimitNChannels > 0)
               lastCol = iLimitNChannels - 1;
            int index = 0;
            for (int row = 0; row < samples; ++row)
            {
               for (int col = 0; col < channels; ++col)
               {
                  if (iLimitNChannels == 0 || col < iLimitNChannels)
                  {
                     pFile.Write("{0}", data[index]);
                     if ((col == lastCol))
                        pFile.Write("\r\n");
                     else
                        pFile.Write(",");
                  }
                  ++index;
               }
            }
         }
         else
         {  // error handling
            pFile.WriteLine("*** Got error code {0}", samples);
         }
      }

      public void StatusEvent(int status)
      {
         Console.WriteLine("Status event {0}", status);
      }
   }


   class BertecExampleNET
   {
      static void ShowHelp()
      {
         Console.WriteLine("Bertec Device Example (.NET):");
         Console.WriteLine("-f <filename>   output to the given filename");
         Console.WriteLine("-t <seconds>    run for the given # of seconds");
         Console.WriteLine("-s <num>        use num for acquire rate");
         Console.WriteLine("-l <num>        limit to first num channels per row");
         Console.WriteLine("-c              do callbacks");
         Console.WriteLine("-p              do polling");
         Console.WriteLine("-a              turn on autozeroing");
         Console.WriteLine("-z              zero load before data gather");
      }


     


      static void Main(string[] args)
      {
         string filename="";
         bool useCallbacks = false;
         bool usePolling = false;
         int runTimeMSeconds = 0;
         int limitChannels = 0;
         int acquireRate = 0;
         bool useAutozeroing = false;
         bool startWithZeroLoad = false;

         if (args.Length < 1)
         {
            ShowHelp();
            return;
         }

         bool nextIsParm=false;
         string parm="", command="";
         foreach (string item in args)
         {
            if (nextIsParm)
            {
               parm = item;
               nextIsParm = false;
            }
            else if (item.StartsWith("-"))
            {
               command = item.Substring(1);
               if (command == "f" || command == "t" || command == "l" || command == "s")
               {
                  nextIsParm = true;
                  continue;
               }
            }

            switch (command)
            {
               case "f":
                  if (parm.Length > 0)
                     filename = parm;
                  break;
               case "t":
                  if (parm.Length > 0)
                     runTimeMSeconds = 1000 * System.Convert.ToInt32(parm);
                  break;
               case "l":
                  if (parm.Length > 0)
                     limitChannels = System.Convert.ToInt32(parm);
                  break;
               case "s":
                  if (parm.Length > 0)
                     acquireRate = System.Convert.ToInt32(parm);
                  break;
               case "c":
                  useCallbacks = true;
                  usePolling = false;
                  break;
               case "p":
                  useCallbacks = false;
                  usePolling = true;
                  break;
               case "a":
                  useAutozeroing = true;
                  break;
               case "z":
                  startWithZeroLoad = true;
                  break;
            }

            parm = "";
         }

         if ((runTimeMSeconds < 1) || (usePolling == useCallbacks) || (filename.Length < 1))
         {
            ShowHelp();
            return;
         }

         // We create the handler class here, even if not doing callbacks, in order to use the pFile member.
         CallbackDataHandlerClass callbackClass = new CallbackDataHandlerClass();
         callbackClass.iLimitNChannels = limitChannels;

         callbackClass.pFile = File.CreateText(filename);

         // This will actually connect to the devices and work with them. The BertecDeviceNET.BertecDevice
         // object gives you all the functionality you need.
         BertecDeviceNET.BertecDevice hand = new BertecDeviceNET.BertecDevice();

         for (int i = 0; i < hand.TransducerCount;++i)
         {
            Console.WriteLine("Plate serial {0}",hand.get_TransducerSerialNumber(i));
         }

         if (acquireRate > 0)
            hand.AcquireRate = acquireRate;

         hand.AutoZeroing = useAutozeroing ? 1 : 0;

         hand.PollingBufferSize = 1.000;
         hand.Start();

         // When starting with a zero load, we need to zero after we start; if you call stop after zeroing, it will reset
         // the zero load values.
         if (startWithZeroLoad)
         {
            Console.WriteLine("Zeroing Load...");
            hand.ZeroNow();
            System.Threading.Thread.Sleep(1600);
            Console.WriteLine(" done");
            hand.ClearPollBuffer();
         }

         // When using callbacks, we can simply use the Windows sleep function call to suspend our main thread
         // while the callback thread does all the work for us. 
         if (useCallbacks)
         {
            Console.WriteLine("Using callbacks to gather data.");
            hand.OnData += new BertecDeviceNET.DataEventHandler(callbackClass.OnDataCallback);
            hand.OnStatus += new BertecDeviceNET.StatusEventHandler(callbackClass.StatusEvent);

            System.Threading.Thread.Sleep(runTimeMSeconds); // in your code, you could do real work here.
         }

         
         // When polling, this is slightly more work since we need to go and check the timer ourselves.
         if (usePolling)
         {
            Console.WriteLine("Using polling to gather data.");
            double[] data=null;
            int channels = 0;

           
            int targetTime = Environment.TickCount + runTimeMSeconds;

            while (Environment.TickCount < targetTime)
            {
               int samples = 0;
               do
               {
                  samples = hand.DataPoll(ref channels, ref data);
                  if (samples == 0)
                     System.Threading.Thread.Sleep(250);  // if your main process is in a tight loop like this one, you can overrun the device
               } while (samples == 0);

               callbackClass.OnDataCallback(samples, channels, data);  // call the same code as the callback would do
            }
         }

         hand.Stop();
         Console.WriteLine("Data gather complete, shutting down.");

         // And we close the file.
         callbackClass.pFile.Close();
         callbackClass.pFile = null;

         // Always a good idea to call Dispose on any item that has it. Otherwise, wrapper the block with using().
         hand.Dispose();
         hand = null;
      
      }

   }
}
