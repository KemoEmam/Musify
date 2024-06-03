package com.example.musicfy

import android.content.Context
import android.media.AudioManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import android.media.AudioAttributes
import android.media.AudioFocusRequest

class MainActivity: FlutterActivity() {
       private lateinit var audioManager: AudioManager
       private lateinit var focusRequest: AudioFocusRequest

       override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
           super.configureFlutterEngine(flutterEngine)
           // Initialize the AudioManager
           audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager

           // Set up the MethodChannel and handle method calls from Flutter
           MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example.musicfy.audioplayer/audiofocus").setMethodCallHandler { call, result ->
               when (call.method) {
                   "requestAudioFocus" -> {
                       // Create AudioAttributes
                       val audioAttributes = AudioAttributes.Builder()
                           .setUsage(AudioAttributes.USAGE_MEDIA)
                           .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                           .build()

                       // Create AudioFocusRequest
                       focusRequest = AudioFocusRequest.Builder(AudioManager.AUDIOFOCUS_GAIN)
                           .setAudioAttributes(audioAttributes)
                           .setAcceptsDelayedFocusGain(true)
                           .setOnAudioFocusChangeListener { }
                           .build()

                       // Request audio focus
                       val focusResult = audioManager.requestAudioFocus(focusRequest)
                       if (focusResult == AudioManager.AUDIOFOCUS_REQUEST_GRANTED) {
                           // Audio focus granted
                           result.success(true)
                       } else {
                           // Failed to gain audio focus
                           result.success(false)
                       }
                   }
                   "abandonAudioFocus" -> {
                       // Abandon audio focus
                       audioManager.abandonAudioFocusRequest(focusRequest)
                       result.success(true)
                   }
                   else -> result.notImplemented()
               }
           }
       }
   }