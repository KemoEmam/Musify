package com.example.musicfy

import android.content.Context
import android.media.AudioManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private lateinit var audioManager: AudioManager

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Initialize the AudioManager
        audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager

        // Set up the MethodChannel and handle method calls from Flutter
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example.musicfy.audioplayer/audiofocus").setMethodCallHandler { call, result ->
            when (call.method) {
                "requestAudioFocus" -> {
                    // Request audio focus for playback
                    val focusRequest = AudioManager.AUDIOFOCUS_GAIN
                    val focusResult = audioManager.requestAudioFocus(null, AudioManager.STREAM_MUSIC, focusRequest)
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
                    audioManager.abandonAudioFocus(null)
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
    }
}