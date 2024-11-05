package com.shulian.safe.drm.module.dmap.util;

import cn.hutool.core.util.RuntimeUtil;
import com.shulian.safe.drm.module.dmap.dto.scan.ScanInfoDTO;
import com.shulian.safe.drm.module.dmap.dto.scan.ScanRetDTO;
import com.shulian.safe.drm.module.dmap.enums.SysDbTypeEnum;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 数据探查工具类
 *
 * @company:
 * @author: ZJW
 * @date: 2024/9/13 12:02
 * @version: V1.0
 */
@Slf4j
public class NmapUtil {

    private static final String NMAP_VERSION = "nmap -V";

    private static final String SCAN_SCRIPT = "sudo -S nmap --open -sV -T5 -O -oN - %s -p%s";


    /**
     * 检查nmap是否存在:存在返回true，不存在返回false
     *
     * @return
     */
    public static boolean checkExists() {
        String result = RuntimeUtil.execForStr(NMAP_VERSION);
        log.info("nmap 版本信息：{}", result);

        String r = "nmap: command not found";
        return !result.contains(r);
    }

    /**
     * 扫描
     *
     * @param ip
     * @param port
     * @return
     */
    @SneakyThrows
    public static ScanRetDTO scan(String instanceId, String ip, String port) {
        // 不指定端口,默认全端口扫描
        port = StringUtils.isNotBlank(port) ? port : "1-65535";
        // 执行命令
        String exec = String.format(SCAN_SCRIPT, ip, port);
        log.info("instanceId:{},执行扫描命令：{}", instanceId, exec);

        // String[] cmd = {"sh", "-c", "echo password| " + exec};
        String[] cmd = {"sh", "-c", exec};

        /**
         * 服务器环境用
         */
        String result = RuntimeUtil.execForStr(cmd);

        /**
         * 本地测试用
         */
        // ClassPathResource classPathResource = new ClassPathResource("nmap/162.txt");
        // InputStreamReader inputStreamReader = new InputStreamReader(classPathResource.getInputStream());
        // BufferedReader reader = new BufferedReader(inputStreamReader);
        // // 读取文件内容
        // String result = reader.lines().collect(Collectors.joining(System.lineSeparator()));

        log.info("instanceId:{},nmap 扫描结果文本：{}", instanceId, result);

        List<ScanInfoDTO> scanInfoList = new ArrayList<>();
        // 分割每个ip扫描结果
        Map<String, String> scanMap = analysisScanReport(result);
        // 解析每个 ip 扫结果
        for (Map.Entry<String, String> entry : scanMap.entrySet()) {
            List<ScanInfoDTO> portList = stringToList(entry.getKey(), entry.getValue());
            scanInfoList.addAll(portList);
        }

        // 只保留系统支持的服务类型
        scanInfoList = scanInfoList.stream().filter(e -> {
                    String serverName = e.getServerName();
                    SysDbTypeEnum sysDbType = SysDbTypeEnum.getSysDbTypeEnum(serverName);
                    return sysDbType != null;
                }).map(e -> {
                    String serverPort = e.getPort();
                    // 3306/tcp
                    String[] split = serverPort.split("/");
                    e.setPort(split[0]);
                    return e;
                })
                // ip 端口排序
                .sorted(Comparator.comparing(ScanInfoDTO::getIp).thenComparing(ScanInfoDTO::getPort))
                .collect(Collectors.toList());

        ScanRetDTO scanRet = analysisScanDone(result);
        scanRet.setScanInfoList(scanInfoList);

        // fixme 用有效的数据库数覆盖 nmap原生的主机数
        scanRet.setHostsCount(scanInfoList.size());

        return scanRet;
    }

    /**
     * 切分扫描结果文本串
     *
     * @param processText
     * @return 返回每个ip 的扫描文本
     */
    protected static Map<String, String> analysisScanReport(String processText) {
        log.info(">>> 开始解析扫描结果文本串");
        Map<String, String> resultMap = new LinkedHashMap<>();
        while (processText.contains("Nmap scan report for")) {
            processText = processText.substring(processText.indexOf("Nmap scan report for") + "Nmap scan report for".length());
            String ipTemp = processText.substring(0, processText.indexOf("Host is"));
            ipTemp = ipTemp
                    .replace("bogon", "")
                    .replace("localhost", "")
                    .replace("(", "")
                    .replace(")", "")
                    .trim();

            String resultString;
            int versionIndex = processText.indexOf("VERSION");
            int scanIndex = processText.indexOf("Nmap scan report for");
            if (scanIndex > -1) {
                if (versionIndex > scanIndex) {
                    resultString = processText.substring(0, processText.indexOf("Nmap scan")).trim();
                } else {
                    resultString = processText.substring(versionIndex, processText.indexOf("Nmap scan")).replace("VERSION", "").trim();
                }
            } else {
                resultString = processText.substring(processText.indexOf("VERSION"), processText.indexOf("Nmap done")).replace("VERSION", "").trim();
            }
            resultMap.put(ipTemp, resultString);
        }
        return resultMap;
    }

