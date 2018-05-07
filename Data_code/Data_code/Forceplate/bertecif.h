/***************************************************************************
 * Bertec device interface library header                                  *
 *  v. 1.8.1                                                               *
 *  Copyright (C) 2008-2012 Bertec Corporation                             *
 ***************************************************************************/

#ifndef BERTECIF_H
#define BERTECIF_H

#ifndef BIFH_EXPORT
   #ifdef WIN32
      #ifdef BERTECDEVICEDLL_BUILD
         #define BIFH_EXPORT __declspec(dllexport)
      #else
         #define BIFH_EXPORT __declspec(dllimport)
      #endif
   #else
      #define BIFH_EXPORT
   #endif
#endif

#ifndef CALLBACK
   #ifdef WIN32
      #define CALLBACK __stdcall
   #else
      #define CALLBACK
   #endif
#endif


#ifdef  __cplusplus
   extern "C" {
#endif

/** The version define is the version # of this Device DLL. You can check it in bertec_Handle::version
    If it doesn't match what this one is, then the structures and/or functions have changed,
    and you should proceed with caution. */
#define BERTECDLL_VERSION  (0x182)

/** This defines how many channels and devices that the DLL can support. */
#define BERTEC_MAX_CHANNELS 16
#define BERTEC_MAX_TRANSDUCERS 16

/** internal state of the library */
typedef struct bertec_State_s * bertec_Handle;

/** information about the transducer */
typedef  struct bertec_TransducerInfo_s bertec_TransducerInfo;
struct bertec_TransducerInfo_s {
   unsigned short version; /* mmMM. Minor and Major are broken out from this. Ex: 0x0211 is minor version 17, major version 2  */
   unsigned char  minorVer; /* these are version of the DEVICES, not the dll */
   unsigned char  majorVer;
   int status;            /* status of the device, separate from the overall state. Zero is good, negative bad. */
   int samplingFreq;      /* sampling frequency in Hertz */
   char serial[17];       /* the serial # of the device */
   int channelCount;      /* how many output channels there are */
   int isSynchMaster;     /* if set, then the device is the sync master */
   int isSynchronized;    /* if set, then the device is a part of a sync group */
   int dimensionWidthMM;  /* width of the plate in MM, if known */
   int dimensionHeightMM; /* height of the plate in MM, if known */
   char channelNames[17][BERTEC_MAX_CHANNELS];  /* the channel names from the device's eprom, null terminated */
};

/** information about state of the data acquisition system */
typedef struct bertec_State_s bertec_State;
struct bertec_State_s {
   int version;         /* version of this DLL system - should be BERTECDLL_VERSION. This is not the devices. */
   int status;          /* overall status of system. Zero is good, negative bad. */
   int transducerCount; /* how many attached devices are in the transducers list */
   int isSynchronized;  /* if set, then all of the devices are synchronized */
   bertec_TransducerInfo transducers[BERTEC_MAX_TRANSDUCERS];
};

/**
 * Format of data returned in data_callback and data_poll
 *
 * Multiple transducers are supported, any active transducers are listed in
 * bertec_state_t::transducers.
 * The data returned is *calibrated*, usually 3 or 6 channels.
 * Currently all transducers will have same sampling frequency.
 *
 * Thus, a sample from each transducer will have 1 or more channels in it.
 * All the samples are time-synchronized. The order that you receive
 * the samples is transducer-first, time second.
 *
 * Example: assume two transducers. Transducer 0 (as in bertec_state_t::transducers)
 * has 4 channels, transducer 1 has 2 channels.
 *
 * The data is ordered as follows:
 * t+0ms: tr0ch0,tr0ch1,tr0ch2,tr0ch3, tr1ch0,tr1ch1
 * t+1ms: tr0ch0,tr0ch1,tr0ch2,tr0ch3, tr1ch0,tr1ch1
 * and so on.
 * channels = 2+4
 */

/** callback into the user code when data becomes available
    samples is the total number of samples, or negative for an error
    channels is the total number of channels in each sample, those channels can come from several transducers
    data points to a buffer holding samples * channels elements of type double */
#ifndef bertec_DataCallback
typedef void (CALLBACK *bertec_DataCallback)(bertec_Handle bHand,int samples, int channels, double * data, void * userData);
#endif

#ifndef bertec_StatusCallback
typedef void (CALLBACK *bertec_StatusCallback)(bertec_Handle bHand,int status, void * userData);
#endif

/** initialize the library, returns a handle */
BIFH_EXPORT bertec_Handle bertec_Init(void);
/** close the library when it's no longer needed */
BIFH_EXPORT void bertec_Close(bertec_Handle bHand);

/** zero the input against what the plate has loaded on it right now */
BIFH_EXPORT int bertec_ZeroNow(bertec_Handle bHand);

/** enable/disable the autozeroing of the plate, which occurs if the plate is loaded at less than 40 Newtons for
    about 3.5 seconds. */
BIFH_EXPORT int bertec_EnableAutozero(bertec_Handle bHand,int enableFlag);

/** returns the current status of the autozero: 0=not enabled, 1=autozero enabled, but not yet achieved, 2=autozero achieved and will continue to do so*/
BIFH_EXPORT int bertec_AutozeroState(bertec_Handle bHand);

#define AUTOZEROSTATE_NOTENABLED  0
#define AUTOZEROSTATE_WORKING     1
#define AUTOZEROSTATE_ZEROFOUND   2

/** Average the samples. SamplesToAverage should be >= 2. Setting to 1 or less turns it off */
BIFH_EXPORT int bertec_SetAveraging(bertec_Handle bHand,int samplesToAverage);

/** Perform low-pass filtering on the samples. SamplesToFilter should be >=1. Setting to 0 or less turns it off. */
BIFH_EXPORT int bertec_SetLowpassFiltering(bertec_Handle bHand,int samplesToFilter);


/** Set how often the buffer should get data. The default is 10, legit values are from 1 to 50; 0=default of 10.
    Smaller values = faster+more callback action with smaller sample blocks, larger = less often callbacks, but bigger blocks of samples */
BIFH_EXPORT int bertec_SetAcquireRate(bertec_Handle bHand,int rateValue);

/** start the data gathering */
BIFH_EXPORT int bertec_Start(bertec_Handle bHand);
/** stop the data gathering */
BIFH_EXPORT int bertec_Stop(bertec_Handle bHand);


/** returns the current state */
BIFH_EXPORT bertec_State * bertec_GetState(bertec_Handle bHand);
/** restarts data callbacks after a state change */
BIFH_EXPORT void bertec_RestartData(bertec_Handle bHand);


/** call this when there is an error to clear it and continue data gathering */
BIFH_EXPORT bertec_State * bertec_ClearStatusError(bertec_Handle bHand);
/** if a data buffering overflow occurred, return the missed amount of time in samples (0 if no overflow).
     Resets the overflow condition. */
BIFH_EXPORT int bertec_ClearOverflowError(bertec_Handle bHand);

/** callback registration functions
    * callbacks are called from a separate thread
    * the callback is called with the user_data pointer passed to the register function
    * a callback is identified by the (function pointer, user data pointer) pair -
      the pair has to be unique
    * the registration functions safely ignore any requests to register existing
      callbacks (i.e. same pair), or to unregister callbacks that are not
      registered at the moment
    * if no user_data is needed, it should be NULL */
BIFH_EXPORT int bertec_RegisterDataCallback(bertec_Handle bHand,bertec_DataCallback, void * userData);
BIFH_EXPORT int bertec_UnregisterDataCallback(bertec_Handle bHand,bertec_DataCallback, void * userData);

BIFH_EXPORT int bertec_RegisterStatusCallback(bertec_Handle bHand,bertec_StatusCallback, void * userData);
BIFH_EXPORT int bertec_UnregisterStatusCallback(bertec_Handle bHand,bertec_StatusCallback, void * userData);


/** setup an internal buffer so that data can be polled without using callbacks,
    time in seconds: the buffer is guaranteed to be at least that long or longer,
    0 to disable */
BIFH_EXPORT void bertec_AllocatePollBuffer(bertec_Handle bHand,double time);

/** the buf_size passed to bertec_data_poll was too small to hold one sample */
#define BERTEC_DATA_POLL_NOUSERBUFFER -1
/** no poll buffers were allocated via allocate_poll_buffer */
#define BERTEC_DATA_POLL_NOPOLLBUFFER -2
/** status change occurred at this point, must call bertec_status_poll to clear
    this condition */
#define BERTEC_DATA_POLL_CHECKSTATUS -3
/** the polling wasn't performed for long enough, the data after this point
    is delayed, must call bertec_overflow_poll to get the time lost and clear this
    condition */
#define BERTEC_DATA_POLL_OVERFLOW -4
/** there are apparently no devices attached */
#define BERTEC_DATA_POLL_NODEVICES -5
/** didn't start the data process */
#define BERTEC_DATA_POLL_NOTSTARTED -6
/** synchronizing, data not available yet (in bertec_State::status during callbacks, return code for polling) */
#define BERTEC_DATA_SYNCHRONIZING -7
/** the plates have lost sync with each other - check sync cable */
#define BERTEC_DATA_SYNCHRONIZE_LOST -8

/** one or more plates have missing data sequence - data may be invalid */
#define BERTEC_DATA_SEQUENCE_MISSED -9
/** the plates have regained their data sequence */
#define BERTEC_DATA_SEQUENCE_REGAINED -10

/** no data is being received from the devices, check the cables */
#define BERTEC_NO_DATA_RECEIVED -11

/** the device has failed in some manner - power off the device, check all connections, power back on */
#define BERTEC_DEVICE_HAS_FAULTED -12

/** there are plates to be read */
#define BERTEC_DATA_POLL_DEVICESREADY -50

/** currently finding the zero values */
#define BERTEC_AUTOZEROSTATE_WORKING  -51
/** the zero leveling value was found */
#define BERTEC_AUTOZEROSTATE_ZEROFOUND -52

/** handle is invalid */
#define BERTEC_ERROR_INVALIDHANDLE  -100

/** poll for data, returns: count of samples, 0 if nothing came yet,
    or BERTEC_DATA_POLL_xxx; requires buf_size in bytes; channels can be NULL, otherwise returns
    number of channels */
BIFH_EXPORT int bertec_DataPoll(bertec_Handle bHand,int bufSize, double * dataBuf, int * channels);

/** convenience function to access the transducer's serial number */
BIFH_EXPORT int bertec_TransducerSerialNumber(bertec_Handle bHand,int transducerIndex,char *buffer,int bufferSize);

/** enable/disable checking for data sequence numbers. */
BIFH_EXPORT int bertec_EnableSeqNumberCheck(bertec_Handle bHand,int enableFlag);

/** returns the current poll buffer allocation as set before. */
BIFH_EXPORT double bertec_GetAllocatePollBuffer(bertec_Handle bHand);

/** discards all current data in the buffer. */
BIFH_EXPORT int bertec_ClearPollBuffer(bertec_Handle bHand);

/** returns the zero level noise value for a device. ZeroNow/EnableAutozero must have been called.
    This is a computed value that can be used for advanced filtering.
    This is always a positive value; negative values indicate no zeroing or some other error. */
BIFH_EXPORT double bertec_GetZeroLevelNoiseValue(bertec_Handle bHand,int transducerIndex,int channelIndex);

/** set the usb thread reader priority. Advanced functionality, usually not needed. */
BIFH_EXPORT void bertec_SetUsbThreadPriority(bertec_Handle bHand,int priority);

/** If there are multiple plates, then this will attempt to detect a missing sync cable.
    Returns 1 if possibly missing. */
BIFH_EXPORT int bertec_GetMayBeMissingSyncCable(bertec_Handle bHand);

/** This will reset the internal sync counters to zero; this is used with dual synced plates */
BIFH_EXPORT int bertec_ResetSyncCounters(bertec_Handle bHand);

/** This will set a callback that is used to sort the device order. By default they are sorted by usb hardware id/connection */
#ifndef bertec_DeviceSortCallback
typedef void (CALLBACK *bertec_DeviceSortCallback)(bertec_TransducerInfo* pInfos,int transducerCount,int* orderArray, void * userData);
#endif
BIFH_EXPORT int bertec_RegisterDeviceSortCallback(bertec_Handle bHand,bertec_DeviceSortCallback, void * userData);
BIFH_EXPORT int bertec_UnregisterDeviceSortCallback(bertec_Handle bHand,bertec_DeviceSortCallback, void * userData);


#ifdef  __cplusplus
   }
#endif

#endif
