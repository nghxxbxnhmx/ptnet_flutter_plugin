package com.example.ptnet_plugin

import com.ftel.ptnetlibrary.services.*
import com.ftel.ptnetlibrary.dto.*
import com.google.gson.Gson
import java.util.concurrent.CompletableFuture

class LibrariesHandler {
    private val gson = Gson()

    fun pingResult(address: String): String {
//        return executeAsync {
            val pingDTO = PingService().execute(address)
            return gson.toJson(pingDTO)
//        }
    }

    fun pageLoadResult(address: String): String {
        return executeAsync {
            val pageLoadResult = PageLoadService().execute(address)
            gson.toJson(pageLoadResult)
        }
    }

    fun dnsLookUpResult(address: String, server: String): String {
        return executeAsync {
            val dnsLookupService = NsLookupService()
            val dnsResults = dnsLookupService.execute(address, server)
            gson.toJson(dnsResults)
        }
    }

    fun portScanResult(address: String, port: Int, timeOut: Int): String {
        return executeAsync {
            val portScanService = PortScanService()
            val scanResult = portScanService.portScan(address, port, timeOut)
            gson.toJson(mapOf("address" to address, "port" to port, "open" to scanResult.isNotEmpty()))
        }
    }

    fun traceRouteEndpoint(address: String): String {
        return executeAsync {
            val tracerouteService = TracerouteService()
            val traceDTO = tracerouteService.getEndPoint(address)
            gson.toJson(traceDTO)
        }
    }

    fun traceRouteResult(address: String, ttl: Int): String {
        return executeAsync {
            val tracerouteService = TracerouteService()
            val traceDTO = tracerouteService.trace(address, ttl)
            gson.toJson(traceDTO)
        }
    }

    fun wifiScanResult(): String {
        return executeAsync {
            val wifiScanService = WifiScanService()
            wifiScanService.startScan()
            val wifiScanResult = wifiScanService.getScanResult()
            gson.toJson(wifiScanResult)
        }
    }

    fun wifiInfo(): String {
        return try {
            val ipConfigService = IpConfigService()
            gson.toJson(ipConfigService.getIpConfigInfo(true))
        } catch (e: Exception) {
            throw RuntimeException("Failed to get wifi info: ${e.message}")
        }
    }

    private fun <T> executeAsync(block: () -> T): String {
        return CompletableFuture.supplyAsync {
            try {
                block()
            } catch (e: Exception) {
                throw RuntimeException("Operation failed: ${e.message}")
            }
        }.get().toString()
    }
}
