// BertecExample.cpp : this example code shows how to use the data gathering process
// with the Bertec Device DLL. The command line program allows you to use either callbacks
// or data polling, logging output to a file or to the screen for a given number of seconds.
//

#include <iostream>
#include <stdio.h>
#include <tchar.h>
#include <time.h>
#include <windows.h>
#include <io.h>
#include <string.h>
#include <winsock2.h>
#include "bertecif.h"

#pragma comment(lib,"ws2_32.lib") //Winsock Library

WSADATA wsa;
SOCKET s, new_socket;
struct sockaddr_in server, client;
int c;
char *message;
char buffer[10];
char buf[5];

// The data callback will be passed the already existing FILE pointer in the userData.
// This example shows how this is used by typecasting it to the proper data type.
// The same concept can also be applied to a C++ object.
void CALLBACK DataCallback(bertec_Handle hand,int samples, int channels, double * data, void * userData)
{

    FILE* pFile = (FILE*)userData;
    if (samples >= 0)
    {
        const int lastCol = channels-1;
        int index=0;

        for (int row=0; row<samples; ++row)
        {
            for (int col=0; col<channels; ++col)
            {
                printf("%f%c",data[index],(col==lastCol) ? '\n' : ',');
                ++index;
            }

        }
    }

    else
    {
        // error handling
        printf("*** Got error code %d\n",samples);
        if (samples == BERTEC_DATA_POLL_OVERFLOW)
        {
            bertec_ClearOverflowError(hand);
        }
        else
        {
            bertec_ClearStatusError(hand);
        }
    }
}

int _tmain(int argc, _TCHAR* argv[])
{
    char filename[MAX_PATH]="";
    bool useCallbacks=false;
    bool usePolling=false;
    int  runTimeSeconds=0;
    int limitChannels = 0;
    int acquireRate = 0;
    bool useAutozeroing = false;
    bool startWithZeroLoad = false;

    printf("\nInitialising Winsock...");
    if (WSAStartup(MAKEWORD(2,2),&wsa) != 0)
    {
        printf("Failed. Error Code : %d",WSAGetLastError());
        return 1;
    }

    printf("Initialised.\n");

    //Create a socket
    if((s = socket(AF_INET, SOCK_STREAM, 0 )) == INVALID_SOCKET)
    {
        printf("Could not create socket : %d", WSAGetLastError());
    }

    printf("Socket created.\n");

    //Prepare the sockaddr_in structure
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = INADDR_ANY;
    server.sin_port = htons( 8888 );

    //Bind
    if( bind(s,(struct sockaddr *)&server, sizeof(server)) == SOCKET_ERROR)
    {
        printf("Bind failed with error code : %d", WSAGetLastError());
    }

    puts("Bind done");

    if (argc<2)
    {
showhelp:
        message = "Hello Client , I have received your connection. But I have to go now, bye\n";
        printf("Bertec Device Example:\n");
        printf("-f <filename>   output to the given filename\n");
        printf("-t <seconds>    run for the given # of seconds\n");
        printf("-s <num>        use num for acquire rate\n");
        printf("-l <num>        limit to first num channels per row\n");
        printf("-c              do callbacks\n");
        printf("-p              do polling\n");
        printf("-a              turn on autozeroing\n");
        printf("-z              zero load before data gather\n");

        send(new_socket, message, strlen(message), 0);

        getchar();

        closesocket(s);
        WSACleanup();

        return 0;
    }

    int i=1;
    while (i<argc)
    {
        char *item = argv[i];
        char *parm = argv[i+1];
        ++i;
        if (item[0]=='-')
        {
            switch(item[1])
            {
            case 'f':
                if (parm!=NULL)
                {
                    strncpy(filename,parm,sizeof(filename));
                    ++i;
                }
                break;
            case 't':
                if (parm!=NULL)
                {
                    runTimeSeconds = atoi(parm);
                    ++i;
                }
                break;
            case 'l':
                if (parm!=NULL)
                {
                    limitChannels = atoi(parm);
                    ++i;
                }
                break;
            case 's':
                if (parm!=NULL)
                {
                    acquireRate = atoi(parm);
                    ++i;
                }
                break;
            case 'c':
                useCallbacks=true;
                usePolling=false;
                break;
            case 'p':
                useCallbacks=false;
                usePolling=true;
                break;
            case 'a':
                useAutozeroing=true;
                break;
            case 'z':
                startWithZeroLoad=true;
                break;
            }
        }
    }

    if (runTimeSeconds<1)
        goto showhelp;

    if (usePolling == useCallbacks)
        goto showhelp;

    FILE* pFile = fopen("datafile.csv","wt");

    bertec_Handle hand = bertec_Init();

    if (acquireRate > 0)
        bertec_SetAcquireRate(hand,acquireRate);

    bertec_EnableAutozero(hand,useAutozeroing ? 1 : 0);

    bertec_AllocatePollBuffer(hand,1.000f);

    bertec_Start(hand);

    if (startWithZeroLoad)
    {
        printf("Zeroing Load...");
        bertec_ZeroNow(hand);
        SleepEx(1600,FALSE);
        printf(" done\n");
        bertec_ClearPollBuffer(hand);
    }

    // When using callbacks, we can simply use the Windows sleep function call to suspend our main thread
    // while the callback thread does all the work for us. Note the use of pFile being passed as the user
    // data value.
    if (useCallbacks)
    {
        printf("Using callbacks to gather data.\n");
        bertec_RegisterDataCallback(hand,DataCallback, pFile);

        SleepEx(1000*runTimeSeconds,FALSE); // in your code, you could do real work here.
    }

    // When polling, this is slightly more work since we need to go and check the timer ourselves.
    if (usePolling)
    {

    //Listen to incoming connections
    listen(s, 3);

    //Accept and incoming connection
    puts("Waiting for incoming connections...");

    c = sizeof(struct sockaddr_in);
    new_socket = accept(s, (struct sockaddr *)&client, &c);
    if (new_socket == INVALID_SOCKET)
    {
        printf("accept failed with error code : %d", WSAGetLastError());
    }

    puts("Connection accepted");
        printf("Using polling to gather data.\n");

        double data[8000];
        int channels=0;

        while (1)
        {
            recv(new_socket,buf,1,0);
            int samples=0;
            //If the data is requested, this will send the data else will poll
            if((strcmp(buf,"r") == 0))
            {
                samples = bertec_DataPoll(hand,8000, data, &channels);
                if (samples==0)
                    SleepEx(1,FALSE);  // if your main process is in a tight loop like this one, you can overrun the device

                if (samples >0)
                {
                    printf("#Samples = %d\n",samples);
                    const int lastCol = channels-1;
                    int index=0;

                    for (int col=0; col<channels; ++col)
                    {
                        sprintf(buffer,"%f%c",data[index],(col==lastCol) ? '\n' : ' ');
                        send(new_socket, buffer,strlen(buffer), 0);
                        ++index;
                    }

                }

                bertec_ClearPollBuffer(hand);

            }
            else if(strcmp(buf,"q") == 0)
            {
             break;
            }

        }
    }

    bertec_Stop(hand);
    printf("Data gather complete, shutting down.\n");

    bertec_Close(hand);

    fclose(pFile);

    return 0;
}

