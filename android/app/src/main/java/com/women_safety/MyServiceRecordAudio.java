package com.women_safety;

import android.Manifest;
import android.app.Service;
import android.content.ContentValues;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.media.MediaPlayer;
import android.media.MediaRecorder;
import android.os.Environment;
import android.os.Handler;
import android.os.IBinder;
import android.provider.MediaStore;
import android.widget.Toast;

import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

public class MyServiceRecordAudio extends Service {

    public MyServiceRecordAudio() {
    }

    public String pathSave = "";
    public String fileName = "";
    MediaRecorder mediaRecorder;
    MediaPlayer mediaPlayer;
    private Handler mHandler = new Handler();

    @Override
    public int onStartCommand(Intent intent, int flags, int startId){
        onTaskRemoved(intent);
        pathSave = Environment.getExternalStorageDirectory().getAbsolutePath() + "/" + UUID.randomUUID().toString() + "_audio_record.3gp";
        System.out.println(pathSave);

        setupMediaRecorder();
        try {
            mediaRecorder.prepare();
            mediaRecorder.start();
        } catch (IOException e) {
            System.out.println("Is there an error over here");
            e.printStackTrace();
        }

        Toast.makeText(this, "Recording...", Toast.LENGTH_SHORT).show();

        mHandler.postDelayed(mToastRunnable, 5000);

        return START_STICKY;
    }

    public void setupMediaRecorder() {
        mediaRecorder = new MediaRecorder();
        mediaRecorder.setAudioSource(MediaRecorder.AudioSource.MIC);
        mediaRecorder.setOutputFormat(MediaRecorder.OutputFormat.THREE_GPP);
        mediaRecorder.setAudioEncoder(MediaRecorder.OutputFormat.AMR_NB);
        mediaRecorder.setOutputFile(pathSave);
    }

    private Runnable mToastRunnable = new Runnable() {
        @Override
        public void run() {
            if(mediaRecorder != null) {
                mediaRecorder.stop();
                mediaRecorder.reset();
                mediaRecorder.release();
                System.out.println("Audio Stopped Recording");
            }
        }
    };

    @Override
    public IBinder onBind(Intent intent) {
        // TODO: Return the communication channel to the service.
        throw new UnsupportedOperationException("Not yet implemented");
    }
}
