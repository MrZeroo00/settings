function FindProxyForURL(url, host)
{
  // variable strings to return
  var proxy_polipo = "PROXY 127.0.0.1:8123";
  var proxy_no     = "DIRECT";

  if (isPlainHostName(host)) {
    return proxy_no;
  }
  if (isInNet(host, "10.0.0.0", "255.0.0.0") ||
      isInNet(host, "127.0.0.0", "255.0.0.0") ||
      isInNet(host, "169.254.0.0", "255.255.0.0") ||
      isInNet(host, "192.168.0.0", "255.255.0.0")) {
    return proxy_no;
  }

  return proxy_polipo;
}