    /**
     * 解析每个 ip 的扫描结果
     *
     * @param ip        ip
     * @param resultStr 有效的服务信息
     * @return
     */
    protected static List<ScanInfoDTO> stringToList(String ip, String resultStr) {
        if (StringUtils.isBlank(resultStr)) {
            return new ArrayList<>();
        }

        List<ScanInfoDTO> resultList = new ArrayList<>();
        String[] tempStr = resultStr.split("\n");
        for (String str : tempStr) {
            String[] scanArr = str.split(" ");
            if (scanArr.length > 2 && !"unknown".equals(scanArr[scanArr.length - 2])) {
                List<String> scanList = Arrays.asList(scanArr);
                scanList = scanList.stream().filter(StringUtils::isNotBlank).collect(Collectors.toList());

                String port = scanList.get(0);
                String openState = scanList.get(1);
                String service = scanList.get(2);
                String serverName = "";
                if (StringUtils.isNotBlank(service)) {
                    if ("mysql".equals(service)) {
                        String s = scanList.get(4);
                        if (s != null && s.contains("MariaDB")) {
                            serverName = "mariadb";
                        } else if (s != null && s.contains("R7")) {
                            serverName = "gbase8a";
                        } else {
                            serverName = service;
                        }
                    } else if ("oracle-tns".equals(service)) {
                        serverName = "oracle";
                    } else if ("ms-sql-s".equals(service)) {
                        serverName = "sqlserver";
                    } else if ("postgresql".equals(service)) {
                        serverName = "postgresql";
                    } else if ("padl2sim?".equals(service)) {
                        serverName = "dm";
                    } else if ("redis".equals(service)) {
                        serverName = "redis";
                    } else if ("rtsp".equals(service)) {
                        serverName = "elasticsearch";
                    } else if ("pqsq".equals(service)) {
                        serverName = "mongodb";
                    } else if ("wap-wsp".equals(service)) {
                        serverName = "Elasticsearch";
                    } else if ("XmlIpcRegSvc".equals(service)) {
                        serverName = "kafka";
                    } else if ("remoteanything".equals(service)) {
                        serverName = "tidb";
                    }
                    ScanInfoDTO scanInfoDTO = ScanInfoDTO.builder()
                            .ip(ip)
                            .port(port)
                            .openStatus(openState)
                            .serverName(serverName)
                            .build();

                    resultList.add(scanInfoDTO);
                }
            }
        }
        return resultList;
    }


    /**
     * 解析扫描完成信息:扫描的ip数, 扫描的主机个数, 扫描耗时
     *
     * @param processText
     * @return
     */
    protected static ScanRetDTO analysisScanDone(String processText) {
        ScanRetDTO scanRet = new ScanRetDTO();

        log.info(">>> 开始字解析扫描完成信息");
        // 使用换行符分割字符串为行数组
        String[] lines = processText.split("\\n");
        // 从最后一个元素开始遍历到第一个元素
        for (int i = lines.length - 1; i >= 0; i--) {
            // # Nmap done at Thu Sep 12 15:15:34 2024 -- 256 IP addresses (26 hosts up) scanned in 513.16 seconds
            // # Nmap done at Thu Oct 17 10:33:30 2024 -- 1 IP address (1 host up) scanned in 9.22 seconds
            String str = lines[i];
            if (str.contains("# Nmap done at")) {
                log.info("扫描完成信息：{}", str);
                /**
                 * 扫描的 ip 个数
                 */
                String findIpCount = "IP addresses";
                int ipAddressesIndex = str.indexOf(findIpCount);
                if (ipAddressesIndex == -1) {
                    findIpCount = "IP address";
                    ipAddressesIndex = str.indexOf(findIpCount);
                }
                if (ipAddressesIndex > -1) {
                    String indexStr = "--";
                    int index = str.indexOf(indexStr);
                    int indexSub = index + indexStr.length();
                    if (index > -1 && indexSub < ipAddressesIndex) {
                        String ipCount = str.substring(indexSub, ipAddressesIndex);
                        ipCount = ipCount.replace(" ", "");
                        scanRet.setIpCount(Integer.parseInt(ipCount));
                    }
                }

                /**
                 * 发现的主机个数
                 */
                String findHostsCount = "hosts up";
                int hostsCountIndex = str.indexOf(findHostsCount);
                if (hostsCountIndex == -1) {
                    findHostsCount = "host up";
                    hostsCountIndex = str.indexOf(findHostsCount);
                }
                if (hostsCountIndex > -1) {
                    int indexSub = ipAddressesIndex + findIpCount.length();
                    if (indexSub < hostsCountIndex) {
                        String hostsCount = str.substring(indexSub, hostsCountIndex);
                        hostsCount = hostsCount.replace(" ", "")
                                .replace("(", "");
                        scanRet.setHostsCount(Integer.parseInt(hostsCount));
                    }
                }


                /**
                 * 扫描耗时
                 */
                String findSeconds = "seconds";
                int secondsIndex = str.indexOf(findSeconds);
                if (secondsIndex > -1) {
                    String indexStr = "scanned in";
                    int index = str.indexOf(indexStr);
                    int indexSub = index + indexStr.length();
                    if (index > 0 && indexSub < secondsIndex) {
                        String seconds = str.substring(indexSub, secondsIndex);
                        seconds = seconds.replace(" ", "")
                                .replace("(", "");
                        scanRet.setTakeTime(seconds);
                    }
                }
            }
        }
        log.info(">>> 解析扫描完成信息完成,ip个数[{}],主机个数[{}],耗时个数[{}]",
                scanRet.getIpCount(), scanRet.getHostsCount(), scanRet.getTakeTime());
        return scanRet;
    }

}
