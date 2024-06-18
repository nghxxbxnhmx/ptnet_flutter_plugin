package com.example.ptnet_plugin


import android.annotation.SuppressLint
import android.content.Context
import android.net.wifi.ScanResult
import android.net.wifi.WifiManager
import android.os.Build
import android.util.Log
import androidx.core.content.getSystemService
import com.ftel.ptnetlibrary.dto.*
import com.ftel.ptnetlibrary.services.*
import com.google.gson.Gson
import org.xbill.DNS.WKSRecord
import java.util.concurrent.*


class LibrariesHandler {
    fun pingResult(address: String): String {
        return CompletableFuture.supplyAsync {
            try {
                val pingdto: PingDTO = PingService().execute(address = address)
                Gson().toJson(pingdto)
            } catch (e: Exception) {
                throw RuntimeException("Failed to load page: ${e.message}")
            }
        }.get().toString()
    }

    fun pageLoadResult(address: String): String {
        return CompletableFuture.supplyAsync {
            try {
                val pageLoadService = PageLoadService()
                pageLoadService.pageLoadTimer(address).toString()
            } catch (e: Exception) {
                throw RuntimeException("Failed to load page: ${e.message}")
            }
        }.get().toString()
    }

    fun dnsLookUpResult(address: String, server: String): String {
        return CompletableFuture.supplyAsync {
            try {
                val dnsLookupService = NsLookupService()
                // Note -> List String
                var dnsResults = ArrayList<String>()
                dnsResults = dnsLookupService.execute(address, server)
                Gson().toJson(dnsResults)
            } catch (e: Exception) {
                throw RuntimeException("Failed to get lookup result: ${e.message}")
            }
        }.get().toString()
    }

    fun portScanResult(address: String, port: Int, timeOut: Int): String {
        return CompletableFuture.supplyAsync {
            try {
                val portScanService = PortScanService()
                val scanResult = portScanService.portScan(address, port, timeOut)
                if (scanResult.isNotEmpty()) {
                    Gson().toJson(mapOf("address" to address, "port" to port, "open" to true))
                } else {
                    Gson().toJson(mapOf("address" to address, "port" to port, "open" to false))
                }
            } catch (e: Exception) {
                throw RuntimeException("Failed to get lookup result: ${e.message}")
            }
        }.get().toString()
    }

    fun traceRouteEndpoint(address: String): String {
        return CompletableFuture.supplyAsync {
            try {
                val tracerouteService = TracerouteService()
                val traceDTO = tracerouteService.getEndPoint(address)
                Gson().toJson(traceDTO)
            } catch (e: Exception) {
                throw RuntimeException("Failed to get end point: ${e.message}")
            }
        }.get().toString()
    }

    fun traceRouteResult(address: String, ttl: Int): String {
        return CompletableFuture.supplyAsync {
            try {
                val tracerouteService = TracerouteService()
                val traceDTO = tracerouteService.trace(address, ttl)
                Gson().toJson(traceDTO)
            } catch (e: Exception) {
                throw RuntimeException("Failed to trace: ${e.message}")
            }
        }.get().toString()
    }

    fun wifiScanResult(): String {
        return CompletableFuture.supplyAsync {
            try {
                val wifiScanService = WifiScanService()
                // Rescan before go again
                wifiScanService.startScan()
                val wifiScanResult = wifiScanService.getScanResult()
                Gson().toJson(wifiScanResult)
            } catch (e: Exception) {
                throw RuntimeException("Failed to wifi scan: ${e.message}")
            }
        }.get().toString()
    }

    fun wifiInfo(): String {
        return try {
            val ipConfigService = IpConfigService()
            Gson().toJson(
                mapOf(
                    "SSID" to ipConfigService.getSSID(),
                    "BSSID" to ipConfigService.getBSSID(),
                    "gateWay" to ipConfigService.getGateway(),
                    "subnetMask" to ipConfigService.getSubnetMask(),
                    "deviceMAC" to ipConfigService.getDeviceMAC(),
                    "ipAddress" to ipConfigService.getIpAddress(true)
                )
            )
        } catch (e: Exception) {
            throw RuntimeException("Failed to get wifi Info: ${e.message}")
        }
    }
}