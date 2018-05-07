' This sample program for the .NET interface for the Bertec DLL shows how to use the data gathering process
' with the Bertec Device .NET DLL. The command line program allows you to use either callbacks
' or data polling, logging output to a file or to the screen for a given number of seconds.
Imports System.IO
Imports System.Collections.Generic
Imports System.Text

Namespace BertecExampleVBNet
   ''' <summary>
   ''' The CallbackDataHandlerClass is where the data from the device is handled. In this example, the
   ''' output is just simply written as a trivial CSV file.
   ''' In order to make it a little simpler, the member pFile is exposed as public, so that it can be
   ''' directly used outside of the class. This means that this class is created even if data polling
   ''' (not callbacks) are used.
   ''' </summary>
   Class CallbackDataHandlerClass
      ''' <summary>
      ''' The output file. This is also used when doing data polling.
      ''' </summary>
      Public pFile As StreamWriter

      Public iLimitNChannels As Integer = 0

      ''' <summary>
      ''' The data callback event is called each time there is data. This is enabled by using the
      ''' BertecDeviceNET.DataEventHandler event notification mechanism.
      ''' </summary>
      Public Sub OnDataCallback(ByVal samples As Integer, ByVal channels As Integer, ByVal data As Double())
         If samples >= 0 Then
            Dim lastCol As Integer = channels - 1
            If iLimitNChannels > 0 Then
               lastCol = iLimitNChannels - 1
            End If
            Dim index As Integer = 0
            For row As Integer = 0 To samples - 1
               For col As Integer = 0 To channels - 1
                  If iLimitNChannels = 0 OrElse col < iLimitNChannels Then
                     pFile.Write("{0}", data(index))
                     If (col = lastCol) Then
                        pFile.Write(vbCr & vbLf)
                     Else
                        pFile.Write(",")
                     End If
                  End If
                  index += 1
               Next
            Next
         Else
            ' error handling
            pFile.WriteLine("*** Got error code {0}", samples)
         End If
      End Sub

      Public Sub StatusEvent(ByVal status As Integer)
         Console.WriteLine("Status event {0}", status)
      End Sub
   End Class


   Module BertecExampleVBNet
      Private Sub ShowHelp()
         Console.WriteLine("Bertec Device Example (.NET):")
         Console.WriteLine("-f <filename>   output to the given filename")
         Console.WriteLine("-t <seconds>    run for the given # of seconds")
         Console.WriteLine("-s <num>        use num for acquire rate")
         Console.WriteLine("-l <num>        limit to first num channels per row")
         Console.WriteLine("-c              do callbacks")
         Console.WriteLine("-p              do polling")
         Console.WriteLine("-a              turn on autozeroing")
         Console.WriteLine("-z              zero load before data gather")
      End Sub



      Public Sub Main(ByVal args As String())
         Dim filename As String = ""
         Dim useCallbacks As Boolean = False
         Dim usePolling As Boolean = False
         Dim runTimeMSeconds As Integer = 0
         Dim limitChannels As Integer = 0
         Dim acquireRate As Integer = 0
         Dim useAutozeroing As Boolean = False
         Dim startWithZeroLoad As Boolean = False

         If args.Length < 1 Then
            ShowHelp()
            Return
         End If

         Dim nextIsParm As Boolean = False
         Dim parm As String = "", command As String = ""
         For Each item As String In args
            If nextIsParm Then
               parm = item
               nextIsParm = False
            ElseIf item.StartsWith("-") Then
               command = item.Substring(1)
               If command = "f" OrElse command = "t" OrElse command = "l" OrElse command = "s" Then
                  nextIsParm = True
                  Continue For
               End If
            End If

            Select Case command
               Case "f"
                  If parm.Length > 0 Then
                     filename = parm
                  End If
                  Exit Select
               Case "t"
                  If parm.Length > 0 Then
                     runTimeMSeconds = 1000 * System.Convert.ToInt32(parm)
                  End If
                  Exit Select
               Case "l"
                  If parm.Length > 0 Then
                     limitChannels = System.Convert.ToInt32(parm)
                  End If
                  Exit Select
               Case "s"
                  If parm.Length > 0 Then
                     acquireRate = System.Convert.ToInt32(parm)
                  End If
                  Exit Select
               Case "c"
                  useCallbacks = True
                  usePolling = False
                  Exit Select
               Case "p"
                  useCallbacks = False
                  usePolling = True
                  Exit Select
               Case "a"
                  useAutozeroing = True
                  Exit Select
               Case "z"
                  startWithZeroLoad = True
                  Exit Select
            End Select

            parm = ""
         Next

         If (runTimeMSeconds < 1) OrElse (usePolling = useCallbacks) OrElse (filename.Length < 1) Then
            ShowHelp()
            Return
         End If

         ' We create the handler class here, even if not doing callbacks, in order to use the pFile member.
         Dim callbackClass As New CallbackDataHandlerClass()
         callbackClass.iLimitNChannels = limitChannels

         callbackClass.pFile = File.CreateText(filename)

         ' This will actually connect to the devices and work with them. The BertecDeviceNET.BertecDevice
         ' object gives you all the functionality you need.
         Dim hand As New BertecDeviceNET.BertecDevice()

         For i As Integer = 0 To hand.TransducerCount - 1
            Console.WriteLine("Plate serial {0}", hand.TransducerSerialNumber(i))
         Next

         If acquireRate > 0 Then
            hand.AcquireRate = acquireRate
         End If

         hand.AutoZeroing = If(useAutozeroing, 1, 0)

         hand.PollingBufferSize = 1.0
         hand.Start()

         ' When starting with a zero load, we need to zero after we start; if you call stop after zeroing, it will reset
         ' the zero load values.
         If startWithZeroLoad Then
            Console.Write("Zeroing Load...")
            hand.ZeroNow()
            System.Threading.Thread.Sleep(1600)
            Console.WriteLine(" done")
            hand.ClearPollBuffer()
         End If

         ' When using callbacks, we can simply use the Windows sleep function call to suspend our main thread
         ' while the callback thread does all the work for us. 
         If useCallbacks Then
            Console.Write("Using callbacks to gather data.")
            AddHandler hand.OnData, AddressOf callbackClass.OnDataCallback
            AddHandler hand.OnStatus, AddressOf callbackClass.StatusEvent

            ' hand.OnData += New BertecDeviceNET.DataEventHandler(AddressOf callbackClass.OnDataCallback)
            ' hand.OnStatus += New BertecDeviceNET.StatusEventHandler(AddressOf callbackClass.StatusEvent)

            ' in your code, you could do real work here.
            System.Threading.Thread.Sleep(runTimeMSeconds)
         End If


         ' When polling, this is slightly more work since we need to go and check the timer ourselves.
         If usePolling Then
            Console.Write("Using polling to gather data.")
            Dim data As Double() = Nothing
            Dim channels As Integer = 0


            Dim targetTime As Integer = Environment.TickCount + runTimeMSeconds

            While Environment.TickCount < targetTime
               Dim samples As Integer = 0
               Do
                  samples = hand.DataPoll(channels, data)
                  If samples = 0 Then
                     System.Threading.Thread.Sleep(250)
                     ' if your main process is in a tight loop like this one, you can overrun the device
                  End If
               Loop While samples = 0

               ' call the same code as the callback would do
               callbackClass.OnDataCallback(samples, channels, data)
            End While
         End If

         hand.[Stop]()
         Console.WriteLine("Data gather complete, shutting down.")

         ' And we close the file.
         callbackClass.pFile.Close()
         callbackClass.pFile = Nothing

         ' Always a good idea to call Dispose on any item that has it. Otherwise, wrapper the block with using().
         hand.Dispose()
         hand = Nothing

      End Sub

   End Module
End Namespace
